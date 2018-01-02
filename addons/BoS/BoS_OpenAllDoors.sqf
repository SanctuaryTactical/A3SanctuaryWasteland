private ["_doors", "_locker", "_keypads"];

_lockers = nearestObjects [player, ["Land_Device_assembled_F"], 200];

if( !isNil "_lockers" ) then {

	_locker = _lockers select 0;
	_doors = (nearestObjects [_locker, ["Land_Bunker_01_blocks_3_F","Land_Bunker_01_blocks_1_F"], 200]);

	if (!isNil "_doors") then
	{

		{
			[[netId _x, true], "A3W_fnc_hideObjectGlobal", _x] call A3W_fnc_MP;

		} forEach _doors;

		playSound3d [MISSION_ROOT + "media\klaxon.ogg", _locker, true, getPosASL _locker, 2];

		_keypads = (nearestObjects [player, ["Land_Noticeboard_F"], 200]);

		sleep 1;

		if( !isNil "_keypads" ) then {

			{

				_x setObjectTextureGlobal [0, "media\keypadon.paa"];
				if( (_forEachIndex mod 2) == 0 ) then { playSound3d [MISSION_ROOT + "media\lock.ogg", _x, true, getPosASL _x, 2]; };

			} forEach _keypads;

		};

	};

};
