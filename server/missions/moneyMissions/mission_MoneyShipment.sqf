// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 2.1
//	@file Name: mission_MoneyShipment.sqf
//	@file Author: JoSchaap / routes by Del1te - (original idea by Sanjo), AgentRev
//	@file Created: 31/08/2013 18:19

#include "moneyMissionDefines.sqf";

#define SHIPMENT_SMALL 30000
#define SHIPMENT_MEDIUM 50000
#define SHIPMENT_LARGE 80000
#define SHIPMENT_HEAVY 100000

if (!isServer) exitwith {};

private ["_reward", "_helos", "_scouts", "_tanks", "_tank", "_support", "_aa", "_vehicles", "_leader", "_speedMode", "_waypoint", "_vehicleName", "_numWaypoints"];

_setupVars = {

	_locationsArray = LandConvoyPaths;
	_missionType = "Money Shipment";
	_reward = [SHIPMENT_SMALL, SHIPMENT_MEDIUM, SHIPMENT_LARGE, SHIPMENT_HEAVY] call BIS_fnc_selectRandom;

	_helos = [
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
		ST_LITTLE_BIRD
	];

	_tanks = [ST_KUMA, ST_VARSUK, ST_SLAMMER, ST_SLAMMER_UP, ST_ABRAMSM1, ST_ABRAMSM1_TUSK, ST_T140_ANGARA, ST_T140_ANGARA_COMMANDER];
	_support = [ST_KAMYSH, ST_MARSHALL, ST_GORGON, ST_MORA, ST_HUNTER_GMG, ST_HUNTER_HMG, ST_STRIDER_GMG, ST_IFRIT_GMG, ST_IFRIT_HMG, ST_LINEBACKER, ST_MGS_RHINO, ST_MGS_RHINO_UP, ST_AWC_NYX_AT, ST_BRADLEY];
	_aa = [ST_TIGRIS, ST_CHEETAH, ST_AWC_NYX_AA];

};

