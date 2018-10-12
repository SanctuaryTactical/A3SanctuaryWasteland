// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_HostileHeliFormation.sqf
//	@file Author: JoSchaap, AgentRev

if (!isServer) exitwith {};
#include "airMissionDefines.sqf"

private ["_type", "_leader", "_speedMode", "_waypoint", "_vehicle", "_vehicles", "_vehicleName", "_vehicleName2", "_numWaypoints", "_box1", "_box2", "_box3", "_count"];

_setupVars = {
	_missionType = "Hostile Helicopters";
	_locationsArray = nil; // locations are generated on the fly from towns
};

_setupObjects = {

	_missionPos = markerPos (((call cityList) call BIS_fnc_selectRandom) select 0);

	_type = [ST_BLACKHAWK, ST_LITTLE_BIRD,ST_APACHE,ST_APACHE,ST_APACHE,ST_APACHE_GREY,ST_APACHE_GREY,ST_APACHE_GREY,ST_APACHE_GREY,ST_VENOM1,ST_VENOM1, ST_COBRA,ST_COBRA,ST_COBRA,ST_BLACKFOOT,ST_KAJMAN,ST_PAWNEE,ST_PAWNEE, ST_ORCA,ST_HELLCAT] call BIS_fnc_selectRandom;
	_count = [2,4] call BIS_fnc_randomInt;

	_aiGroup = createGroup CIVILIAN;

	_vehicles = [];

	for "_x" from 1 to _count do {

		_vehicle = [_type, _missionPos vectorAdd ([[random 100, 0, 0], random 360] call BIS_fnc_rotateVector2D), 0, _aiGroup] call STCreateVehicle;
		_vehicles set [_x - 1, _vehicle];

	};

	_leader = effectiveCommander (_vehicles select 0);
	_aiGroup selectLeader _leader;

	_aiGroup setCombatMode "YELLOW"; // units will defend themselves
	_aiGroup setBehaviour "SAFE"; // units feel safe until they spot an enemy or get into contact
	_aiGroup setFormation "VEE";

	_speedMode = if (missionDifficultyHard) then { "NORMAL" } else { "LIMITED" };

	_aiGroup setSpeedMode _speedMode;

	// behaviour on waypoints
	{
		_waypoint = _aiGroup addWaypoint [markerPos (_x select 0), 0];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointCompletionRadius 50;
		_waypoint setWaypointCombatMode "YELLOW";
		_waypoint setWaypointBehaviour "SAFE";
		_waypoint setWaypointFormation "VEE";
		_waypoint setWaypointSpeed _speedMode;
	} forEach ((call cityList) call BIS_fnc_arrayShuffle);

	_missionPos = getPosATL leader _aiGroup;

	_missionPicture = getText (configFile >> "CfgVehicles" >> (_veh1 param [0,""]) >> "picture");
	_vehicleName = getText (configFile >> "CfgVehicles" >> (_veh1 param [0,""]) >> "displayName");
	_vehicleName2 = getText (configFile >> "CfgVehicles" >> (_veh2 param [0,""]) >> "displayName");

	_missionHintText = format ["A formation of at least two armed helicopters are patrolling the island. Destroy them and recover their cargo!", _vehicleName, _vehicleName2, airMissionColor];

	_numWaypoints = count waypoints _aiGroup;
};

_waitUntilMarkerPos = {getPosATL _leader};
_waitUntilExec = nil;
_waitUntilCondition = {currentWaypoint _aiGroup >= _numWaypoints};

_failedExec = nil;

// _vehicles are automatically deleted or unlocked in missionProcessor depending on the outcome

_successExec = {

	// Mission completed
	//Random Number of Crates
	[(getMarkerPos _marker), [1, 3], true] call STRandomCratesReward;

	_successHintMessage = "The sky is clear again, the enemy patrol was taken out! Ammo crates have fallen near the wreck.";

};

_this call airMissionProcessor;
