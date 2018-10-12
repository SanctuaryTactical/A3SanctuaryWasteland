// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_HostileJet.sqf
//	@file Author: JoSchaap, AgentRev, LouD

if (!isServer) exitwith {};
#include "airMissionDefines.sqf";

private ["_gunship", "_createVehicle", "_vehicles", "_leader", "_speedMode", "_waypoint", "_vehicleName", "_numWaypoints"];

_setupVars = {

	_missionType = "Gunship";
	_locationsArray = nil; // locations are generated on the fly from towns

};

_setupObjects = {

	_missionPos = markerPos (((call cityList) call BIS_fnc_selectRandom) select 0);
	_gunship = "B_T_VTOL_01_armed_F";

	_createVehicle = {

		private ["_type","_position","_direction","_vehicle","_soldier"];

		_type = _this select 0;
		_position = _this select 1;
		_direction = _this select 2;

		_vehicle = createVehicle [_type, _position, [], 0, "FLY"]; // Added to make it fly
		_vehicle setVehicleReportRemoteTargets true;
		_vehicle setVehicleReceiveRemoteTargets true;
		_vehicle setVehicleRadar 1;
		_vehicle confirmSensorTarget [west, true];
		_vehicle confirmSensorTarget [east, true];
		_vehicle confirmSensorTarget [resistance, true];
		_vehicle setVariable ["R3F_LOG_disabled", true, true];
		_vel = [velocity _vehicle, -(_direction)] call BIS_fnc_rotateVector2D; // Added to make it fly
		_vehicle setDir _direction;
		_vehicle setVelocity _vel; // Added to make it fly
		_vehicle setVariable [call vChecksum, true, false];
		_aiGroup addVehicle _vehicle;

		// add pilot
		_soldier = [_aiGroup, _position] call createRandomPilot;
		_soldier moveInDriver _vehicle;
		_soldier triggerDynamicSimulation true;
		_soldier = [_aiGroup, _position] call createRandomPilot;
		_soldier moveInTurret [_vehicle, [0]];
		_soldier = [_aiGroup, _position] call createRandomPilot;
		_soldier moveInTurret [_vehicle, [1]];
		_soldier = [_aiGroup, _position] call createRandomPilot;
		_soldier moveInTurret [_vehicle, [2]];
		// lock the vehicle untill the mission is finished and initialize cleanup on it

		[_vehicle, _aiGroup] spawn checkMissionVehicleLock;
		_vehicle
	};

	_aiGroup = createGroup CIVILIAN;

	_vehicles = [];
	_vehicles set [0, [_gunship,[14574.7,31859.3,0], 14, _aiGroup] call _createVehicle]; // static value update when porting to different maps

	_leader = effectiveCommander (_vehicles select 0);
	_aiGroup selectLeader _leader;
	_leader setRank "LIEUTENANT";

	_aiGroup setCombatMode "RED";
	_aiGroup setBehaviour "AWARE";
	_aiGroup setFormation "STAG COLUMN";

	_speedMode = if (missionDifficultyHard) then { "NORMAL" } else { "LIMITED" };

	// behaviour on waypoints
	{
		_waypoint = _aiGroup addWaypoint [markerPos (_x select 0), 0];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointCompletionRadius 55;
		_waypoint setWaypointCombatMode "RED";
		_waypoint setWaypointBehaviour "AWARE";
		_waypoint setWaypointFormation "STAG COLUMN";
		_waypoint setWaypointSpeed _speedMode;
	} forEach ((call cityList) call BIS_fnc_arrayShuffle);

	_missionPos = getPosATL leader _aiGroup;

	_missionPicture = getText (configFile >> "CfgVehicles" >> _gunship >> "picture");
	_vehicleName = getText (configFile >> "CfgVehicles" >> _gunship >> "displayName");
	_missionHintText = format ["An armed <t color='%2'>%1</t> is patrolling the island. Shoot it down and kill the pilot to recover the money and weapons!", _vehicleName, airMissionColor];

	_numWaypoints = count waypoints _aiGroup;
};

_waitUntilMarkerPos = {getPosATL _leader};
_waitUntilExec = nil;
_waitUntilCondition = {currentWaypoint _aiGroup >= _numWaypoints};

_failedExec = nil;

// _vehicles are automatically deleted or unlocked in missionProcessor depending on the outcome

// Mission completed
_successExec = {

	//Random cash at marker
	[_marker, [20000,20000,25000,25000,30000,30000,40000,50000,50000,80000]] call STRandomCashReward;

	//Create FN: STRandomCashReward
	//[_marker, [20000,30000,30000,30000,30000,40000]] call STRandomCashReward;

	/* //Random Number of Crates
	[(getMarkerPos _marker), [2,4]] call STRandomCratesReward; */

	/* _cash = "Land_Money_F" createVehicle markerPos _position;
	_cash setPos ((mark>
	20:57:52   Error position: <markerPos _position;
	_cash setPos ((mark>
	20:57:52   Error markerpos: Type Array, expected String
	20:57:52 File mpmissions\__cur_mp.Altis\1st\STRandomCashReward.sqf, line 20

	//Random Number of Crates
	[(getMarkerPos _marker), [2, 5], true] call STRandomCratesReward; */

	_successHintMessage = "The sky is clear again, the enemy Gunship was taken out. Cargo has fallen from the Wreck go find it!.";

};

_this call airMissionProcessor;
