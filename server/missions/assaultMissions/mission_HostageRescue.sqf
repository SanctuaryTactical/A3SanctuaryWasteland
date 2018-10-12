// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_HostageRescue.sqf
//	@file Author: JoSchaap, AgentRev, GriffinZS, RickB, soulkobk

if (!isServer) exitwith {};
#include "assaultMissionDefines.sqf";

private ["_positions", "_camonet", "_hostage", "_obj1", "_obj3", "_obj4", "_vehicleName", "_chair"];

_setupVars =
{
	_missionType = "Hostage Rescue";
	_locationsArray = MissionSpawnMarkers;
};

_setupObjects = {

	_missionPos = markerPos _missionLocation;

	//delete existing base parts and vehicles at location
	_baseToDelete = nearestObjects [_missionPos, ["All"], 25];
	{ deleteVehicle _x } forEach _baseToDelete;

	_camonet = createVehicle ["CamoNet_INDP_open_F", [_missionPos select 0, _missionPos select 1], [], 0, "CAN_COLLIDE"];
	_camonet allowdamage false;
	_camonet setDir random 360;
	_camonet setVariable ["R3F_LOG_disabled", false];

	_missionPos = getPosATL _camonet;

	_chair = createVehicle ["Land_Slums02_pole", _missionPos, [], 0, "CAN_COLLIDE"];
	_chair setPosATL [_missionPos select 0, _missionPos select 1, _missionPos select 2];

	_hostage = createVehicle ["C_Nikos_aged", _missionPos, [], 0, "CAN_COLLIDE"];
	_hostage setPosATL [_missionPos select 0, _missionPos select 1, _missionPos select 2];
	waitUntil {alive _hostage};
	[_hostage, "Acts_AidlPsitMstpSsurWnonDnon_loop"] call switchMoveGlobal;
	_hostage disableAI "anim";

	_obj1 = createVehicle ["I_GMG_01_high_F", _missionPos,[], 10,"NONE"];
	_obj1 setPosATL [(_missionPos select 0) - 2, (_missionPos select 1) + 2, _missionPos select 2];

	_obj3 = createVehicle ["I_HMG_01_high_F", _missionPos,[], 10,"NONE"];
	_obj3 setPosATL [(_missionPos select 0) - 2, (_missionPos select 1) - 2, _missionPos select 2];

	_obj4 = createVehicle ["I_HMG_01_high_F", _missionPos,[], 10,"NONE"];
	_obj4 setPosATL [(_missionPos select 0) + 2, (_missionPos select 1) - 2, _missionPos select 2];

	_aiGroup = createGroup CIVILIAN;
	[_aiGroup,_missionPos,10,20] spawn createCustomGroup;

	_aiGroup setCombatMode "RED";
	_aiGroup setBehaviour "COMBAT";

	//TODO: Percentage chance of vehicles


	_vehicleName = "Hostage";
	_missionHintText = format ["<br/>Mercenary soldiers have captured a merchant and claim ransom. <br/> Free the merchant, he will pay for this", _vehicleName, assaultMissionColor];

};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = {!alive _hostage};

// Mission failed
_failedExec = {

	{ deleteVehicle _x } forEach [_camonet, _obj1, _obj3, _obj4, _hostage, _chair];
	_failedHintMessage = format ["The merchant is dead! What the hell have you not understood? Have you saved one Ghillie Suit at least?!"];

};

// Mission completed
_successExec = {

	{ deleteVehicle _x } forEach [_camonet, _hostage, _chair];
	{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach [_obj1, _obj3, _obj4];

	[(markerPos _marker), 50000] call STFixedCashReward;

	_successHintMessage = format ["Well done! The mercenary soldiers are dead and the merchant alive. He pays for this."];

};

_this call assaultMissionProcessor;
