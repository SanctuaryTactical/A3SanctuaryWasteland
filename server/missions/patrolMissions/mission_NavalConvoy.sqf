// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1
//	@file Name: missionNavalConvoy.sqf
//	@file Author: The Scotsman
//	@file Created: 09/27/2018
//	@file Args: none

#include "patrolMissionDefines.sqf"

if (!isServer) exitwith {};

private ["_boats", "_ships", "_helos", "_count", "_reward", "_createVehicle", "_vehicles", "_leader", "_speedMode", "_waypoint", "_vehicleName", "_numWaypoints"];

_setupVars = {
	_missionType = "Naval Convoy";
	_locationsArray = navalConvoyPaths;
};

_setupObjects = {

  private ["_starts", "_startDirs", "_waypoints"];
	call compile preprocessFileLineNumbers format ["mapConfig\convoys\%1.sqf", _missionLocation];

	_helos = [
    ST_BLACKHAWK,
    ST_BLACKFOOT,
    ST_KAJMAN,
		ST_LITTLE_BIRD,
		ST_APACHE,
		ST_APACHE_NORADAR,
    ST_APACHE_GREY,
		ST_VENOM1,
		ST_COBRA
  ];

  _boats = [
    ST_GUN_BOAT,
    "B_Boat_Armed_01_minigun_F",
    ST_ATTACK_BOAT,
    "O_Boat_Armed_01_hmg_F"
  ];

  _ships = [
    ST_SHIP_FRIGATE,
    ST_SHIP_FREMM,
    ST_SHIP_LAYFAYETTE,
    ST_SHIP_ADMIRAL,
    ST_SHIP_CORVETTE
  ];

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

		_soldier = [_aiGroup, _position] call createRandomSoldierC;
		_soldier moveInDriver _vehicle;

		// frontgunner will be here if mission is running at hard dificulty
		_soldier = [_aiGroup, _position] call createRandomSoldierC;
		_soldier moveInAny _vehicle; // commanderseat - front gunner

		_soldier = [_aiGroup, _position] call createRandomSoldierC;
		_soldier moveInAny _vehicle; // rear gunner

		_soldier = [_aiGroup, _position] call createRandomSoldierC;
		_soldier moveInAny _vehicle;

		_soldier = [_aiGroup, _position] call createRandomSoldierC;
		_soldier moveInAny _vehicle;

		_soldier = [_aiGroup, _position] call createRandomSoldierC;
		_soldier moveInAny _vehicle;

		_soldier = [_aiGroup, _position] call createRandomSoldierC;
		_soldier moveInAny _vehicle;

		[_vehicle, _aiGroup] spawn checkMissionVehicleLock;
		_vehicle
	};

	_aiGroup = createGroup CIVILIAN;

  _vehicles = [];
  _vehicles set [0, ([ST_SHIP_SUPPLY, _starts select 0, _startDirs select 0] call _createVehicle)];

  _vehicles set [1, ([(_boats call BIS_fnc_selectRandom), (getPos (_vehicles select 0)) vectorAdd ([[random 150, 0, 0], random 360] call BIS_fnc_rotateVector2D), _startDirs select 0] call _createVehicle)];
  _vehicles set [2, ([(_boats call BIS_fnc_selectRandom), (getPos (_vehicles select 1)) vectorAdd ([[random 150, 0, 0], random 360] call BIS_fnc_rotateVector2D), _startDirs select 0] call _createVehicle)];
  _vehicles set [3, ([(_helos call BIS_fnc_selectRandom), (getPos (_vehicles select 2)) vectorAdd ([[random 50, 0, 0], random 360] call BIS_fnc_rotateVector2D), _startDirs select 0, _aiGroup] call STCreateVehicle)];

  //One or Two Escort ships
  _count = [1,2] call BIS_fnc_randomInt;

  for "_x" from 0 to _count do {

    _vehicles set [_x + 4, ([(_ships call BIS_fnc_selectRandom), (getPos (_vehicles select _x + 3)) vectorAdd ([[random 200, 0, 0], random 360] call BIS_fnc_rotateVector2D), _startDirs select 0] call _createVehicle)];

	};

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

	_missionPicture = getText (configFile >> "CfgVehicles" >> (ST_SHIP_SUPPLY param [0,""]) >> "picture");
	_vehicleName = getText (configFile >> "CfgVehicles" >> (ST_SHIP_SUPPLY param [0,""]) >> "displayName");

	_missionHintText = "A large naval convoy escorting a supply ship is making it's way along the coast. Intercept, sink them and recover the cargo!";

	_numWaypoints = count waypoints _aiGroup;
};

_waitUntilMarkerPos = {getPosATL _leader};
_waitUntilExec = nil;
_waitUntilCondition = {currentWaypoint _aiGroup >= _numWaypoints};

_failedExec = nil;

//_vehicles are automatically deleted or unlocked in missionProcessor depending on the outcome
_successExec = {

	// Mission completed
	[_lastPos, [2, 10]] call STRandomCratesReward;

  //Add Morter

  //Add Random Object

  //Add Random Cash?


	_successHintMessage = "The convoy has been stopped! Well done... That couldn't have been easy. Cargo can be found near the wreck";
};

_this call mainMissionProcessor;
