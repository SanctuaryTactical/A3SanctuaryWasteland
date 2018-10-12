// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: SecureAll.sqf
//	@file Author: The Scotsman
//	@file Description: Closes all Door and Roof Objects

#include "DoorDefines.sqf"

params [["_verbose", true]];
private ["_objects", "_locker", "_keypads"];

//Find the baselocker relative to the player (Keypad)
_lockers = nearestObjects [player, [BASE_LOCKER], 200];

if( !isNil "_lockers" ) then {

	_locker = _lockers select 0;
  _objects = (nearestObjects [_locker, [DOOR_SMALL, DOOR_LARGE, DOME, ROOF_PANEL], 200]);

  if( !isNil "_objects" ) then {

    playSound3d [MISSION_ROOT + "media\klaxon.ogg", _locker, true, getPosASL _locker, 2];

    //Find all keypads relative to the base locker
    _keypads = (nearestObjects [_locker, [KEYPAD], 200]);

    //Close Everything
    {

      [[netId _x, false], "A3W_fnc_hideObjectGlobal", _x] call A3W_fnc_MP;

      //Roofs make satisfying hissing noise
      if( typeOf _x in [DOME, ROOF_PANEL] ) then { playSound3d [MISSION_ROOT + "media\hiss.ogg", _x, true, getPosASL _x, 1]; };

    } forEach _objects;

    //Switch the keypad texture to "off" on all keypads
    {

      //Doors make satisfying clunk sound
      if( (_forEachIndex mod 2) == 0 ) then { playSound3d [MISSION_ROOT + "media\lock.ogg", _x, true, getPosASL _x, 1]; };

      _x setObjectTextureGlobal [0, "media\keypad.paa"];

    } forEach _keypads;

};

if( _verbose ) then { hint "All doors have been secured"; };
