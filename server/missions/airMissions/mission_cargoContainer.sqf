// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_cargoContainer.sqf
//	@file Author: The Scotsman

if (!isServer) exitwith {};
#include "airMissionDefines.sqf";

private ["_class", "_vehicles", "_vehicle", "_count", "_leader", "_speedMode", "_waypoint", "_vehicleName", "_numWaypoints", "_container"];

_setupVars = {

	_missionType = "Cargo Container";
	_locationsArray = nil; // locations are generated on the fly from towns

};

_setupObjects = {

	_missionPos = markerPos (((call cityList) call BIS_fnc_selectRandom) select 0);

	_class = [ST_APACHE,ST_APACHE_NORADAR,ST_APACHE_GREY,ST_VENOM1,ST_VENOM2,ST_COBRA,ST_BLACKHAWK] call BIS_fnc_selectRandom;
	_count = [2,3] call BIS_fnc_randomInt;

	_aiGroup = createGroup CIVILIAN;

	_vehicles = [];

	//C130J
	_vehicle = [ST_C130, _missionPos, 0, _aiGroup] call STCreateVehicle;
	_vehicles set [0, _vehicle];

	for "_x" from 1 to _count do {

		_vehicle = [_class, _missionPos vectorAdd ([[random 500, 0, 0], random 360] call BIS_fnc_rotateVector2D), 0, _aiGroup] call STCreateVehicle;
		_vehicles set [_x, _vehicle];

	};

	_aiGroup setCombatMode "RED";
	_aiGroup setBehaviour "COMBAT";
	_aiGroup setFormation "STAG COLUMN";

	_leader = effectiveCommander (_vehicles select 0);
	_aiGroup selectLeader _leader;
	_leader setRank "LIEUTENANT";

	_speedMode = if (missionDifficultyHard) then { "NORMAL" } else { "LIMITED" };

	// behaviour on waypoints
	{
		_waypoint = _aiGroup addWaypoint [markerPos (_x select 0), 0];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointCompletionRadius 55;
		_waypoint setWaypointCombatMode "RED";
		_waypoint setWaypointBehaviour "COMBAT";
		_waypoint setWaypointFormation "STAG COLUMN";
		_waypoint setWaypointSpeed _speedMode;
	} forEach ((call cityList) call BIS_fnc_arrayShuffle);

	_missionPos = getPosATL leader _aiGroup;

	_missionPicture = getText (configFile >> "CfgVehicles" >> ST_C130 >> "picture");
	_vehicleName = getText (configFile >> "CfgVehicles" >> ST_C130 >> "displayName");
	_missionHintText = format ["A <t color='%2'>%1</t> and at least two armed escorts are transporting a payroll and a large cargo container. Shoot it down and kill the pilot to recover container and the money!", _vehicleName, airMissionColor];

	_numWaypoints = count waypoints _aiGroup;

};

_waitUntilMarkerPos = {getPosATL _leader};
_waitUntilExec = nil;
_waitUntilCondition = {currentWaypoint _aiGroup >= _numWaypoints};

_failedExec = nil;

// _vehicles are automatically deleted or unlocked in missionProcessor depending on the outcome
_successExec = {

  //Money
	[_lastPos, 50000] call STFixedCashReward;

	// Mission completed
	_container = createVehicle ["Land_Cargo20_military_green_F", _lastPos, [], 2, "NONE"];
	_container setDir random 360;
	_container setVariable ["moveable", true, true];
	_container allowDamage false;
	_container setVariable ["R3F_LOG_disabled", false, true];

	[_container] spawn STPopCrateSmoke;

	_successHintMessage = "The transport was stopped! The cargo container and payroll has been dropped.";

};

_this call airMissionProcessor;
