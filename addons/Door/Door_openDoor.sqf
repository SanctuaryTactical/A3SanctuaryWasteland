// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: Door_unlockDoor.sqf
//	@file Author: LouD / Cael817 for original script
//	@file Description: Door script

private ["_doors", "_roofs", "_door", "_keypads"];

_doors = (nearestObjects [player, ["Land_Bunker_01_blocks_3_F","Land_Bunker_01_blocks_1_F"], 10]);

if ( count _doors > 0 ) then {

	{ [[netId _x, true], "A3W_fnc_hideObjectGlobal", _x] call A3W_fnc_MP } forEach _doors;

	_keypads = (nearestObjects [player, ["Land_Noticeboard_F"], 10]);

	if( !isNil "_keypads" ) then {

		{
			_x setObjectTextureGlobal [0, "media\keypadon.paa"];
		} forEach _keypads;

	};

	_door = _doors select 0;
	playSound3d [MISSION_ROOT + "media\lock.ogg", _door, true, getPosASL _door, 1];

	hint "Your door has been opened";

} else {

	_roofs = (nearestObjects [player, ["ContainmentArea_01_forest_F"], 40]);

	if( count _roofs > 0 ) then {

		{
			[[netId _x, true], "A3W_fnc_hideObjectGlobal", _x] call A3W_fnc_MP;
		} forEach _roofs;

		_door = _roofs select 0;
		playSound3d [MISSION_ROOT + "media\hiss.ogg", _door, true, getPosASL _door, 1];

		_keypads = (nearestObjects [player, ["Land_Noticeboard_F"], 10]);

		if( !isNil "_keypads" ) then {

			{
				_x setObjectTextureGlobal [0, "media\keypadon.paa"];
			} forEach _keypads;

		};

		hint "Roof panels now open";

	} else {

		hint "No doors or roof panels were found";

	};

};
