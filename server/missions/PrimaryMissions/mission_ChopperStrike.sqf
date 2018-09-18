// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_cargoContainer.sqf
//	@file Author: The Scotsman

if (!isServer) exitwith {};
#include "PrimaryMissionDefines.sqf";

private ["_transport", "_transports", "_attacks", "_escorts", "_scouts", "_attack","_escort", "_scout", "_pos", "_pos1", "_pos2", "_pos3", "_vehicles", "_leader", "_speedMode", "_waypoint", "_vehicleName", "_numWaypoints", "_cash", "_box1", "_box2", "_box3", "_box4", "_box5", "_box6", "_currBox1", "_currBox2", "_currBox3"];

_setupVars = {
	_missionType = "Chopper Strike";
	_locationsArray = nil; // locations are generated on the fly from towns
};

_transports = [ST_C130, ST_CHINOOK];

_attacks = [
	ST_BLACKFOOT,
	ST_KAJMAN,
	ST_APACHE,
	ST_APACHE_GREY,
	ST_APACHE_NORADAR,
	ST_COBRA
];

_scouts = [
	ST_PAWNEE,
	ST_ORCA,
	ST_HELLCAT,
	ST_LITTLE_BIRD,
	ST_LITTLE_BIRD,
	ST_LITTLE_BIRD,
	ST_LITTLE_BIRD
];

_escorts = [
	ST_HELLCAT,
	ST_VENOM1,
	ST_VENOM2,
	ST_BLACKHAWK
];

_attack = _attacks call BIS_fnc_selectRandom;
_scout = _scouts call BIS_fnc_selectRandom;
_escort = _escorts call BIS_fnc_selectRandom;
_transport = _transports call BIS_fnc_selectRandom;

_setupObjects = {

	_missionPos = markerPos (((call cityList) call BIS_fnc_selectRandom) select 0);

	_aiGroup = createGroup CIVILIAN;
	_vehicles =
	[
		[_transport, _missionPos vectorAdd ([[random 50, 0, 0], random 100] call BIS_fnc_rotateVector2D), 0, _aiGroup] call STCreateVehicle,
		[_transport, _missionPos vectorAdd ([[random 250, 0, 0], random 400] call BIS_fnc_rotateVector2D), 0, _aiGroup] call STCreateVehicle,
    [_attack, _missionPos vectorAdd ([[random 350, 0, 0], random 100] call BIS_fnc_rotateVector2D), 0, _aiGroup] call STCreateVehicle,
		[_attack, _missionPos vectorAdd ([[random 450, 0, 0], random 400] call BIS_fnc_rotateVector2D), 0, _aiGroup] call STCreateVehicle,
		[_attack, _missionPos vectorAdd ([[random 550, 0, 0], random 600] call BIS_fnc_rotateVector2D), 0, _aiGroup] call STCreateVehicle,
		[_scout, _missionPos vectorAdd ([[random 750, 0, 0], random 400] call BIS_fnc_rotateVector2D), 0, _aiGroup] call STCreateVehicle,
		[_scout, _missionPos vectorAdd ([[random 850, 0, 0], random 600] call BIS_fnc_rotateVector2D), 0, _aiGroup] call STCreateVehicle,
    [_scout, _missionPos vectorAdd ([[random 950, 0, 0], random 100] call BIS_fnc_rotateVector2D), 0, _aiGroup] call STCreateVehicle,
		[_escort, _missionPos vectorAdd ([[random 750, 0, 0], random 600] call BIS_fnc_rotateVector2D), 0, _aiGroup] call STCreateVehicle,
    [_escort, _missionPos vectorAdd ([[random 850, 0, 0], random 600] call BIS_fnc_rotateVector2D), 0, _aiGroup] call STCreateVehicle,
    [_escort, _missionPos vectorAdd ([[random 950, 0, 0], random 600] call BIS_fnc_rotateVector2D), 0, _aiGroup] call STCreateVehicle
  ];

	_aiGroup setCombatMode "RED";
	_aiGroup setBehaviour "COMBAT";
	_aiGroup setFormation "VEE";

	_leader = effectiveCommander (_vehicles select 0);
	_aiGroup selectLeader _leader;
	_leader setRank "LIEUTENANT";

	_speedMode = "NORMAL";

	// behaviour on waypoints
	{
		_waypoint = _aiGroup addWaypoint [markerPos (_x select 0), 0];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointCompletionRadius 55;
		_waypoint setWaypointCombatMode "RED";
		_waypoint setWaypointBehaviour "COMBAT";
		_waypoint setWaypointFormation "VEE";
		_waypoint setWaypointSpeed "NORMAL";
	} forEach ((call cityList) call BIS_fnc_arrayShuffle);

	_missionPos = getPosATL leader _aiGroup;

	_missionPicture = getText (configFile >> "CfgVehicles" >> _attack >> "picture");
	_vehicleName = getText (configFile >> "CfgVehicles" >> _attack >> "displayName");
	_missionHintText = "A formation of armed helicopters are conducting an air strike on an undisclosed location.  Stop them!";

	_numWaypoints = count waypoints _aiGroup;
};

_waitUntilMarkerPos = {getPosATL _leader};
_waitUntilExec = nil;
_waitUntilCondition = {currentWaypoint _aiGroup >= _numWaypoints};

_failedExec = nil;

// _vehicles are automatically deleted or unlocked in missionProcessor depending on the outcome
_successExec = {

	_pos = getMarkerPos _marker;

	//Cash
	[_marker, [20000, 40000, 60000, 80000]] call STRandomCashReward;

	//Crates
	[_marker, [2, 10]] call STRandomCratesReward;

	_successHintMessage = "The Chopper Strike has been averted.  Cargo has been dropped by the last vehicle";

};

_this call PrimaryMissionProcessor;
