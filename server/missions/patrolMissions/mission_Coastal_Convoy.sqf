// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 2
//	@file Name: mission_Coastal_Convoy.sqf
//	@file Author: JoSchaap / routes by Del1te - (original idea by Sanjo)
//	@file Created: 02/09/2013 11:29
//	@file Args: none

if (!isServer) exitwith {};
#include "patrolMissionDefines.sqf"

private ["_vehChoices", "_reward", "_heliChoices", "_veh1", "_veh2", "_veh3", "_createVehicle", "_vehicles", "_leader", "_speedMode", "_waypoint", "_vehicleName", "_vehicleName2", "_numWaypoints", "_box1", "_box2", "_box3"];

_setupVars =
{
	_missionType = "Coastal Patrol";
	_locationsArray = CoastalConvoyPaths;
};

_setupObjects =
{
	private ["_starts", "_startDirs", "_waypoints"];
	call compile preprocessFileLineNumbers format ["mapConfig\convoys\%1.sqf", _missionLocation];

	_heliChoices = [
		"B_Heli_Attack_01_dynamicLoadout_F",
		"O_Heli_Attack_02_dynamicLoadout_F",
		"B_Heli_Attack_01_dynamicLoadout_F",
		"O_Heli_Attack_02_dynamicLoadout_F",
		ST_APACHE,
		ST_APACHE_NORADAR,
		ST_VENOM1,
		ST_VENOM2,
		ST_COBRA];

	_vehChoices = [ST_GUN_BOAT, "B_Boat_Armed_01_minigun_F", ST_ATTACK_BOAT, "O_Boat_Armed_01_hmg_F", "I_Boat_Armed_01_minigun_F", ST_ATTACK_BOAT, ST_GUN_BOAT];

	_veh1 = _vehChoices call BIS_fnc_selectRandom;
	_veh2 = _heliChoices call BIS_fnc_selectRandom;
	_veh3 = _vehChoices call BIS_fnc_selectRandom;

	_createVehicle = {

		private ["_type", "_position", "_direction", "_variant", "_special", "_vehicle", "_soldier"];

		_type = _this select 0;
		_position = _this select 1;
		_direction = _this select 2;
		_variant = _type param [1,"",[""]];

		if (_type isEqualType []) then {
			_type = _type select 0;
		};

		_vehicle = createVehicle [_type, _position, [], 0, "FLY"];
		_vehicle setVariable ["R3F_LOG_disabled", true, true];

		if (_variant != "") then {
			_vehicle setVariable ["A3W_vehicleVariant", _variant, true];
		};

		[_vehicle] call vehicleSetup;

		_vehicle setDir _direction;
		_aiGroup addVehicle _vehicle;

		// add a driver/pilot/captain to the vehicle
		// the little bird, orca, and hellcat do not require gunners and should not have any passengers
		_soldier = [_aiGroup, _position] call createRandomSoldierC;
		_soldier moveInDriver _vehicle;

		// frontgunner will be here if mission is running at hard dificulty
		_soldier = [_aiGroup, _position] call createRandomSoldierC;
		_soldier moveInTurret [_vehicle, [0]]; // commanderseat - front gunner

		_soldier = [_aiGroup, _position] call createRandomSoldierC;
		_soldier moveInTurret [_vehicle, [1]]; // rear gunner

		_soldier = [_aiGroup, _position] call createRandomSoldierC;
		_soldier moveInAny _vehicle;

		[_vehicle, _aiGroup] spawn checkMissionVehicleLock;
		_vehicle
	};

	_aiGroup = createGroup CIVILIAN;

	_vehicles =
	[
		[_veh1, _starts select 0, _startdirs select 0] call _createVehicle,
		[_veh2, _starts select 1, _startdirs select 1, _aiGroup] call STCreateVehicle,
		[_veh3, _starts select 2, _startdirs select 2] call _createVehicle
	];

	_leader = effectiveCommander (_vehicles select 0);
	_aiGroup selectLeader _leader;

	_aiGroup setCombatMode "YELLOW"; // units will defend themselves
	_aiGroup setBehaviour "SAFE"; // units feel safe until they spot an enemy or get into contact
	_aiGroup setFormation "STAG COLUMN";

	_speedMode = if (missionDifficultyHard) then { "NORMAL" } else { "LIMITED" };

	_aiGroup setSpeedMode _speedMode;

	// behaviour on waypoints
	{
		_waypoint = _aiGroup addWaypoint [_x, 0];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointCompletionRadius 50;
		_waypoint setWaypointCombatMode "YELLOW";
		_waypoint setWaypointBehaviour "SAFE";
		_waypoint setWaypointFormation "STAG COLUMN";
		_waypoint setWaypointSpeed _speedMode;
	} forEach _waypoints;

	_missionPos = getPosATL leader _aiGroup;

	_missionPicture = getText (configFile >> "CfgVehicles" >> (_veh1 param [0,""]) >> "picture");
	_vehicleName = getText (configFile >> "CfgVehicles" >> (_veh1 param [0,""]) >> "displayName");
	_vehicleName2 = getText (configFile >> "CfgVehicles" >> (_veh2 param [0,""]) >> "displayName");

	_missionHintText = format ["Two <t color='%3'>%1</t> are patrolling the coasts, escorted by a <t color='%3'>%2</t>.<br/>Intercept them and recover their cargo!", _vehicleName, _vehicleName2, mainMissionColor];

	_numWaypoints = count waypoints _aiGroup;
};

_waitUntilMarkerPos = {getPosATL _leader};
_waitUntilExec = nil;
_waitUntilCondition = {currentWaypoint _aiGroup >= _numWaypoints};

_failedExec = nil;

// _vehicles are automatically deleted or unlocked in missionProcessor depending on the outcome
_successExec = {

	// Mission completed
	[_lastPos, [2, 4]] call STRandomCratesReward;

	//Reward (Other)
	_box1 = createVehicle ["B_Mortar_01_F", _lastPos, [], 0, "NONE"];
	_box1 setVariable ["R3F_LOG_disabled", false, false];

	//Reward (Random)
	_reward = [ST_ATCONVENIENCEKIT, "B_supplyCrate_F", ST_APACHE_GREY, "B_supplyCrate_F", ST_PAWNEE, "B_supplyCrate_F", "B_supplyCrate_F", ST_QLIN_AT, ST_PROWLER_AT, "B_supplyCrate_F", ST_TIGRIS, ST_AACONVENIENCEKIT, ST_M113_RESUPPLY, ST_MGS_RHINO_UP, "B_supplyCrate_F"] call BIS_fnc_selectRandom;

	if( _reward == ST_ATCONVENIENCEKIT || _reward == ST_AACONVENIENCEKIT) then {

	    _box2 = [_lastPos, _reward] call STCreateSpecialCrate;

	} else {

			_box2 = createVehicle [_reward, _lastPos, [], 0, "NONE"];

			if( _reward == "B_supplyCrate_F" ) then {

				_box2 allowDamage false;

				[_box2] call STFillCrate;

			};

	};

	_successHintMessage = "The patrol has been stopped, the ammo crates are yours to take. Find them near the wreck!";
};

_this call mainMissionProcessor;
