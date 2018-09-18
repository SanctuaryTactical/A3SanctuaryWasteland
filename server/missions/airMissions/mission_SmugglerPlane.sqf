// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_HostileJet.sqf
//	@file Author: JoSchaap, AgentRev, LouD

if (!isServer) exitwith {};
#include "airMissionDefines.sqf";

private ["_plane", "_helo1", "_helo2", "_vehicles", "_leader", "_speedMode", "_waypoint", "_vehicleName", "_numWaypoints", "_boxes1", "_boxes2", "_boxes3", "_boxes4","_boxes5","_boxes6", "_boxes7", "_boxes8", "_boxes9", "_box1", "_box2", "_box3", "_box4", "_box5", "_box6", "_box7", "_box8", "_box9", "_currBox1", "_currBox2", "_currBox3"];

_setupVars = {
	_missionType = "Smuggler";
	_locationsArray = nil; // locations are generated on the fly from towns
};

_setupObjects = {

	_missionPos = markerPos (((call cityList) call BIS_fnc_selectRandom) select 0);

	_plane = ["I_C_Plane_Civil_01_F","I_C_Heli_Light_01_civil_F"] call BIS_fnc_selectRandom;
	_helo1 = [ST_APACHE, ST_APACHE_NORADAR, ST_APACHE_GREY, ST_VENOM1, ST_VENOM2, ST_COBRA, ST_BLACKHAWK] call BIS_fnc_selectRandom;
	_helo2 = [ST_APACHE, ST_APACHE_NORADAR, ST_APACHE_GREY, ST_VENOM1, ST_VENOM2, ST_COBRA, ST_BLACKHAWK] call BIS_fnc_selectRandom;

	_aiGroup = createGroup CIVILIAN;

	_vehicles = [
		[_plane, _missionPos vectorAdd ([[random 50, 0, 0], random 360] call BIS_fnc_rotateVector2D), 0, _aiGroup] call STCreateVehicle,
		[_helo1, _missionPos vectorAdd ([[random 250, 0, 0], random 360] call BIS_fnc_rotateVector2D), 0, _aiGroup] call STCreateVehicle,
		[_helo2, _missionPos vectorAdd ([[random 350, 0, 0], random 360] call BIS_fnc_rotateVector2D), 0, _aiGroup] call STCreateVehicle
	];

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

	_missionPicture = getText (configFile >> "CfgVehicles" >> _plane >> "picture");
	_vehicleName = getText (configFile >> "CfgVehicles" >> _plane >> "displayName");
	_missionHintText = format ["A <t color='%2'>%1</t> is transporting stolen weapons and cash. Shoot it down and kill the pilot to recover the money and weapons!", _vehicleName, airMissionColor];

	_numWaypoints = count waypoints _aiGroup;
};

_waitUntilMarkerPos = {getPosATL _leader};
_waitUntilExec = nil;
_waitUntilCondition = {currentWaypoint _aiGroup >= _numWaypoints};

_failedExec = nil;

// _vehicles are automatically deleted or unlocked in missionProcessor depending on the outcome
_successExec = {

	// Mission completed

	//Create FN: STRandomCashReward
	[_marker, [25000,30000,35000,40000]] call STRandomCashReward;

	_Boxes1 = ["Box_Syndicate_WpsLaunch_F","Box_Syndicate_Wps_F","", "Box_NATO_Equip_F"];
	_currBox1 = _Boxes1 call BIS_fnc_selectRandom;
	_box1 = createVehicle [_currBox1, _lastPos, [], 2, "NONE"];
	_box1 setDir random 360;
	_box1 setVariable ["moveable", true, true];
	_box1 allowDamage false;

	_Boxes2 = ["Box_Syndicate_WpsLaunch_F","Box_Syndicate_Wps_F","", "Box_NATO_Equip_F"];
	_currBox2 = _Boxes2 call BIS_fnc_selectRandom;
	_box2 = createVehicle [_currBox2, _lastPos, [], 2, "NONE"];
	_box2 setDir random 360;
	_box2 setVariable ["moveable", true, true];
	_box2 allowDamage false;

	_Boxes3 = ["Box_Syndicate_WpsLaunch_F","Box_Syndicate_Wps_F","", "Box_NATO_Equip_F"];
	_currBox3 = _Boxes1 call BIS_fnc_selectRandom;
	_box3 = createVehicle [_currBox3, _lastPos, [], 2, "NONE"];
	_box3 setDir random 360;
	_box3 setVariable ["moveable", true, true];
	_box3 allowDamage false;

	{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach [_box1, _box2, _box3];

	[_box1] spawn STPopCrateSmoke;

	_successHintMessage = "The smuggler was taken out! Ammo crates and money have fallen near the pilot.";

};

_this call airMissionProcessor;
