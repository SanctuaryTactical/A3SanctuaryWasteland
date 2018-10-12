// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: OpenAllDoors.sqf
//	@file Author: The Scotsman
//	@file Description: Opens door objects within the base locker's radioChannelAdd units

#include "DoorDefines.sqf"

private ["_doors", "_locker", "_keypads"];

_lockers = nearestObjects [player, [BASE_LOCKER], EFFECTIVE_RADIUS];

if( !isNil "_lockers" ) then {

	_locker = _lockers select 0;
	_doors = (nearestObjects [_locker, [DOOR_SMALL, DOOR_LARGE], EFFECTIVE_RADIUS]);

	if (!isNil "_doors") then {

    //Open All Found doors
		{ [[netId _x, true], "A3W_fnc_hideObjectGlobal", _x] call A3W_fnc_MP; } forEach _doors;

		playSound3d [MISSION_ROOT + "media\klaxon.ogg", _locker, true, getPosASL _locker, 2];

		_keypads = (nearestObjects [player, [KEYPAD], EFFECTIVE_RADIUS]);

		sleep 1;

		if( !isNil "_keypads" ) then {

			{

				_x setObjectTextureGlobal [0, "media\keypadon.paa"];
				if( (_forEachIndex mod 2) == 0 ) then { playSound3d [MISSION_ROOT + "media\lock.ogg", _x, true, getPosASL _x, 2]; };

			} forEach _keypads;

		};

	};

};
