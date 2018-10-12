// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_Sniper.sqf
//	@file Author: JoSchaap, AgentRev, LouD

if (!isServer) exitwith {};
#include "mainMissionDefines.sqf";

private ["_positions", "_boxes1", "_currBox1", "_box1"];

_setupVars =
{
	_missionType = "Sniper Nest";
	_positions = [[17651.5,11707.6,0], [4864.88,21900.6,0], [9544.29,15727.7,0], [24815.3,21781.2,0], [20683.7,6003.94,0], [14212.9,21211.5,0], [11209.7,8723.37,0], [3171.24,13162.5,0]];

	_missionPos = _positions call BIS_fnc_SelectRandom;
};

_setupObjects =
{
	_aiGroup = createGroup CIVILIAN;
	[_aiGroup,_missionPos] spawn createsniperGroup;

	_aiGroup setCombatMode "RED";
	_aiGroup setBehaviour "COMBAT";

	_missionHintText = format ["A Sniper Nest has been spotted. Head to the marked area and Take them out! Be careful they are fully armed and dangerous!", mainMissionColor];
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

	_boxes1 = ["Box_East_WpsSpecial_F","Box_IND_WpsSpecial_F"];
	_currBox1 = _boxes1 call BIS_fnc_selectRandom;
	_box1 = createVehicle [_currBox1, _lastPos, [], 2, "None"];
	_box1 allowDamage false;
	_box1 setVariable ["moveable", true, true];
	_box1 setVariable ["R3F_LOG_disabled", false, true];
	{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach [_box1];

	_successHintMessage = format ["The snipers are dead! Well Done!"];
};

_this call mainMissionProcessor;
