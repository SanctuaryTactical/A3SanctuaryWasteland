// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_HackLaptop.sqf
//	@file Author: JoSchaap, AgentRev, LouD

if (!isServer) exitwith {};
#include "mainMissionDefines.sqf";

private ["_nbUnits","_positions", "_bunker", "_laptop", "_table", "_obj","_bunker2", "_laptop2", "_table2", "_obj2","_bunker3", "_laptop3", "_table3", "_obj3","_bunker4", "_laptop4", "_table4", "_obj4", "_bunkerPos", "_connectedLaptop","_randomGroup", "_vehicleName", "_cash", "_aiPos", "_radius"];

_setupVars =
{
	_missionType = "Hackers";
	_nbUnits = if (missionDifficultyHard) then { AI_GROUP_LARGE } else { AI_GROUP_MEDIUM };
	_locationsArray = MissionSpawnMarkers;
	_nbUnits = _nbUnits + round(random (_nbUnits*0.8));
};

_setupObjects =
{
	_missionPos = markerPos _missionLocation;
	
//delete existing base parts and vehicles at location
	_baseToDelete = nearestObjects [_missionPos, ["All"], 50];
	{ deleteVehicle _x } forEach _baseToDelete; 
	

	_bunker = createVehicle ["CamoNet_INDP_big_F", [_missionPos select 0, _missionPos select 1], [], 0, "CAN COLLIDE"];
	_bunker allowdamage false;
	_bunker setDir random 360;
	_bunker setVariable ["R3F_LOG_disabled", true, true];
	
	_bunkerPos = getPosASL _bunker;

	_table = createVehicle ["Land_WoodenTable_small_F", _bunkerPos, [], 0, "CAN COLLIDE"];
	_table allowdamage false;
	_table setPosASL [_bunkerPos select 0, (_bunkerPos select 1) - 0.25, _bunkerPos select 2];
	_table enableSimulation false;
	

	
	_laptop = createVehicle ["Land_Laptop_unfolded_F", _bunkerPos, [], 0, "CAN COLLIDE"];
	_laptop allowdamage false;
	_laptop attachTo [_table,[0,0,0.60]];
	_laptop enableSimulation false;
	

	_obj = createVehicle ["I_HMG_01_high_F", _bunkerPos,[], 10,"None"]; 
	_obj setPosASL [_bunkerPos select 0, (_bunkerPos select 1) + 2, _bunkerPos select 2];
	_obj setVariable ["R3F_LOG_disabled", true, true];
	
	
	_bunker2 = createVehicle ["CamoNet_INDP_big_F", [(_missionPos select 0)+ 30, _missionPos select 1], [], 0, "CAN COLLIDE"];
	_bunker2 allowdamage false;
	_bunker2 setDir random 360;
	_bunker2 setVariable ["R3F_LOG_disabled", true, true];
	
	_bunkerPos = getPosASL _bunker2;

	_table2 = createVehicle ["Land_WoodenTable_small_F", _bunkerPos, [], 0, "CAN COLLIDE"];
	_table2 allowdamage false;
	_table2 setPosASL [_bunkerPos select 0, (_bunkerPos select 1) - 0.25, _bunkerPos select 2];
	_table2 enableSimulation false;

	
	_laptop2 = createVehicle ["Land_Laptop_unfolded_F", _bunkerPos, [], 0, "CAN COLLIDE"];
	_laptop2 allowdamage false;
	_laptop2 attachTo [_table2,[0,0,0.60]];
	_laptop2 enableSimulation false;
	

	_obj2 = createVehicle ["I_HMG_01_high_F", _bunkerPos,[], 10,"None"]; 
	_obj2 setPosASL [_bunkerPos select 0, (_bunkerPos select 1) + 2, _bunkerPos select 2];
	_obj2 setVariable ["R3F_LOG_disabled", true, true];
	
	_bunker3 = createVehicle ["CamoNet_INDP_big_F", [(_missionPos select 0) - 30, _missionPos select 1], [], 0, "CAN COLLIDE"];
	_bunker3 allowdamage false;
	_bunker3 setDir random 360;
	_bunker3 setVariable ["R3F_LOG_disabled", true, true];
	
	_bunkerPos = getPosASL _bunker3;

	_table3 = createVehicle ["Land_WoodenTable_small_F", _bunkerPos, [], 0, "CAN COLLIDE"];
	_table3 allowdamage false;
	_table3 setPosASL [_bunkerPos select 0, (_bunkerPos select 1) - 0.25, _bunkerPos select 2];
	_table3 enableSimulation false;

	
	_laptop3 = createVehicle ["Land_Laptop_unfolded_F", _bunkerPos, [], 0, "CAN COLLIDE"];
	_laptop3 allowdamage false;
	_laptop3 attachTo [_table3,[0,0,0.60]];
	_laptop3 enableSimulation false;
	

	_obj3 = createVehicle ["O_GMG_01_high_F", _bunkerPos,[], 10,"None"]; 
	_obj3 setPosASL [_bunkerPos select 0, (_bunkerPos select 1) + 2, _bunkerPos select 2];
	_obj3 setVariable ["R3F_LOG_disabled", true, true];
	
	_bunker4 = createVehicle ["CamoNet_INDP_big_F", [_missionPos select 0, (_missionPos select 1) + 30], [], 0, "CAN COLLIDE"];
	_bunker4 allowdamage false;
	_bunker4 setDir random 360;
	_bunker4 setVariable ["R3F_LOG_disabled", true, true];
	
	_bunkerPos = getPosASL _bunker4;

	_table4 = createVehicle ["Land_WoodenTable_small_F", _bunkerPos, [], 0, "CAN COLLIDE"];
	_table4 allowdamage false;
	_table4 setPosASL [_bunkerPos select 0, (_bunkerPos select 1) - 0.25, _bunkerPos select 2];
	_table4 enableSimulation false;

	
	_laptop4 = createVehicle ["Land_Laptop_unfolded_F", _bunkerPos, [], 0, "CAN COLLIDE"];
	_laptop4 allowdamage false;
	_laptop4 attachTo [_table4,[0,0,0.60]];
	_laptop4 enableSimulation false;
	

	_obj4 = createVehicle ["O_GMG_01_high_F", _bunkerPos,[], 10,"None"]; 
	_obj4 setPosASL [_bunkerPos select 0, (_bunkerPos select 1) + 2, _bunkerPos select 2];
	_obj4 setVariable ["R3F_LOG_disabled", true, true];
	
	// Pick a Laptop
	_connectedLaptop = [_laptop,_laptop2,_laptop3,_laptop4] call BIS_fnc_selectRandom;
	AddLaptopHandler = _connectedLaptop;
	publicVariable "AddLaptopHandler";

	_connectedLaptop setVariable [ "Done", false, true ];

	// NPC Randomizer 

	_aiGroup = createGroup CIVILIAN;
	_aiPos = [_missionPos select 0, (_missionPos select 1) - 20, 0];
	[_aiGroup,_missionPos,24,20] spawn createHackerGroup1;

	//_randomGroup = [createHackerGroup1,createHackerGroup2] call BIS_fnc_selectRandom;
	//[_aiGroup, _aiPos, _nbUnits] spawn createHackerGroup1;

	_aiGroup setCombatMode "RED";
	_aiGroup setBehaviour "COMBAT";	
	
	_vehicleName = "Laptop";
	_missionHintText = format ["<t color='%2'>Hackers</t> are using a laptop to hack your bank accounts. Hacking the laptop successfully will steal cash from each on-line players bank accounts! Plus extra money from the bank", _vehicleName, moneyMissionColor];
};

_waitUntilMarkerPos = nil;
_waitUntilExec =
{
	AddLaptopHandler = _connectedLaptop;
	publicVariable "AddLaptopHandler";
};
_waitUntilCondition = nil;
_waitUntilSuccessCondition = { _connectedLaptop getVariable ["Done", false] };
_ignoreAiDeaths = true;

_failedExec =
{
	// Mission failed
	RemoveLaptopHandler = _connectedLaptop;
	publicVariable "RemoveLaptopHandler";
	{ deleteVehicle _x } forEach [_bunker,  _laptop, _table, _obj, _bunker2, _laptop2, _table2, _obj2, _bunker3,  _laptop3, _table3, _obj3, _bunker4,  _laptop4, _table4, _obj4];
};

_successExec =
{
	// Mission completed
	RemoveLaptopHandler = _connectedLaptop;
	publicVariable "RemoveLaptopHandler";
	{ deleteVehicle _x } forEach [_laptop,_table,_laptop2,_table2,_laptop3,_table3,_laptop4,_table4 ];
	{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach [_obj, _obj2, _obj3, _obj4 ];
	_successHintMessage = format ["The laptop is hacked. Well done!"];
};

_this call moneyMissionProcessor;