// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_militaryPatrol.sqf
//	@file Author: JoSchaap, AgentRev, LouD

if (!isServer) exitwith {};
#include "moneyMissionDefines.sqf";

private ["_convoyVeh", "_veh1","_veh2","_veh3","_veh4","_veh5","_veh6", "_vehicles", "_leader", "_speedMode", "_waypoint", "_vehicleName", "_numWaypoints", "_cash", "_tank", "_support", "_aa" ];

_setupVars = {
	_missionType = "Military Patrol";
	_locationsArray = PatrolConvoyPaths;
};

_setupObjects = {

	private ["_starts", "_startDirs", "_waypoints"];
	call compile preprocessFileLineNumbers format ["mapConfig\convoys\%1.sqf", _missionLocation];

	_tank = [ST_KUMA, ST_VARSUK, ST_SLAMMER, ST_SLAMMER_UP, ST_ABRAMSM1, ST_ABRAMSM1_TUSK, ST_T140_ANGARA, ST_T140_ANGARA_COMMANDER] call BIS_fnc_selectRandom;
	_support = [ST_KAMYSH, ST_MARSHALL, ST_GORGON, ST_MORA, ST_HUNTER_GMG, ST_HUNTER_HMG, ST_STRIDER_GMG, ST_IFRIT_GMG, ST_IFRIT_HMG, ST_LINEBACKER, ST_MGS_RHINO, ST_MGS_RHINO_UP, ST_AWC_NYX_AT, ST_BRADLEY] call BIS_fnc_selectRandom;
	_aa = [ST_TIGRIS, ST_CHEETAH, ST_AWC_NYX_AA] call BIS_fnc_selectRandom;

	// Pick the vehicles for the patrol. Only one set at the moment. Will add more later.
	//Six vehicles total,
	//Two Tanks, Two Mrap, Two Support and Random
	_veh1 = _support;
	_veh2 = _tank;
	_veh3 = _tank;
	_veh4 = _support;
	_veh5 = _aa;
	_veh6 = _aa;

	_aiGroup = createGroup CIVILIAN;

	_vehicles = [
		[_veh1, _starts select 0, _startDirs select 0, _aiGroup] call STCreateVehicle,
		[_veh2, _starts select 1, _startDirs select 1, _aiGroup] call STCreateVehicle,
		[_veh3, _starts select 2, _startDirs select 2, _aiGroup] call STCreateVehicle,
		[_veh4, _starts select 3, _startDirs select 3, _aiGroup] call STCreateVehicle,
		[_veh5, _starts select 4, _startDirs select 4, _aiGroup] call STCreateVehicle,
		[_veh6, _starts select 5, _startDirs select 5, _aiGroup] call STCreateVehicle
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

		_waypoint = _aiGroup addWaypoint [_x, 0];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointCompletionRadius 50;
		_waypoint setWaypointCombatMode "YELLOW";
		_waypoint setWaypointBehaviour "SAFE"; // safe is the best behaviour to make AI follow roads, as soon as they spot an enemy or go into combat they WILL leave the road for cover though!
		_waypoint setWaypointFormation "FILE";
		_waypoint setWaypointSpeed _speedMode;

	} forEach _waypoints;

	_missionPos = getPosATL leader _aiGroup;

	_missionPicture = getText (configFile >> "CfgVehicles" >> _veh4 >> "picture");
	_vehicleName = getText (configFile >> "CfgVehicles" >> _veh2 >> "displayName");
	_vehicleName2 = getText (configFile >> "CfgVehicles" >> _veh4 >> "displayName");
	_vehicleName3 = getText (configFile >> "CfgVehicles" >> _veh5 >> "displayName");

	_missionHintText = format ["A convoy containing at least a <t color='%4'>%1</t>, a <t color='%4'>%2</t> and a <t color='%4'>%3</t> is patrolling a high value location! Stop the patrol and capture the goods and money!", _vehicleName, _vehicleName2, _vehicleName3, moneyMissionColor];
	_numWaypoints = count waypoints _aiGroup;

};

_waitUntilMarkerPos = {getPosATL _leader};
_waitUntilExec = nil;
_waitUntilCondition = {currentWaypoint _aiGroup >= _numWaypoints};

_failedExec = nil;

// _vehicles are automatically deleted or unlocked in missionProcessor depending on the outcome
_successExec = {

	//Random cash at marker
	[_marker, [20000,20000,30000,40000,40000,40000,40000,40000,80000]] call STRandomCashReward;

	//Random Number of Crates
	[(getMarkerPos _marker), [2, 5]] call STRandomCratesReward;

	_successHintMessage = "The patrol has been stopped, the money, crates and vehicles are yours to take.";

};

_this call moneyMissionProcessor;
