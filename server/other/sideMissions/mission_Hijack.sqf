// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 2
//	@file Name: mission_Escobar.sqf
//	@file Author: Spectryx 
//	@file Tanoa Edit: GriffinZS, soulkobk 
//	@file Created: Sep 2016

if (!isServer) exitwith {};
#include "sideMissionDefines.sqf";

private ["_missionVehicle","_dropMoney","_dropPos"];

_setupVars =
{
	_missionType = "Hijack!";
    _dropMoney = 50000;
};

_setupObjects =
{
    _missionVehicles = selectRandom ["C_Hatchback_01_sport_F"];
	_missionLocation = selectRandom ["Race_1", "Race_2", "Race_3", "Race_4", "Race_5", "Race_6"];
    _dropOffLocation = selectRandom ["dropOff_1", "dropOff_2", "dropOff_3", "dropOff_4", "dropOff_5", "dropOff_6"];
	
	_missionPos = markerPos _missionLocation;
	_dropOffPos = markerPos _dropOffLocation;
	_missionVehicle = createVehicle [_missionVehicles, _missionPos, [], 5, "None"]; // create the vehicle at the mission position
	_missionVehicle setDir (markerDir _missionLocation); // you don't really need this line (it sets the direction of the vehicle to the direction of the marker), delete it.
	
	// added by soulkobk
	[_missionVehicle,_dropOffPos] spawn { // spawn new thread for activation of _dropOffPos marker once player is in _missionVehicle
	params ["_missionVehicle","_dropOffPos"];
	waitUntil {(!isNull (driver _missionVehicle)) || (!alive _missionVehicle)}; // this line waits until a unit is in the driver seat of _missionVehicle or the _missionVehicle is dead/destroyed
	_vehName = gettext (configFile >> "CfgVehicles" >> (typeOf vehicle _missionVehicle) >> "displayName"); // get vehicle display name eg, 'MB 4WD'
	if (alive _missionVehicle) then // if _missionVehicle is still alive then create marker, else do nothing (exit thread).
	{
		_dropMarker = createMarker ["DropOff", _dropOffPos]; // create 'drop off' marker on _dropOffPos
		_dropMarker setMarkerType "hd_end";
		_dropMarker setMarkerShape "ICON";
		_dropMarker setMarkerSize [0.5, 0.5];
		_dropMarker setMarkerText "Hijack - Drop Off Vehicle"];
		//_dropMarker setMarkerText format ["DESTINATION FOR %1",_vehName]; // you don't really need this line, uncomment the above line, delete this one.
		_dropMarker setMarkerColor "ColorRed";
		hint format ["THE STEALCAR %1\nHAS A DRIVER %2, CHECK MAP!",_vehName, name (driver _missionVehicle)]; // you don't really need this line, delete it.
	} // you don't really need this line, delete it.
	else // you don't really need this line, delete it.
	{ // you don't really need this line, delete it.
		hint format ["THE STEALCAR %1\nWAS DESTROYED!\nMISSION FAILED!",_vehName]; // you don't really need this line, delete it.
	};
	waitUntil {(!alive _missionVehicle)}; // waits for the vehicle to not exist anymore (destroyed or successful mission)
	deleteMarker "DropOff"; // deletes the "DropOff" _dropMarker (see above line)
	};
	////////////////////
		
  
    _missionHintText = format ["Hijack the vehicle and deliver it to it's destination marker.", sideMissionColor];
	
};

_ignoreAiDeaths = true;
_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = {!alive_missionVehicle}; // changed by soulkobk - if vehicle is no longer alive (destroyed) then mission fail
_waitUntilSuccessCondition = {(_missionVehicle distance _dropPos) <5}; // if vehicle is less than 5 meters from the drop off position then mission successful

_failedExec =
{
	{ deleteVehicle _x } forEach [_missionVehicle];
	deleteMarker "DropOff";
};

_successExec =
{

	for "_x" from 1 to 10 do
	{
		_cash = "Land_Money_F" createVehicle markerPos _marker;
		_cash setPos ((markerPos _marker) vectorAdd ([[2 + random 2,0,0], random 360] call BIS_fnc_rotateVector2D));
		_cash setDir random 360;
		_cash setVariable["cmoney",50000,true];
		_cash setVariable["owner","world",true];
	};


    { deleteVehicle _x } forEach _missionVehicle];
    deleteMarker "DropOff";
   
    _successHintMessage = "Well done, You have delivered as promised! Take your reward.";
};

_this call sideMissionProcessor;