_setupObjects = {

	private ["_starts", "_startDirs", "_waypoints", "_direction", "_position", "_count"];
	call compile preprocessFileLineNumbers format ["mapConfig\convoys\%1.sqf", _missionLocation];

	_aiGroup = createGroup CIVILIAN;

	_vehicles = [];

	//Always at least one tank
	_tank = _tanks call BIS_fnc_selectRandom;
	_direction = _startdirs select 0;
	_position = _starts select 0;

	_vehicles pushBack ([_tank, _position, _direction, _aiGroup] call STCreateVehicle);

	//Small - Three Or Four Vehicles, One chopper
	//Medium - Four To Six, One chopper
	//Large - Five To Seven Vehicles, Two Choppers (Escort)
	//Heavy - Eight To Ten Vehicles, Two Choppers (attack)
	switch (_reward) do {
	  case SHIPMENT_SMALL: {
			_count = [1,2] call BIS_fnc_randomInt;
			//Random support (2-3)

			//Add Support Chopper
			_vehicles pushBack ([(_scouts call BIS_fnc_selectRandom), ([_vehicles] call STNextPosition), _direction, _aiGroup] call STCreateVehicle);

		};
	  case SHIPMENT_MEDIUM: {

			_count = [2,3] call BIS_fnc_randomInt;

			//Add Extra Tank
			_vehicles pushBack ([(_tanks call BIS_fnc_selectRandom), ([_vehicles] call STNextPosition), _direction, _aiGroup] call STCreateVehicle);

			//Two Random Scout Choppers
			_vehicles pushBack ([(_scouts call BIS_fnc_selectRandom), ([_vehicles] call STNextPosition), _direction, _aiGroup] call STCreateVehicle);
			_vehicles pushBack ([(_scouts call BIS_fnc_selectRandom), ([_vehicles] call STNextPosition), _direction, _aiGroup] call STCreateVehicle);

		};
	 	case SHIPMENT_LARGE: {

			_count = [2,3] call BIS_fnc_randomInt;

			//Random Tanks (2,4)
			for "_x" from 1 to _count do {

				_vehicles pushBack ([(_tanks call BIS_fnc_selectRandom), ([_vehicles] call STNextPosition), _direction, _aiGroup] call STCreateVehicle);

			};

			//One Attack, One Support Chopper
			_vehicles pushBack ([(_helos call BIS_fnc_selectRandom), ([_vehicles] call STNextPosition), _direction, _aiGroup] call STCreateVehicle);
			_vehicles pushBack ([(_scouts call BIS_fnc_selectRandom), ([_vehicles] call STNextPosition), _direction, _aiGroup] call STCreateVehicle);

		};
		case SHIPMENT_HEAVY: {

			_count = [3,5] call BIS_fnc_randomInt;

			//Random _tanks (3,5)
			for "_x" from 1 to _count do {

				_vehicles pushBack ([(_tanks call BIS_fnc_selectRandom), ([_vehicles] call STNextPosition), _direction, _aiGroup] call STCreateVehicle);

			};

			//Two Attack Choppers
			_vehicles pushBack ([(_helos call BIS_fnc_selectRandom), ([_vehicles] call STNextPosition), _direction, _aiGroup] call STCreateVehicle);
			_vehicles pushBack ([(_helos call BIS_fnc_selectRandom), ([_vehicles] call STNextPosition), _direction, _aiGroup] call STCreateVehicle);

		};
	};

	//Support Vehicles
	for "_x" from 1 to _count do {

		_vehicles pushBack ([(_support call BIS_fnc_selectRandom), ([_vehicles] call STNextPosition), _direction, _aiGroup] call STCreateVehicle);

	};

	//50% Chance of AA unit
	if( 51 > random 100 ) then {

		_vehicles pushBack ([(_aa call BIS_fnc_selectRandom), ([_vehicles] call STNextPosition), _direction, _aiGroup] call STCreateVehicle);

	};

	_leader = effectiveCommander (_vehicles select 0);
	_aiGroup selectLeader _leader;

	_aiGroup setCombatMode "YELLOW"; // units will defend themselves
	_aiGroup setBehaviour "SAFE"; // units feel safe until they spot an enemy or get into contact
	_aiGroup setFormation "STAG COLUMN";

	_speedMode = if (missionDifficultyHard) then { "NORMAL" } else { "LIMITED" };

	_aiGroup setSpeedMode _speedMode;

	{
		_waypoint = _aiGroup addWaypoint [_x, 0];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointCompletionRadius 25;
		_waypoint setWaypointCombatMode "YELLOW";
		_waypoint setWaypointBehaviour "SAFE"; // safe is the best behaviour to make AI follow roads, as soon as they spot an enemy or go into combat they WILL leave the road for cover though!
		_waypoint setWaypointFormation "STAG COLUMN";
		_waypoint setWaypointSpeed _speedMode;
	} forEach _waypoints;

	_missionPos = getPosATL leader _aiGroup;

	_missionPicture = getText (configFile >> "CfgVehicles" >> _tank >> "picture");
	_vehicleName = getText (configFile >> "cfgVehicles" >> _tank >> "displayName");

	_missionHintText = format ["A convoy transporting an unknown amount of money escorted by a <t color='%1'>%2</t> is en route to an unknown location.<br/>Stop them!", moneyMissionColor, _vehicleName];

	_numWaypoints = count waypoints _aiGroup;
};

_waitUntilMarkerPos = {getPosATL _leader};
_waitUntilExec = nil;
_waitUntilCondition = {currentWaypoint _aiGroup >= _numWaypoints};

_failedExec = nil;

// _vehicles are automatically deleted or unlocked in missionProcessor depending on the outcome
_successExec = {

	// Mission completed
	[_lastPos, _reward] call STFixedCashReward;

	_successHintMessage = "The convoy has been stopped, the money and vehicles are now yours to take.";
};

_this call moneyMissionProcessor;
