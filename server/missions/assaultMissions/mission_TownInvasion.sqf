// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_TownInvasion.sqf
//	@file Author: [404] Deadbeat, [404] Costlyy, JoSchaap, AgentRev, Zenophon
//  @file Information: JoSchaap's Lite version of 'Infantry Occupy House' Original was made by: Zenophon

#include "assaultMissionDefines.sqf"

if (!isServer) exitwith {};

private ["_nbUnits", "_reward", "_type", "_box1", "_box2", "_box3", "_townName", "_vehicles", "_moneyText", "_missionPos", "_buildingRadius", "_putOnRoof", "_fillEvenly", "_tent1", "_chair1", "_chair2", "_cFire1", "_cash"];

_setupVars = {

	_missionType = "Town Invasion";
	_nbUnits = if (missionDifficultyHard) then { AI_GROUP_LARGE } else { AI_GROUP_MEDIUM };

	// settings for this mission
	_locArray = ((call cityList) call BIS_fnc_selectRandom);
	_missionPos = markerPos (_locArray select 0);
	_buildingRadius = _locArray select 1;
	_townName = _locArray select 2;

	//randomize amount of units
	_nbUnits = (_nbUnits + 8) + round(random ((_nbUnits)*0.5));
	_reward = 1500 * _nbUnits;

	// reduce radius for larger towns. for example to avoid endless hide and seek in kavala ;)
	_buildingRadius = if (_buildingRadius > 201) then {(_buildingRadius*0.5)} else {_buildingRadius};
	// 25% change on AI not going on rooftops
	if (random 1 < 0.75) then { _putOnRoof = true } else { _putOnRoof = false };
	// 25% chance on AI trying to fit into a single building instead of spreading out
	if (random 1 < 0.75) then { _fillEvenly = true } else { _fillEvenly = false };
};

_setupObjects = {

	_type = [ST_TECHNICAL, ST_HUNTER_GMG, ST_STRIDER_HMG, ST_IFRIT_HMG, ST_IFRIT_GMG] call BIS_fnc_selectRandom;

	// spawn some crates in the middle of town (Town marker position)
	_box1 = createVehicle ["Box_NATO_Wps_F", _missionPos, [], 5, "NONE"];
	_box1 setDir random 360;
	[_box1, "mission_USSpecial"] call randomCrateLoadOut;

	_box2 = createVehicle ["Box_East_Wps_F", _missionPos, [], 5, "NONE"];
	_box2 setDir random 360;
	[_box2, "mission_USLaunchers"] call randomCrateLoadOut;

	//Anti Tank Kit
	_box3 = Nil;

	//ST: 10% chance of AT Convenience Kit
	if( 10 > random 100 ) then {

		_box3 = [_missionPos, ST_ATCONVENIENCEKIT] call STCreateSpecialCrate;

	} else {

		_box3 = createVehicle ["Box_East_Wps_F", _missionPos, [], 5, "NONE"];
		_box3 setDir random 360;
		[_box3, "mission_USSpecial"] call randomCrateLoadOut;

	};

	{ _x setVariable ["R3F_LOG_disabled", true, true] } forEach [_box1, _box2, _box3];

	// create some atmosphere around the crates 8)
	_tent1 = createVehicle ["Land_cargo_addon02_V2_F", _missionPos, [], 3, "NONE"];
	_tent1 setDir random 360;
	_chair1 = createVehicle ["Land_CampingChair_V1_F", _missionPos, [], 2, "NONE"];
	_chair1 setDir random 90;
	_chair2 = createVehicle ["Land_CampingChair_V2_F", _missionPos, [], 2, "NONE"];
	_chair2 setDir random 180;
	_cFire1	= createVehicle ["Campfire_burning_F", _missionPos, [], 2, "NONE"];

	// spawn some rebels/enemies :)
	_aiGroup = createGroup CIVILIAN;
	[_aiGroup, _missionPos, _nbUnits] call createCustomGroup2;

	// move them into buildings
	[_aiGroup, _missionPos, _buildingRadius, _fillEvenly, _putOnRoof] call moveIntoBuildings;

	//Give them a couple of technicals, maybe some heavier enemy?
	_vehicles = [
		[_type, _missionPos vectorAdd ([[random 150, 0, 0], random 360] call BIS_fnc_rotateVector2D), 0, _aiGroup] call STCreateVehicle,
		[_type, _missionPos vectorAdd ([[random 250, 0, 0], random 360] call BIS_fnc_rotateVector2D), 0, _aiGroup] call STCreateVehicle
	];

	_moneyText = format ["$%1", [_reward] call fn_numbersText];
	_missionHintText = format ["Hostiles have taken over <br/><t size='1.25' color='%1'>%2</t><br/><br/>There seem to be <t color='%1'>%3 enemies</t> hiding inside or on top of buildings. Get rid of them all, and take their supplies and <t color='%1'>%4</t> in cash!<br/>Watch out for those windows!", assaultMissionColor, _townName, _nbUnits, _moneyText];

};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = nil;

_failedExec = {
	// Mission failed
	{ deleteVehicle _x } forEach [_box1, _box2, _box3, _tent1, _chair1, _chair2, _cFire1];
};

_successExec = {

	//Dispose of props
	{ deleteVehicle _x } forEach [_tent1, _chair1, _chair2, _cFire1];

	//Enable Reward Boxes
	{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach [_box1, _box2, _box3];

	//Add some cash
	[_marker, _reward] call STFixedCashReward;

	_successHintMessage = format ["Nice work!<br/><br/><t color='%1'>%2</t><br/>is a safe place again!<br/>Their belongings and <t color='%1'>%3</t> in cash are now yours to take!", assaultMissionColor, _townName, _moneyText];

};

_this call assaultMissionProcessor;
