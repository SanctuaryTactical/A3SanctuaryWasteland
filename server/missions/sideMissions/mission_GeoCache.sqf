// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: mission_geoCache.sqf
//	@file Author: [404] Deadbeat, [404] Costlyy, AgentRev, edit by CRE4MPIE & LouD
//	@file Created: 08/12/2012 15:19

#include "sideMissionDefines.sqf"

if (!isServer) exitwith {};

private ["_geoPos", "_geoCache", "_box", "_pos", "_para", "_group", "_reward", "_smoke", "_flare"];

_setupVars = {
	_missionType = "Q-Cache";
	_locationsArray = MissionSpawnMarkers;
};

_setupObjects = {
	_missionPos = markerPos _missionLocation;
	_geoPos = _missionPos vectorAdd ([[25 + random 20, 0, 0], random 360] call BIS_fnc_rotateVector2D);
	_geoCache = createVehicle ["Land_SurvivalRadio_F",[(_geoPos select 0), (_geoPos select 1),0],[], 0, "NONE"];

	//Evil horde of 10 guards
	_group = createGroup CIVILIAN;
	[_group, _missionPos, 10] call createCustomGroup;

	_missionHintText = "a GeoCache has been marked on the map. There is a small object hidden near the marker. Find it and a reward will be delivered by air!";
};

_ignoreAiDeaths = true;
_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = nil;
_waitUntilSuccessCondition = {{isPlayer _x && _x distance _geoPos < 5} count playableUnits > 0};

//Mission failed
_failedExec = {
	{ deleteVehicle _x } forEach [_GeoCache];
};

// Mission completed
_successExec = {

	{ deleteVehicle _x } forEach [_GeoCache];

	_box = nil;
	_pos = [(_geoPos select 0), (_geoPos select 1), 200];

	_reward = [ST_ATCONVENIENCEKIT, "B_supplyCrate_F", ST_APACHE_GREY, "B_supplyCrate_F", ST_PAWNEE, "B_supplyCrate_F", "B_supplyCrate_F", ST_QLIN_AT, ST_PROWLER_AT, "B_supplyCrate_F", ST_TIGRIS, ST_AACONVENIENCEKIT, "B_supplyCrate_F", ST_M113_RESUPPLY, ST_MGS_RHINO_UP, "B_supplyCrate_F"] call BIS_fnc_selectRandom;

	if( _reward == ST_ATCONVENIENCEKIT || _reward == ST_AACONVENIENCEKIT) then {

	    _box = [_pos, _reward] call STCreateSpecialCrate;

	} else {

			_box = createVehicle [_reward, _pos, [], 0, "NONE"];

			if( _reward == "B_supplyCrate_F" ) then {

				_box allowDamage false;

				[_box] call STFillCrate;

			};

	};

	_box setPos _pos;
	_box setVariable ["R3F_LOG_disabled", false, false];

	_box call STParaDropObject;

	playSound3D ["A3\data_f_curator\sound\cfgsounds\air_raid.wss", _box, false, _box, 15, 1, 1500];

	_successHintMessage = "The GeoCache supplies have been delivered by parachute!";
};

_this call sideMissionProcessor;
