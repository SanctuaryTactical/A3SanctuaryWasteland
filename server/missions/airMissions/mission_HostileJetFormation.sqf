// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_HostileJetFormation.sqf
//	@file Author: JoSchaap, AgentRev, LouD

#include "airMissionDefines.sqf"

if (!isServer) exitwith {};

private ["_class", "_count", "_veh", "_vehicles", "_createVehicle", "_leader", "_speedMode", "_waypoint", "_vehicleName", "_vehicleName2", "_numWaypoints"];

_setupVars =
{
	_missionType = "Hostile Jets";
	_locationsArray = nil; // locations are generated on the fly from towns
};

_setupObjects = {

	_missionPos = markerPos (((call cityList) call BIS_fnc_selectRandom) select 0);

	_class = [ST_A10,ST_F22,ST_BLACK_WASP,ST_WIPEOUT,ST_NEOPHRON,ST_SHIKRA,ST_BUZZARD,ST_GRYPHON] call BIS_fnc_selectRandom;
	_count = [2,4] call BIS_fnc_randomInt;

	_createVehicle = {

		private ["_type","_position","_direction","_vehicle","_soldier"];

		_type = _this select 0;
		_position = _this select 1;
		_direction = _this select 2;

		_vehicle = createVehicle [_type, _position, [], 0, "FLY"]; // Added to make it fly
		_vehicle setVariable ["R3F_LOG_disabled", true, true];
		_vel = [velocity _vehicle, -(_direction)] call BIS_fnc_rotateVector2D; // Added to make it fly
		_vehicle setDir _direction;
		_vehicle setVelocity _vel; // Added to make it fly
		_vehicle setVariable [call vChecksum, true, false];
		_aiGroup addVehicle _vehicle;

		// add pilot
		_soldier = [_aiGroup, _position] call createRandomPilot;
		_soldier moveInDriver _vehicle;

		[_vehicle, _aiGroup] spawn checkMissionVehicleLock;
		_vehicle

	};

	_aiGroup = createGroup CIVILIAN;

	_vehicles = [];

	for "_x" from 1 to _count do {

		_veh = [_class, _missionPos vectorAdd ([[random 50, 0, 0], random 360] call BIS_fnc_rotateVector2D), 0] call _createVehicle;
		_vehicles set [_x - 1, _veh];

	};

	_leader = effectiveCommander (_vehicles select 0);
	_aiGroup selectLeader _leader;
	_leader setRank "LIEUTENANT";

	_aiGroup setCombatMode "RED";
	_aiGroup setBehaviour "COMBAT";
	_aiGroup setFormation "LINE";

	_speedMode = if (missionDifficultyHard) then { "NORMAL" } else { "LIMITED" };

	_aiGroup setSpeedMode _speedMode;

	// behaviour on waypoints
	{
		_waypoint = _aiGroup addWaypoint [markerPos (_x select 0), 0];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointCompletionRadius 50;
		_waypoint setWaypointCombatMode "GREEN";
		_waypoint setWaypointBehaviour "SAFE";
		_waypoint setWaypointFormation "VEE";
		_waypoint setWaypointSpeed _speedMode;
	} forEach ((call cityList) call BIS_fnc_arrayShuffle);

	_missionPos = getPosATL leader _aiGroup;

	_missionPicture = getText (configFile >> "CfgVehicles" >> _class >> "picture");
	_vehicleName = getText (configFile >> "CfgVehicles" >> _class >> "displayName");
	_vehicleName2 = getText (configFile >> "CfgVehicles" >> _class >> "displayName");

	_missionHintText = format ["A formation of Jets containing at least two <t color='%3'>%1</t> are patrolling the island. Destroy them and recover their cargo!", _vehicleName, _vehicleName2, airMissionColor];

	_numWaypoints = count waypoints _aiGroup;
};

_waitUntilMarkerPos = {getPosATL _leader};
_waitUntilExec = nil;
_waitUntilCondition = {currentWaypoint _aiGroup >= _numWaypoints};

_failedExec = nil;

// _vehicles are automatically deleted or unlocked in missionProcessor depending on the outcome
_successExec = {

	//Money
	[_marker, [50000, 50000, 50000, 60000, 80000]] call STRandomCashReward;
	[(getMarkerPos _marker), [2, 4], true] call STRandomCratesReward;

	_successHintMessage = "The sky is clear again, the enemy patrol was taken out! Ammo crates and some money have fallen near the pilot.";

};

_this call airMissionProcessor;
