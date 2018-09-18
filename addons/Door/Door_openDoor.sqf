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

	//Must have power generator nearby
	//if( count (nearestObjects [_keypad, ["Land_PowerGenerator_F"], 200) == 0 ) then { hint "No Power Generator could be found, go to the General Store and buy one!"; };

	if( count _doors > 0 ) then {

		//Open Door_optionSelect
		{ [[netId _x, true], "A3W_fnc_hideObjectGlobal", _x] call A3W_fnc_MP } forEach _doors;

		_door = _doors select 0;

		playSound3d [MISSION_ROOT + "media\lock.ogg", _door, true, getPosASL _door, 1];

		{
			_x setObjectTextureGlobal [0, "media\keypadon.paa"];
		} forEach _keypads;

		hint "Your door has been opened";

	} else {

		hint "No Doors Found";
		playSound3d [MISSION_ROOT + "media\error.ogg", _keypad, true, getPosASL _keypad, 1];

	};

};
