// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_HostileJet.sqf
//	@file Author: JoSchaap, AgentRev, LouD

if (!isServer) exitwith {};
#include "airMissionDefines.sqf";

private ["_planeChoices", "_heloChoices1", "_heloChoices2", "_convoyVeh", "_helo1", "_helo2", "_veh1", "_veh2", "_veh3", "_createVehicle", "_vehicles", "_leader", "_speedMode", "_waypoint", "_vehicleName", "_numWaypoints", "_cash", "_boxes1", "_boxes2", "_boxes3", "_boxes4","_boxes5","_boxes6", "_boxes7", "_boxes8", "_boxes9", "_box1", "_box2", "_box3", "_box4", "_box5", "_box6", "_box7", "_box8", "_box9", "_currBox1", "_currBox2", "_currBox3"];

_setupVars =
{
	_missionType = "Smuggler";
	_locationsArray = nil; // locations are generated on the fly from towns
};

_setupObjects =
{
	_missionPos = markerPos (((call cityList) call BIS_fnc_selectRandom) select 0);

	_planeChoices =
	[
		["I_C_Plane_Civil_01_F"],
		["I_C_Heli_Light_01_civil_F"],
		["CUP_B_C47_USA"]
	];
	_heloChoices1 =
	[
		["CUP_B_AH64D_DL_USA"],
		["CUP_B_UH1Y_Gunship_Dynamic_USMC"],
		["CUP_B_AH1Z_Dynamic_USMC"],
		["CUP_B_Mi35_Dynamic_CZ_Des"],
		["CUP_B_MH60L_DAP_4x_USN"]
	];
	_heloChoices2 =
	[
		["CUP_B_AH64D_DL_USA"],
		["CUP_B_UH1Y_Gunship_Dynamic_USMC"],
		["CUP_B_AH1Z_Dynamic_USMC"],
		["CUP_B_Mi35_Dynamic_CZ_Des"],
		["CUP_B_MH60L_DAP_4x_USN"]
	];

	_convoyVeh = _planeChoices call BIS_fnc_selectRandom;
	_helo1 = _heloChoices1 call BIS_fnc_selectRandom;
	_helo2 = _heloChoices2 call BIS_fnc_selectRandom;

	_veh1 = _convoyVeh select 0;
	_veh2 = _helo1 select 0;
	_veh3 = _helo2 select 0;

	_createVehicle =
	{
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
		_soldier = [_aiGroup, _position] call createRandomSyndikatPilot;
		_soldier moveInDriver _vehicle;
		_soldier triggerDynamicSimulation true;

		// lock the vehicle untill the mission is finished and initialize cleanup on it
		[_vehicle, _aiGroup] spawn checkMissionVehicleLock;
		_vehicle
	};

	_aiGroup = createGroup CIVILIAN;

	_vehicles = [];
	_vehicles set [0, [_veh1,[14574.7,21400.3,0], 14, _aiGroup] call _createVehicle]; // static value update when porting to different maps
	_vehicles set [1, [_veh2,[14574.8,21401.5,0], 14, _aiGroup] call _createVehicle];
	_vehicles set [2, [_veh3,[14574.9,21402.0,0], 14, _aiGroup] call _createVehicle];

	_leader = effectiveCommander (_vehicles select 0);
	_aiGroup selectLeader _leader;
	_leader setRank "LIEUTENANT";

	_aiGroup setCombatMode "RED";
	_aiGroup setBehaviour "COMBAT";
	_aiGroup setFormation "STAG COLUMN";

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

	_missionPicture = getText (configFile >> "CfgVehicles" >> _veh1 >> "picture");
	_vehicleName = getText (configFile >> "CfgVehicles" >> _veh1 >> "displayName");
	_missionHintText = format ["A <t color='%2'>%1</t> is transporting stolen weapons and cash. Shoot it down and kill the pilot to recover the money and weapons!", _vehicleName, airMissionColor];

	_numWaypoints = count waypoints _aiGroup;
};

_waitUntilMarkerPos = {getPosATL _leader};
_waitUntilExec = nil;
_waitUntilCondition = {currentWaypoint _aiGroup >= _numWaypoints};

_failedExec = nil;

// _vehicles are automatically deleted or unlocked in missionProcessor depending on the outcome

_successExec =
{
	// Mission completed

	//Money
	for "_i" from 1 to 10 do
	{
		_cash = createVehicle ["Land_Money_F", _lastPos, [], 5, "NONE"];
		_cash setPos ([_lastPos, [[2 + random 3,0,0], random 360] call BIS_fnc_rotateVector2D] call BIS_fnc_vectorAdd);
		_cash setDir random 360;
		_cash setVariable ["cmoney", 2500, true];
		_cash setVariable ["owner", "world", true];
	};


	_Boxes1 = ["Box_Syndicate_WpsLaunch_F","Box_Syndicate_Wps_F","","Box_NATO_Equip_F"];
	_currBox1 = _Boxes1 call BIS_fnc_selectRandom;
	_box1 = createVehicle [_currBox1, _lastPos, [], 2, "NONE"];
	_box1 setDir random 360;
	_box1 setVariable ["moveable", true, true];
	_box1 allowDamage false;

	_Boxes2 = ["Box_Syndicate_WpsLaunch_F","Box_Syndicate_Wps_F","","Box_NATO_Equip_F"];
	_currBox2 = _Boxes2 call BIS_fnc_selectRandom;
	_box2 = createVehicle [_currBox2, _lastPos, [], 2, "NONE"];
	_box2 setDir random 360;
	_box2 setVariable ["moveable", true, true];
	_box2 allowDamage false;

	_Boxes3 = ["Box_Syndicate_WpsLaunch_F","Box_Syndicate_Wps_F","","Box_NATO_Equip_F"];
	_currBox3 = _Boxes1 call BIS_fnc_selectRandom;
	_box3 = createVehicle [_currBox3, _lastPos, [], 2, "NONE"];
	_box3 setDir random 360;
	_box3 setVariable ["moveable", true, true];
	_box3 allowDamage false;

	//Scotsman - Pop Smoke
	_smoke1= "SmokeShellGreen" createVehicle getPos _box3;
	_smoke1 attachto [_box3,[0,0,-0.5]];
	_flare1= "F_40mm_Green" createVehicle getPos _box3;
	_flare1 attachto [_box3,[0,0,-0.5]];

	{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach [_box1, _box2];

	_successHintMessage = "The smuggler was taken out! Ammo crates and money have fallen near the pilot.";
};

_this call airMissionProcessor;
