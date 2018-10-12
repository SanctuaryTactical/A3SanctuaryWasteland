/*******************************************************************************************
* This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com
********************************************************************************************
* @file Name: STRandomCrates.sqf
* @author: The Scotsman
*
*
* Arguments: [ position, count, smoke ]: Number of crates
*
*/
#include "..\STConstants.h"

if (!isServer) exitWith {};

params ["_position", "_range", ["_smoke", false], ["_disabled", false]];

private ["_count", "_boxtype", "_boxtypes", "_types", "_box", "_boxes"];

//Random Number of Crates
_count = _range call BIS_fnc_randomInt;
_types = [
  "Box_Ammo_F",
  "Box_GEN_Equip_F",
  "B_supplyCrate_F",
  "Box_East_Wps_F",
  "Box_NATO_Wps_F",
  "Box_NATO_Support_F",
  "Box_NATO_Equip_F",
  "Box_NATO_Ammo_F",
  "Box_NATO_AmmoVeh_F",
  "Box_NATO_Grenades_F",
  "Box_NATO_AmmoOrd_F",
  "Box_NATO_Uniforms_F",
  "Box_NATO_WpsLaunch_F",
  "Box_IND_Ammo_F",
  "Box_IND_Grenades_F",
  "Box_IND_Support_F",
  "Box_IND_AmmoOrd_F",
  "Box_IND_AmmoVeh_F",
  "Box_IND_WpsLaunch_F",
  "Box_EAST_Ammo_F",
  "Box_EAST_Grenades_F",
  "Box_EAST_AmmoOrd_F",
  "Box_AAF_Equip_F",
  "Box_AAF_Uniforms_F",
  "Box_AAF_Equip_F",
  "Box_CSAT_Uniforms_F",
  "Box_CSAT_Equip_F",
  "Box_T_East_Ammo_F",
  "Box_T_East_WpsSpecial_F",
  "Box_East_Support_F",
  "Box_East_WpsLaunch_F"];

_boxes = [];

for "_x" from 0 to _count do {

  //Lazy - use same random odds for convenience kit
  if( _x == _count && (random 1.0 < ["A3W_artilleryCrateOdds", 1/10] call getPublicVar)) then {

    _boxtype = [ST_ATCONVENIENCEKIT, ST_AACONVENIENCEKIT] call BIS_fnc_selectRandom;

  } else {

    _boxtype = _types call BIS_fnc_selectRandom;

  };

  _box = _boxtype createVehicle _position;
  _box allowDamage false;
  _box setVariable ["R3F_LOG_disabled", _disabled, true];

  [_box] call STFillCrate;

  if( _smoke && _x == 0 ) then { [_box] spawn STPopCrateSmoke; };

  if (["A3W_artilleryStrike"] call isConfigOn && _x == _count ) then {
    if (random 1.0 < ["A3W_artilleryCrateOdds", 1/10] call getPublicVar) then {
      _box setVariable ["artillery", 1, true];
    };
  };

  /* if( 10 > random 100 ) then {

    _box setVariable ["repairkit", ([1,3] call BIS_fnc_randomInt), true];

  }; */

  //TODO: Percentage chance of Repair kits of random count
  //TODO: Percentage chance of fuel of random count
  //TODO: Percentage chance of ONE spawn beacon
  //TODO: Percentage chance of fire extinguisher of random count
  //TODO: Percentage chance of food of random count
  //TODO: Percentage chance of water of random count
  //TODO: Percentage chance of Vehicle PIN of random count

  //TODO: Arty handler to be enhanced to support the additional types

  _boxes set [_x, _box];

};

_boxes
