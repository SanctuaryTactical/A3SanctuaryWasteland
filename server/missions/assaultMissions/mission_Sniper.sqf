// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_Sniper.sqf
//	@file Author: JoSchaap, AgentRev, LouD

if (!isServer) exitwith {};
#include "assaultMissionDefines.sqf";

#define reward 25000

private ["_positions", "_boxes1", "_currBox1", "_box1", "_box2", "_box3", "_cash"];

_setupVars =
{
	_missionType = "Sniper Nest";
	_locationsArray = SniperMissionMarkers;
};

_setupObjects =
{
	_missionPos = markerPos _missionLocation;

	_aiGroup = createGroup CIVILIAN;
	[_aiGroup,_missionPos] spawn createsniperGroup;

	_aiGroup setCombatMode "RED";
	_aiGroup setBehaviour "COMBAT";

	_missionHintText = format ["A Sniper Nest has been spotted. Head to the marked area and Take them out! Be careful they are fully armed and dangerous!", assaultMissionColor];
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = nil;

_failedExec =
{
	// Mission failed
};

_successExec =
{
	// Mission completed

	_box1 = createVehicle ["Box_IND_WpsSpecial_F", _missionPos, [], 5, "NONE"];
	_box1 setDir random 360;
	//[_box1, "mission_Main_A3snipers"] call fn_refillbox;
	[_box1, "mission_Main_A3snipers"] call randomCrateLoadOut;

	_box2 = createVehicle ["Box_NATO_WpsSpecial_F", _missionPos, [], 5, "NONE"];
	_box2 setDir random 360;
	//[_box2, "mission_USSpecial2"] call fn_refillbox;
	[_box2, "mission_USSpecial2"] call randomCrateLoadOut;

	_box3 = createVehicle ["Box_NATO_WpsSpecial_F", _missionPos, [], 5, "NONE"];
	_box3 setDir random 360;
	//[_box2, "mission_USSpecial2"] call fn_refillbox;
	[_box3, "mission_USSpecial2"] call randomCrateLoadOut;

/*
	_boxes1 = ["Box_East_WpsSpecial_F","Box_IND_WpsSpecial_F"];
	_currBox1 = _boxes1 call BIS_fnc_selectRandom;
	_box1 = createVehicle [_currBox1, _lastPos, [], 2, "NONE"];
	_box1 allowDamage false;
*/
	_box1 setVariable ["R3F_LOG_disabled", false, true];
	_box2 setVariable ["R3F_LOG_disabled", false, true];
	_box3 setVariable ["R3F_LOG_disabled", false, true];

	for "_x" from 1 to 10 do
	{
		_cash = "Land_Money_F" createVehicle markerPos _marker;
		_cash setPos ((markerPos _marker) vectorAdd ([[2 + random 2,0,0], random 360] call BIS_fnc_rotateVector2D));
		_cash setDir random 360;
		_cash setVariable ["cmoney", reward / 10, true];
		_cash setVariable["owner","world",true];
	};

	_successHintMessage = format ["The snipers are dead! Well Done!"];
};

_this call assaultMissionProcessor;
