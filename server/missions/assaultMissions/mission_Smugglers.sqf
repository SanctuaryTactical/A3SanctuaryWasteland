// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_Smugglers.sqf
//	@file Author: JoSchaap, AgentRev, LouD
#include "assaultMissionDefines.sqf";

if (!isServer) exitwith {};

private ["_positions", "_player", "_players", "_vtype", "_vehicle1", "_vehicle2", "_radar", "_boxes", "_cashrandomizera", "_cashamountrandomizera", "_cashpilerandomizera", "_casha", "_cashamounta", "_cashpilea", "_cashrandomizerb", "_cashamountrandomizerb", "_cashpilerandomizerb", "_cashb", "_cashamountb", "_cashpileb", "_cash1", "_cash2"];

_setupVars = {

	_missionType = "Weapon Smugglers";
	_locationsArray = MissionSpawnMarkers;

};

_setupObjects = {

	_missionPos = markerPos _missionLocation;
	_vtype = [ST_HUNTER_GMG,ST_HUNTER_HMG,ST_STRIDER_GMG,ST_STRIDER_HMG,ST_IFRIT_GMG,ST_IFRIT_HMG] call BIS_fnc_selectRandom;

	_vehicle1 = [_vtype,[(_missionPos select 0) - 5, (_missionPos select 1) + 10,0],0.5,1,0,"NONE"] call createMissionVehicle;
	_vehicle1 setVehicleReportRemoteTargets true;
	_vehicle1 setVehicleReceiveRemoteTargets true;
	_vehicle1 setVehicleRadar 1;
	_vehicle1 confirmSensorTarget [west, true];
	_vehicle1 confirmSensorTarget [east, true];
	_vehicle1 confirmSensorTarget [resistance, true];
	_vehicle1 setVariable [call vChecksum, true, false];
	_vehicle1 setFuel 1;
	_vehicle1 setVehicleLock "UNLOCKED";
	_vehicle1 setVariable ["R3F_LOG_disabled", false, true];

	_vehicle2 = [_vtype,[(_missionPos select 0) - 5, (_missionPos select 1) - 10,0],0.5,1,0,"NONE"] call createMissionVehicle;
	_vehicle2 setVehicleReportRemoteTargets true;
	_vehicle2 setVehicleReceiveRemoteTargets true;
	_vehicle2 setVehicleRadar 1;
	_vehicle2 confirmSensorTarget [west, true];
	_vehicle2 confirmSensorTarget [east, true];
	_vehicle2 confirmSensorTarget [resistance, true];
	_vehicle2 setVariable [call vChecksum, true, false];
	_vehicle2 setFuel 1;
	_vehicle2 setVehicleLock "UNLOCKED";
	_vehicle2 setVariable ["R3F_LOG_disabled", false, true];

	/* _radar = nil;

	//20 > random 100
	//which has 20% change of being true. If you want a 71% change you would use this:
	//71 > random 100
	//5% chance of getting radar system
	//if( 5 > random 100 ) then {


	//};

	_radar = createVehicle [ST_RADAR_SYSTEM, _missionPos, [], 0, "NONE"];

	{_radar deleteVehicleCrew _x} forEach crew _radar;

	_radar setVariable ["R3F_LOG_disabled", true, true];

	[_radar] call vehicleSetup; */

	_boxes = [_missionLocation, [1,4], false, true] call STRandomCratesReward;

	_aiGroup = createGroup CIVILIAN;
	[_aiGroup, _missionPos] spawn createsmugglerGroup;

	_aiGroup setCombatMode "RED";
	_aiGroup setBehaviour "COMBAT";

	_missionPicture = getText (configFile >> "CfgVehicles" >> _vtype >> "picture");

	_missionHintText = format ["A group of weapon smugglers have been spotted. Stop the weapon deal and take their weapons and money.", assaultMissionColor];
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = nil;

// Mission failed
_failedExec = {

	{ deleteVehicle _x } forEach _boxes;
	{ deleteVehicle _x } forEach [_vehicle1, _vehicle2];

	if (!(isNil "_radar")) then { deleteVehicle _radar; };

};

// Mission completed
_successExec = {

	{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach _boxes;
	{ _x setVariable ["A3W_missionVehicle", true] } forEach [_vehicle1, _vehicle2];

	//Create FN: STRandomCashReward
	[_missionLocation, [10000,20000,30000,40000]] call STRandomCashReward;

	/* if (!(isNil "_radar")) then {

		_radar setVariable ["R3F_LOG_disabled", false, true];

		// Mission completed
		[_radar, 1] call A3W_fnc_setLockState; // Unlock

		_players = nearestObjects [_radar, ["Man"], 1000];
		_player = nil;

		_player = {

			if( isPlayer _x) exitWith { _player = _x; }

		} forEach _players;

		if( !(isNil "_player") ) then {

			diag_log format ["[1ST] Smugglers near players %1", name _player];


			diag_log format ["[1ST] Setting object owner"];

			(group _radar) setGroupOwner (owner _player);

		};

	}; */

	/* 11:54:39 Error in expression < = [];
	{
	if (_x distance _radar) <= 1000) then {
	_players pushback _x;
	};
	} fore>
	11:54:39   Error position: <) then {
	_players pushback _x;
	};
	} fore>
	11:54:39   Error Missing ;
	11:54:39 File mpmissions\__cur_mp.Altis\server\missions\assaultMissions\mission_Smugglers.sqf, line 112
	11:54:39 Error in expression < = [];
	{
	if (_x distance _radar) <= 1000) then {
	_players pushback _x;
	};
	} fore>
	11:54:39   Error position: <) then {
	_players pushback _x;
	}; */

	_successHintMessage = format ["The smugglers are dead, the weapons and money are yours!"];

};

_this call assaultMissionProcessor;
