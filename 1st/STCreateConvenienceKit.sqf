/*******************************************************************************************
* This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com
********************************************************************************************
* @file Name: STCreateConvenienceKit.sqf
* @author: The Scotsman
*
* Creates a "convenience" crate in the setOxygenRemaining value
* Arguments: [crate, type]
* crate = The crate to load
* type = AA OR AT?
*/
if (!isServer) exitWith {};

private ["_object", "_type"];

_object = _this select 0;
_type = _this select 1;

_object setAmmoCargo 10;
_object allowDamage false; //Prevents destruction of crates
_object setVariable ["allowDamage", false, true];
_object setVariable ["A3W_inventoryLockR3F", true, true];

clearMagazineCargoGlobal _object;
clearWeaponCargoGlobal _object;
clearItemCargoGlobal _object;

switch _type do {
  case "AA": {

    _object addMagazineCargoGlobal ["Titan_AA", 30];
    _object addWeaponCargoGlobal ["launch_B_Titan_F", 1];

  };
  case "AT": {

    _object addMagazineCargoGlobal ["Titan_AT", 28];
    _object addMagazineCargoGlobal ["Titan_AP", 5];
    _object addWeaponCargoGlobal ["launch_I_Titan_short_F", 1];

  };

};
