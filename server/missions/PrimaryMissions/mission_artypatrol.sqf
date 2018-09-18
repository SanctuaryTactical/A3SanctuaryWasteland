// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_artyPatrol.sqf
//	@file Author: WitchDoctor [GGO]

if (!isServer) exitwith {};
#include "PrimaryMissionDefines.sqf";

private ["_convoyVeh", "_veh1","_veh2","_veh3","_veh4","_veh5","_veh6","_veh7","_veh8","_veh9","_veh0", "_vehicles", "_leader", "_speedMode", "_waypoint", "_vehicleName", "_numWaypoints"];

_setupVars =
{
	_missionType = "Artillery Patrol";
	_locationsArray = artyConvoyPaths;
};

_setupObjects = {

	private ["_starts", "_startDirs", "_waypoints"];

	call compile preprocessFileLineNumbers format ["mapConfig\convoys\%1.sqf", _missionLocation];

	// Pick the vehicles for the patrol.
	//Ten Vehicles
	_veh1 = ["B_APC_Wheeled_01_cannon_F", "B_APC_Tracked_01_AA_F", "O_APC_Tracked_02_AA_F", "O_APC_Tracked_02_cannon_F", ST_BRADLEY, ST_LINEBACKER, ST_AWC_NYX_AT, ST_AWC_NYX_AUTOCANNON, ST_MGS_RHINO, ST_MGS_RHINO_UP ] call BIS_fnc_selectRandom; //MRAP
	_veh2 = [ST_BLACKFOOT, ST_APACHE, ST_APACHE_NORADAR, ST_APACHE_GREY, ST_COBRA ] call BIS_fnc_selectRandom;
	_veh3 = ["I_MBT_03_cannon_F", "B_MBT_01_cannon_F", "O_MBT_02_cannon_F", ST_ABRAMSM1, ST_ABRAMSM2, ST_T140_ANGARA, ST_T140_ANGARA_COMMANDER ] call BIS_fnc_selectRandom; //Tank
	_veh4 = ["B_APC_Tracked_01_AA_F", "O_APC_Tracked_02_AA_F", ST_AWC_NYX_AA] call BIS_fnc_selectRandom; //MRAP (AA)
	_veh5 = [ST_PAWNEE, ST_HELLCAT, ST_LITTLE_BIRD, ST_LITTLE_BIRD, ST_LITTLE_BIRD, ST_LITTLE_BIRD, ST_VENOM1, ST_APACHE_GREY] call BIS_fnc_selectRandom;
	_veh6 = ["B_MBT_01_mlrs_F", "B_MBT_01_arty_F", ST_HOWITZER] call BIS_fnc_selectRandom; //Arty Unit
	_veh7 = ["B_APC_Tracked_01_AA_F", "O_APC_Tracked_02_AA_F", ST_AWC_NYX_AA] call BIS_fnc_selectRandom; //MRAP (AA)
	_veh8 = _veh5;
	_veh9 = ["I_MBT_03_cannon_F", "B_MBT_01_cannon_F", "O_MBT_02_cannon_F", ST_ABRAMSM1, ST_ABRAMSM2, ST_T140_ANGARA, ST_T140_ANGARA_COMMANDER ] call BIS_fnc_selectRandom; //Tank
	_veh0 = ["B_APC_Wheeled_01_cannon_F", "B_APC_Tracked_01_AA_F", "O_APC_Tracked_02_AA_F", "O_APC_Tracked_02_cannon_F", ST_BRADLEY, ST_LINEBACKER, ST_AWC_NYX_AT, ST_AWC_NYX_AUTOCANNON, ST_MGS_RHINO, ST_MGS_RHINO_UP ] call BIS_fnc_selectRandom; //MRAP

	_aiGroup = createGroup CIVILIAN;

	_vehicles = [
		[_veh1, _starts select 0, _startDirs select 0, _aiGroup] call STCreateVehicle,
		[_veh2, _starts select 1, _startDirs select 1, _aiGroup] call STCreateVehicle,
		[_veh3, _starts select 2, _startDirs select 2, _aiGroup] call STCreateVehicle,
		[_veh4, _starts select 3, _startDirs select 3, _aiGroup] call STCreateVehicle,
		[_veh5, _starts select 4, _startDirs select 4, _aiGroup] call STCreateVehicle,
		[_veh6, _starts select 5, _startDirs select 5, _aiGroup] call STCreateVehicle,
		[_veh7, _starts select 6, _startDirs select 6, _aiGroup] call STCreateVehicle,
		[_veh8, _starts select 7, _startDirs select 7, _aiGroup] call STCreateVehicle,
		[_veh9, _starts select 8, _startDirs select 8, _aiGroup] call STCreateVehicle,
		[_veh0, _starts select 9, _startDirs select 9, _aiGroup] call STCreateVehicle
	];

	_leader = effectiveCommander (_vehicles select 0);
	_aiGroup selectLeader _leader;
	_leader setRank "LIEUTENANT";

	_aiGroup setCombatMode "YELLOW"; // units will defend themselves
	_aiGroup setBehaviour "SAFE"; // units feel safe until they spot an enemy or get into contact
	_aiGroup setFormation "STAG COLUMN";

	_aiGroup setSpeedMode "NORMAL";

	{
		_waypoint = _aiGroup addWaypoint [_x, 0];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointCompletionRadius 50;
		_waypoint setWaypointCombatMode "YELLOW";
		_waypoint setWaypointBehaviour "SAFE"; // safe is the best behaviour to make AI follow roads, as soon as they spot an enemy or go into combat they WILL leave the road for cover though!
		_waypoint setWaypointFormation "FILE";
		_waypoint setWaypointSpeed "NORMAL";
	} forEach _waypoints;

	_missionPos = getPosATL leader _aiGroup;

	_missionPicture = getText (configFile >> "CfgVehicles" >> _veh6 >> "picture");
	_vehicleName = getText (configFile >> "CfgVehicles" >> _veh2 >> "displayName");
	_vehicleName2 = getText (configFile >> "CfgVehicles" >> _veh6 >> "displayName");
	_vehicleName3 = getText (configFile >> "CfgVehicles" >> _veh9 >> "displayName");

	_missionHintText = format ["A convoy containing at least a <t color='%4'>%1</t>, a <t color='%4'>%2</t> and a <t color='%4'>%3</t> is patrolling a high value location! Stop the partol and collect the high value weapons crate and money!", _vehicleName, _vehicleName2, _vehicleName3, PrimaryMissionColor];

	_numWaypoints = count waypoints _aiGroup;
};

_waitUntilMarkerPos = {getPosATL _leader};
_waitUntilExec = nil;
_waitUntilCondition = {currentWaypoint _aiGroup >= _numWaypoints};

_failedExec = nil;

// _vehicles are automatically deleted or unlocked in missionProcessor depending on the outcome

_successExec = {

	//Create FN: STRandomCashReward
	[_marker, [20000,30000,40000,50000,60000]] call STRandomCashReward;

	//Random Number of Crates
	[_marker, [2, 6]] call STRandomCratesReward;

	_successHintMessage = "The patrol has been stopped, the money, crates and vehicles are yours to take.";
};

_this call PrimaryMissionProcessor;
