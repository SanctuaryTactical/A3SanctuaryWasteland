// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: Door_unlockDoor.sqf
//	@file Author: LouD / Cael817 for original script
//	@file Description: Door script

private ["_doors", "_door", "_keypad", "_keypads"];

_keypads = (nearestObjects [player, ["Land_Noticeboard_F"], 10]);

if ( count _keypads > 0 ) then {

	_keypad = _keypads select 0;
	_doors = (nearestObjects [_keypad, ["Land_Bunker_01_blocks_3_F", "Land_Bunker_01_blocks_1_F"], 10]);

	if( count _doors > 0 ) then {

		//Close Door
		{ [[netId _x, false], "A3W_fnc_hideObjectGlobal", _x] call A3W_fnc_MP } forEach _doors;

		_door = _doors select 0;

		playSound3d [MISSION_ROOT + "media\lock.ogg", _door, true, getPosASL _door, 1];

		//Switch Keypad Display
		_keypads = (nearestObjects [_door, ["Land_Noticeboard_F"], 10]);

		if( !isNil "_keypads" ) then {

			{
				_x setObjectTextureGlobal [0, "media\keypad.paa"];
			} forEach _keypads;

		};

		hint "Your door has been closed";

	} else {

		hint "No Doors Found";
		playSound3d [MISSION_ROOT + "media\error.ogg", _roof, true, getPosASL _roof, 1];

	};

};
