// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: Door_DoorController.sqf
//	@file Author: The Scotsman
//	@file Description: Open & Close Doors

#include "DoorDefines.sqf"

params ["_open"];
private ["_doors", "_door", "_keypad", "_keypads", "_generators", "_action"];

_generators = [player, "WARNING", "A generator is required within 50 metres to power this door.<br/>Better get one soon!"] call CheckPowerSource;

if( _generators == 0 ) then { sleep 5; };

_keypads = (nearestObjects [player, [KEYPAD], 10]);

if ( count _keypads > 0 ) then {

	_keypad = _keypads select 0;
	_doors = (nearestObjects [_keypad, [DOOR_LARGE, DOOR_SMALL], 10]);

	if( count _doors > 0 ) then {

		//TODO: Loop t\hrough "touching" doors
		{ [[netId _x, _open], "A3W_fnc_hideObjectGlobal", _x] call A3W_fnc_MP } forEach _doors;

		_door = _doors select 0;

		playSound3d [MISSION_ROOT + "media\lock.ogg", _door, true, getPosASL _door, 1];

    _action = if( _open ) then { "media\keypadon.paa" } else { "media\keypad.paa" };

    {
  	   _x setObjectTextureGlobal [0, _action];
		} forEach _keypads;

    _action = if( _open ) then { "opened" } else { "closed" };

		hint format ["Your door has been %1", _action];

	} else {

		hint "No Doors Found";
		playSound3d [MISSION_ROOT + "media\error.ogg", _keypad, true, getPosASL _keypad, 1];

	};

};
