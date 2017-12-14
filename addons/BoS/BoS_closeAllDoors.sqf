
private ["_doors", "_keypads"];

_lockers = nearestObjects [player, ["Land_Device_assembled_F"], 200];

if( !isNil "_lockers" ) then {

	_doors = (nearestObjects [_lockers select 0, ["Land_Bunker_01_blocks_3_F","Land_Bunker_01_blocks_1_F"], 200]);

	if (!isNil "_doors") then
	{
		{ [[netId _x, false], "A3W_fnc_hideObjectGlobal", _x] call A3W_fnc_MP } forEach _doors;

		_keypads = (nearestObjects [player, ["Land_Noticeboard_F"], 200]);

		if( !isNil "_keypads" ) then {

			{
				_x setObjectTextureGlobal [0, "media\keypad.paa"];
			} forEach _keypads;

		};

		playMusic "SecureDoors";
	
	};

};
