// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 2.1
//	@file Name: mission_MiniConvoy.sqf
//	@file Author: JoSchaap / routes by Del1te - (original idea by Sanjo), AgentRev
//	@file Created: 31/08/2013 18:19

if (!isServer) exitwith {};
#include "sideMissionDefines.sqf";

private ["_pos", "_class", "_transport", "_escorts", "_vehicle", "_boxes", "_vehicles", "_leader", "_speedMode", "_waypoint", "_vehicleName", "_numWaypoints" ];

_setupVars = {
	_missionType = "Truck Convoy";
	_locationsArray = LandConvoyPaths;
};

_setupObjects = {

	private ["_starts", "_startDirs", "_waypoints"];
	call compile preprocessFileLineNumbers format ["mapConfig\convoys\%1.sqf", _missionLocation];

	_aiGroup = createGroup CIVILIAN;

	_transport = [ST_M10_COVERED,ST_M10_FLATBED,ST_ZAMAK_FUEL,ST_ZAMAK_MEDICAL,ST_ZAMAK_BOX,ST_ZAMAK_TRANSPORT,ST_ZAMAK_COVERED,ST_HEMIT_TRANSPORT,ST_HEMIT_COVERED,ST_HEMIT_BOX,ST_HEMIT_REPAIR,ST_HEMIT_AMMO,ST_HEMIT_FUEL,ST_HEMIT_MEDICAL,ST_TEMPIST_TRANSPORT,ST_TEMPIST_REPAIR,ST_TEMPIST_AMMO,ST_TEMPIST_FUEL,ST_TEMPIST_MEDICAL,ST_TEMPIST_DEVICE] call BIS_fnc_selectRandom;
	_escorts = [ST_ABRAMSM2, ST_BRADLEY, ST_LINEBACKER, ST_KUMA, ST_VARSUK, ST_SLAMMER, ST_CHEETAH, ST_TIGRIS, ST_KAMYSH, ST_T140_ANGARA, ST_T140_ANGARA_COMMANDER, ST_AWC_NYX_AA, ST_AWC_NYX_AT, ST_MGS_RHINO, ST_QLIN_AT];
	_vehicles = [];

	_vehicles set [0, ([_transport, _starts select 0, _startDirs select 0, _aiGroup] call STCreateVehicle)];
	_count = [3,6] call BIS_fnc_randomInt;

	//Extra infantry in transport to deal with
	for "_x" from 0 to _count do {

		_soldier = [_aiGroup, (_starts select 0)] call createRandomSoldier;
	  _soldier triggerDynamicSimulation true;
	  _soldier moveInAny (_vehicles select 0);

	};

	//Number of Escorts
	_count = [2,5] call BIS_fnc_randomInt;
	_pos = getPos (_vehicles select 0);

	for "_x" from 0 to _count do {

		_class = _escorts call BIS_fnc_selectRandom;

		_vehicle = [_class, _pos vectorAdd ([[random 50, 0, 0], random 360] call BIS_fnc_rotateVector2D), _startDirs select 0, _aiGroup] call STCreateVehicle;
		_vehicles set [_x + 1, _vehicle];

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

	_missionPicture = getText (configFile >> "CfgVehicles" >> _transport >> "picture");
	_vehicleName = getText (configFile >> "CfgVehicles" >> _transport >> "displayName");

	_missionHintText = format ["A <t color='%2'>%1</t> transporting at least 2 weapon crates is being escorted. Stop the convoy, but don't destroy the transport!", _vehicleName, sideMissionColor];

	_numWaypoints = count waypoints _aiGroup;

};

_waitUntilMarkerPos = {getPosATL _leader};
_waitUntilExec = nil;
_waitUntilCondition = {currentWaypoint _aiGroup >= _numWaypoints || !alive (_vehicles select 0)};

_failedExec = {

	_failedHintMessage = format ["What the crap?  Did you destroy the transport containing the boxes?  What didn't you understand?"];

};

// _vehicles are automatically deleted or unlocked in missionProcessor depending on the outcome

// Mission completed
_successExec = {

	//Random Number of Crates
	_boxes = [(getMarkerPos _marker), [2, 8]] call STRandomCratesReward;

	//Load reward crates into vehicle.
	nul = [(_vehicles select 0), _boxes] execVM "addons\R3F_LOG\auto_load_in_vehicle.sqf";

	_successHintMessage = "The convoy has been stopped, the weapon crates and vehicles are now yours to take.";

};

_this call sideMissionProcessor;
