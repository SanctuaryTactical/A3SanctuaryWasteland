// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.2
//	@file Name: init.sqf
//	@file Author: [404] Deadbeat, [GoT] JoSchaap, AgentRev
//	@file Description: The main init.

#include "debugFlag.hpp"

#ifdef A3W_DEBUG
#define DEBUG true
#else
#define DEBUG false
#endif

enableSaving [false, false];
A3W_sessionTimeStart = diag_tickTime;

_descExtPath = str missionConfigFile;
currMissionDir = compileFinal str (_descExtPath select [0, count _descExtPath - 15]);

X_Server = false;
X_Client = false;
X_JIP = false;

CHVD_allowNoGrass = false;
CHVD_allowTerrain = false; // terrain option has been disabled out from the menu due to terrible code, this variable has currently no effect
CHVD_maxView = 3500; // Set maximum view distance (default: 12000)
CHVD_maxObj = 3500; // Set maximimum object view distance (default: 12000)

// versionName = ""; // Set in STR_WL_WelcomeToWasteland in stringtable.xml

if (isServer) then { X_Server = true };
if (!isDedicated) then { X_Client = true };
if (isNull player) then { X_JIP = true };

A3W_scriptThreads = [];

[DEBUG] call compile preprocessFileLineNumbers "globalCompile.sqf";
[DEBUG] call compile preprocessFileLineNumbers "hashmap\oo_hashmap.sqf";

_locations = [[14577.5,16725,0], [14605.4,16714.5,0],[14625.8,16770,0],[14617.9,16851.6,0],[14522.4,16759.5,0],[14535.8,16793.1,0],[14545.4,16803.3,0],[14556.4,16813.8,0],[14566,16824.1,0],[14578.9,16836.8,0],[14589.9,16847.3,0],[14600.3,16857.6,0],[14623.1,16856.3,0],[14537.6,16774.8,0]];
_radius=16;

{
	_terrainobjects=nearestTerrainObjects [_x,[],_radius];

	{hideObjectGlobal _x} foreach _terrainobjects;

}foreach _locations;

//init Wasteland Core
[] execVM "config.sqf";
[] execVM "storeConfig.sqf"; // Separated as its now v large
[] execVM "briefing.sqf";

if (!isDedicated) then
{
	[] spawn
	{
		if (hasInterface) then // Normal player
		{
			//9999 cutText ["Welcome to A3Wasteland, please wait for your client to initialize", "BLACK", 0.01];

			waitUntil {!isNull player};
			player setVariable ["playerSpawning", true, true];
			playerSpawning = true;

			removeAllWeapons player;
			client_initEH = player addEventHandler ["Respawn", { removeAllWeapons (_this select 0) }];

			// Reset group & side
			[player] joinSilent createGroup playerSide;

			execVM "client\init.sqf";

			if ((vehicleVarName player) select [0,17] == "BIS_fnc_objectVar") then { player setVehicleVarName "" }; // undo useless crap added by BIS
		}
		else // Headless
		{
			waitUntil {!isNull player};
			if (getText (configFile >> "CfgVehicles" >> typeOf player >> "simulation") == "headlessclient") then
			{
				execVM "client\headless\init.sqf";
			};
		};
	};
};

if (isServer) then
{
	diag_log format ["############################# %1 #############################", missionName];
	diag_log "WASTELAND SERVER - Initializing Server";
	[] execVM "server\init.sqf";
};

if (hasInterface || isServer) then {

	//init 3rd Party Scripts
	[] execVM "addons\scripts\intro.sqf";                 // Welcome intro by Firsty
	[] execVM "addons\parking\functions.sqf";
	[] execVM "addons\storage\functions.sqf";
	[] execVM "addons\vactions\functions.sqf";
	[] execVM "addons\R3F_LOG\init.sqf";
	[] execVM "addons\proving_ground\init.sqf";
	[] execVM "addons\JumpMF\init.sqf";
	[] execVM "addons\outlw_magrepack\MagRepack_init.sqf";
	[] execVM "addons\lsd_nvg\init.sqf";
	[] execVM "addons\stickyCharges\init.sqf";
	[] execVM "addons\APOC_Airdrop_Assistance\init.sqf";
	[] execVM "addons\AF_Keypad\AF_KP_vars.sqf";          // Keypad for base locking
	[] execVM "addons\LV\init.sqf";          							// AI Spawn Script

	//Load Sanctuary Tactical
	[] execVM "1st\init.sqf";

	if (isNil "drn_DynamicWeather_MainThread") then { drn_DynamicWeather_MainThread = [] execVM "addons\scripts\DynamicWeatherEffects.sqf" };

	waitUntil {!isnull player};
	player setCustomAimCoef 0.15;
	player enableStamina false;
	player addEventHandler ["Respawn", {player enableStamina  false; player setCustomAimCoef 0.15;}];
};

// Remove line drawings from map
(createTrigger ["EmptyDetector", [0,0,0], false]) setTriggerStatements
[
	"!triggerActivated thisTrigger",
	"thisTrigger setTriggerTimeout [30,30,30,false]",
	"{if (markerShape _x == 'POLYLINE') then {deleteMarker _x}} forEach allMapMarkers"
];

MISSION_ROOT = call {
    private "_arr";
    _arr = toArray __FILE__;
    _arr resize (count _arr - 8);
    toString _arr
};
