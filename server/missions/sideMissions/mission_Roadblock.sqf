// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright � 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_Roadblock.sqf
//	@file Author: JoSchaap, AgentRev, LouD

if (!isServer) exitwith {};
#include "sideMissionDefines.sqf";

private [ "_box1", "_barGate", "_bunker1","_bunker2","_obj1","_obj2"];

_setupVars =
{
	_missionType = "Roadblock";
	_locationsArray = RoadblockMissionMarkers;
};

_setupObjects =
{
	_missionPos = markerPos _missionLocation;
	_markerDir = markerDir _missionLocation;

	//delete existing base parts and vehicles at location
	_baseToDelete = nearestObjects [_missionPos, ["All"], 25];
	{ deleteVehicle _x } forEach _baseToDelete;

	_bargate = createVehicle ["Land_BarGate_F", _missionPos, [], 0, "NONE"];
	_bargate setDir _markerDir;
	_bunker1 = createVehicle ["Land_BagBunker_Small_F", _bargate modelToWorld [6.5,-2,-4.1], [], 0, "NONE"];
	_obj1 = createVehicle ["I_GMG_01_high_F", _bargate modelToWorld [6.5,-2,-4.1], [], 0, "NONE"];
	_bunker1 setDir _markerDir;
	_bunker2 = createVehicle ["Land_BagBunker_Small_F", _bargate modelToWorld [-8,-2,-4.1], [], 0, "NONE"];
	_obj2 = createVehicle ["I_GMG_01_high_F", _bargate modelToWorld [-8,-2,-4.1], [], 0, "NONE"];
	_bunker2 setDir _markerDir;

	_aiGroup = createGroup CIVILIAN;
	[_aiGroup,_missionPos,12,15] spawn createCustomGroup3;

	_missionHintText = format ["Enemies have set up an illegal roadblock and are stopping all vehicles! They need to be stopped!", sideMissionColor];
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = nil;

_failedExec =
{
	// Mission failed

	{ deleteVehicle _x } forEach [_barGate, _bunker1, _bunker2, _obj1, _obj2];

};

_successExec =
{
	// Mission completed

	_randomBox = ["mission_USLaunchers","mission_USSpecial","mission_Main_A3snipers"] call BIS_fnc_selectRandom;
	_box1 = createVehicle ["Box_NATO_Wps_F", _missionPos, [], 5, "NONE"];
	_box1 setDir random 360;
	//[_box1, _randomBox] call fn_refillbox;
	[_box1, _randomBox] call randomCrateLoadOut;
	{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach [_box1, _obj1, _obj2];
	{ deleteVehicle _x } forEach [_barGate, _bunker1, _bunker2];
	{ _x setVariable ["allowDamage", true, true] } forEach [_obj1, _obj2];

	for "_x" from 1 to 10 do
	{
		_cash = "Land_Money_F" createVehicle markerPos _marker;
		_cash setPos ((markerPos _marker) vectorAdd ([[2 + random 2,0,0], random 360] call BIS_fnc_rotateVector2D));
		_cash setDir random 360;
		_cash setVariable["cmoney",7500,true];
		_cash setVariable["owner","world",true];
	};

	_successHintMessage = format ["The roadblock has been dismantled."];
};

_this call sideMissionProcessor;
