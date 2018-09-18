// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: random.sqf
//	@file Author: [1ST] The Scotsman
//  runs every X minutes to spawn a random patrol

if (!isServer && hasInterface) exitWith {};

//FIND RANDOM PLAYER....

/*
#include "moneyMissionDefines.sqf";

waitUntil {(count (playableUnits + switchableUnits)) > 0};//remove switchableUnits if not doing SP

_units = [];
{
 if (isPlayer _x) then {
   _units pushBack _x;
 }
} foreach (playableUnits + switchableUnits);//remove switchableUnits if not doing SP

_unit = _units call BIS_fnc_selectRandom;
*/



/* Bounty...

if (!isServer) exitwith {};
#include "moneyMissionDefines.sqf";

_unit = playableUnits call BIS_fnc_selectRandom;


_missionHintText = format ["<t color='%1'>_unit</t> has a bounty on their head. Kill them to collect $2,000. If they evade for 20 minutes _unit will receive $4,000", "PLAIN"];

sleep 60;

titleText ["<t color='%1'>_unit</t> has been marked on the map. Let the hunt begin!", "PLAIN"];

_pos = getPos _unit;

createMarker ["Mark1", _pos];

"Mark1" setMarkerSize [1200, 1200];

"Mark1" setMarkerShape "ELLIPSES";

"Mark1" setMarkerText "Bounty";

"Mark1" setMarkerColor "ColorRed";


sleep 300;

deleteMarker "Mark1";

_pos = getPos _unit;

_missionHintText = format["<t color='%1'>_unit</t> has been updated on the map", "PLAIN"];

createMarker ["Mark1", _pos];

"Mark1" setMarkerSize [1000, 1000];

"Mark1" setMarkerShape "ELLIPSES";

"Mark1" setMarkerText "Bounty";

"Mark1" setMarkerColor "ColorRed";


sleep 300;

deleteMarker "Mark1";

_pos = getPos _unit;

_missionHintText = format ["<t color='%1'>_unit</t> has been updated on the map", "PLAIN"];

createMarker ["Mark1", _pos];

"Mark1" setMarkerSize [900, 900];

"Mark1" setMarkerShape "ELLIPSES";

"Mark1" setMarkerText "Bounty";

"Mark1" setMarkerColor "ColorRed";


sleep 300;

deleteMarker "Mark1";

_pos = getPos _unit;

_missionHintText = format["<t color='%1'>_unit</t> has been updated on the map", "PLAIN"];

createMarker ["Mark1", _pos];

"Mark1" setMarkerSize [800, 800];

"Mark1" setMarkerShape "ELLIPSES";

"Mark1" setMarkerText "Bounty";

"Mark1" setMarkerColor "ColorRed";

sleep 300;



_failedExec =
{
// Mission failed
{
	_x setVariable ["cmoney", 4000, true];
	_x setVariable ["owner", "world", true];
} forEach _cashObjects;
};


_successExec =
{
// Mission complete
_box1 setVariable ["R3F_LOG_disabled", false, true];

// Give the rewards
{
	_x setVariable ["cmoney", 2000, true];
	_x setVariable ["owner", "world", true];
} forEach _cashObjects;

_successHintMessage = "The bounty has been claimed.";
};

_this call moneyMissionProcessor;

*/



/* #define SLEEP_REALTIME(SECS) if (hasInterface) then { sleep (SECS) } else { uiSleep (SECS) }
#define RANDOM_INTERVAL (2*60) // Interval to spawn a random patrol

private ["_missionTime", "_marker", "_town", "_mission"];

_missionTime = diag_tickTime;

while {true} do {

  SLEEP_REALTIME((RANDOM_INTERVAL - (diag_tickTime - _missionTime)) max 120);

  diag_log "[1ST] Starting Random Patrol";

  if (!isNil "_mission") then {

    nul = [_mission,2,_marker,10,0] execVM "addons\LV\LV_functions\LV_fnc_removeAC.sqf";

    diag_log format ["[1ST] Removed random patrol from %1", _town];

  };

  _towns = ((call cityList) call BIS_fnc_selectRandom);
  _position = markerPos (_towns select 0);
  _town = _towns select 2;
  _marker = nearestBuilding _position;
  //_location = nearestBuilding _position;

	_unitcount = 10 + round(random ((30)*0.5));

  _hint = format ["Warning! An enemy patrol has been detected near the town of <t size='1.25' color='%1'>%2</t>, engage with extreme caution, we have no intel on size or equipment", "#E86E0C", _town];

  [_hint] call hintBroadcast;

  _mission = [450,900,30,300,_unitcount,[1,1,1],_marker,60,40,false,"default",true,2500,nil,["CARELESS","SAD"],true,true,["ALL"]] execVM "addons\LV\ambientCombat.sqf";
  nul = [_marker,2,true,false,1500,"random",true,200,150,12,0.5,50,true,false,false,false,_marker,false,"default",nil,nil,nil,true,false,["ALL"]] execVM "addons\LV\heliParadrop.sqf";


  diag_log format ["[1ST] Random Patrol spawned in %1 with %2 units", _town, _unitcount];

};

_missionTime = diag_tickTime; */
