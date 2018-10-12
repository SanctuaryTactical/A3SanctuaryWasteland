// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_altisPatrol.sqf
//	@file Author: JoSchaap, AgentRev, LouD

if (!isServer) exitwith {};
#include "moneyMissionDefines.sqf";

private ["_convoyVeh","_veh1","_veh2","_veh3","_veh4","_veh5", "_veh6", "_veh7", "_veh8", "_tanks", "_support", "_aas", "_pos","_rad","_vehiclePosArray","_vPos1","_vPos2","_vPos3","_vehiclePos1","_vehiclePos2","_vehiclePos3","_vehiclePos4","_vehicles","_leader","_speedMode","_waypoint","_vehicleName","_numWaypoints"];

_setupVars =
{
	_missionType = "Altis Patrol";
	_locationsArray = nil;
};

_setupObjects = {
	_town = (call cityList) call BIS_fnc_selectRandom;
	_missionPos = markerPos (_town select 0);

	//Eight Vehicles in an Altis Patrol
	//Three Tanks,
	//Three Support (Bradly, HMG, GMG)
	//Two AA
	_tanks = [ST_KUMA, ST_VARSUK, ST_SLAMMER, ST_SLAMMER_UP, ST_ABRAMSM1, ST_ABRAMSM1_TUSK, ST_T140_ANGARA, ST_T140_ANGARA_COMMANDER];
	_support = [ST_KAMYSH, ST_MARSHALL, ST_GORGON, ST_MORA,ST_HUNTER_GMG, ST_HUNTER_HMG, ST_STRIDER_GMG, ST_IFRIT_GMG, ST_IFRIT_HMG, ST_LINEBACKER, ST_MGS_RHINO, ST_MGS_RHINO_UP, ST_AWC_NYX_AT, ST_BRADLEY];
	_aas = [ST_TIGRIS, ST_CHEETAH, ST_AWC_NYX_AA];

	_veh1 = _support call BIS_fnc_selectRandom;
	_veh2 = _support call BIS_fnc_selectRandom;
	_veh3 = _tanks call BIS_fnc_selectRandom;
	_veh4 = _tanks call BIS_fnc_selectRandom;
	_veh5 = _tanks call BIS_fnc_selectRandom;
	_veh6 = _aas call BIS_fnc_selectRandom;
	_veh7 = _aas call BIS_fnc_selectRandom;
	_veh8 = _support call BIS_fnc_selectRandom;

	_aiGroup = createGroup CIVILIAN;

	_rad = _town select 1;
	_vehiclePosArray = [_missionPos,_rad,_rad + 50,8,0,0,0] call findSafePos;

	_vehicles = [
		[_veh1, _vehiclePosArray, 0, _aiGroup] call STCreateVehicle,
		[_veh2, _vehiclePosArray, 0, _aiGroup] call STCreateVehicle,
		[_veh3, _vehiclePosArray, 0, _aiGroup] call STCreateVehicle,
		[_veh4, _vehiclePosArray, 0, _aiGroup] call STCreateVehicle,
		[_veh5, _vehiclePosArray, 0, _aiGroup] call STCreateVehicle,
		[_veh6, _vehiclePosArray, 0, _aiGroup] call STCreateVehicle,
		[_veh7, _vehiclePosArray, 0, _aiGroup] call STCreateVehicle,
		[_veh8, _vehiclePosArray, 0, _aiGroup] call STCreateVehicle
	];

	_leader = effectiveCommander (_vehicles select 0);
	_aiGroup selectLeader _leader;
	_leader setRank "LIEUTENANT";

	_aiGroup setCombatMode "YELLOW"; // units will defend themselves
	_aiGroup setBehaviour "COMBAT"; // units feel safe until they spot an enemy or get into contact
	_aiGroup setFormation "FILE";

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

	_missionPicture = getText (configFile >> "CfgVehicles" >> _veh2 >> "picture");
	_vehicleName = getText (configFile >> "CfgVehicles" >> _veh2 >> "displayName");
	_vehicleName2 = getText (configFile >> "CfgVehicles" >> _veh3 >> "displayName");
	_vehicleName3 = getText (configFile >> "CfgVehicles" >> _veh4 >> "displayName");

	_missionHintText = format ["A convoy containing at least a <t color='%4'>%1</t>, a <t color='%4'>%2</t> and a <t color='%4'>%3</t> is patrolling Altis! Stop the patrol and capture the goods and money!", _vehicleName, _vehicleName2, _vehicleName3, moneyMissionColor];

	_numWaypoints = count waypoints _aiGroup;
};

_waitUntilMarkerPos = {getPosATL _leader};
_waitUntilExec = nil;
_waitUntilCondition = {currentWaypoint _aiGroup >= _numWaypoints};

_failedExec = nil;

// _vehicles are automatically deleted or unlocked in missionProcessor depending on the outcome
_drop_item =
{
	private["_item", "_pos"];
	_item = _this select 0;
	_pos = _this select 1;

	if (isNil "_item" || {typeName _item != typeName [] || {count(_item) != 2}}) exitWith {};
	if (isNil "_pos" || {typeName _pos != typeName [] || {count(_pos) != 3}}) exitWith {};

	private["_id", "_class"];
	_id = _item select 0;
	_class = _item select 1;

	private["_obj"];
	_obj = createVehicle [_class, _pos, [], 5, "NONE"];
	_obj setPos ([_pos, [[2 + random 3,0,0], random 360] call BIS_fnc_rotateVector2D] call BIS_fnc_vectorAdd);
	_obj setVariable ["mf_item_id", _id, true];
};

_successExec = {

	//A Fixed amount of cash
	[(markerPos _marker), 50000] call STFixedCashReward;

	//Random Number of Crates
	[(getMarkerPos _marker), [2,4]] call STRandomCratesReward;

	_successHintMessage = "The patrol has been stopped, the money, crates and vehicles are yours to take.";

};

_this call moneyMissionProcessor;
