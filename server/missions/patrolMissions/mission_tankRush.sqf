// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_artyPatrol.sqf
//	@file Author: WitchDoctor [GGO]

if (!isServer) exitwith {};
#include "patrolMissionDefines.sqf";

private ["_types", "_typeA", "_typeB", "_typeC", "_typeD", "_vehiclePosArray", "_vehicles", "_leader", "_speedMode", "_waypoint", "_vehicleName", "_vehicleName2", "_vehicleName3", "_numWaypoints"];

_setupVars =
{
	_missionType = "Tank Rush";
	_locationsArray = nil;

};

_types = [ST_KUMA, ST_VARSUK, ST_SLAMMER, ST_SLAMMER_UP, ST_ABRAMSM1, ST_ABRAMSM1_TUSK, ST_T140_ANGARA, ST_T140_ANGARA_COMMANDER];

_typeA = _types call BIS_fnc_selectRandom;
_typeB = _types call BIS_fnc_selectRandom;
_typeC = _types call BIS_fnc_selectRandom;
_typeD = _types call BIS_fnc_selectRandom;

_setupObjects = {

	_town = (call cityList) call BIS_fnc_selectRandom;
	_missionPos = markerPos (_town select 0);

	_aiGroup = createGroup CIVILIAN;

	_rad = _town select 1;
	_vehiclePosArray = [_missionPos,_rad,_rad + 75,10,0,0,0] call findSafePos;

	_vehicles = [
		[_typeA, _vehiclePosArray, 0, _aiGroup] call STCreateVehicle,
		[_typeB, _vehiclePosArray, 0, _aiGroup] call STCreateVehicle,
		[_typeC, _vehiclePosArray, 0, _aiGroup] call STCreateVehicle,
		[_typeD, _vehiclePosArray, 0, _aiGroup] call STCreateVehicle,
		[_typeA, _vehiclePosArray, 0, _aiGroup] call STCreateVehicle,
		[_typeB, _vehiclePosArray, 0, _aiGroup] call STCreateVehicle,
		[_typeC, _vehiclePosArray, 0, _aiGroup] call STCreateVehicle,
		[_typeD, _vehiclePosArray, 0, _aiGroup] call STCreateVehicle,
		[_typeA, _vehiclePosArray, 0, _aiGroup] call STCreateVehicle,
		[_typeB, _vehiclePosArray, 0, _aiGroup] call STCreateVehicle
	];

	_leader = effectiveCommander (_vehicles select 0);
	_aiGroup selectLeader _leader;
	_leader setRank "LIEUTENANT";

	_aiGroup setCombatMode "YELLOW"; // units will defend themselves
	_aiGroup setBehaviour "SAFE"; // units feel safe until they spot an enemy or get into contact
	_aiGroup setFormation "STAG COLUMN";

	_speedMode = if (missionDifficultyHard) then { "NORMAL" } else { "LIMITED" };

	_aiGroup setSpeedMode _speedMode;

	{
		_waypoint = _aiGroup addWaypoint [markerPos (_x select 0), 0];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointCompletionRadius 50;
		_waypoint setWaypointCombatMode "YELLOW";
		_waypoint setWaypointBehaviour "SAFE"; // safe is the best behaviour to make AI follow roads, as soon as they spot an enemy or go into combat they WILL leave the road for cover though!
		_waypoint setWaypointFormation "FILE";
		_waypoint setWaypointSpeed _speedMode;
	} forEach ((call cityList) call BIS_fnc_arrayShuffle);

	_missionPos = getPosATL leader _aiGroup;

	_missionPicture = getText (configFile >> "CfgVehicles" >> _typeA >> "picture");
	_vehicleName = getText (configFile >> "CfgVehicles" >> _typeA >> "displayName");
	_vehicleName2 = getText (configFile >> "CfgVehicles" >> _typeB >> "displayName");
	_vehicleName3 = getText (configFile >> "CfgVehicles" >> _typeC >> "displayName");

	_missionHintText = format ["A large group of tanks containing at least a <t color='%4'>%1</t>, a <t color='%4'>%2</t> and a <t color='%4'>%3</t> is blizting a random location on the island! Stop the tanks and collect the high value weapons crate and money!", _vehicleName, _vehicleName2, _vehicleName3, patrolMissionColor];

	_numWaypoints = count waypoints _aiGroup;

};

_waitUntilMarkerPos = {getPosATL _leader};
_waitUntilExec = nil;
_waitUntilCondition = {currentWaypoint _aiGroup >= _numWaypoints};

_failedExec = nil;

// _vehicles are automatically deleted or unlocked in missionProcessor depending on the outcome
_successExec = {

	//A random (possible large)cash reward
	[_marker, [20000,30000,30000,30000,30000,40000,80000]] call STRandomCashReward;

	//Random Number of Crates
	[(getMarkerPos _marker), [1, 4]] call STRandomCratesReward;

	_successHintMessage = "All tanks have been stopped, the money, crates and vehicles are yours to take.";
};

_this call PatrolMissionProcessor;
