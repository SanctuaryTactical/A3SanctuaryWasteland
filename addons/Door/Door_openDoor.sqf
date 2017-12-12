// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: Door_unlockDoor.sqf
//	@file Author: LouD / Cael817 for original script
//	@file Description: Door script

private ["_doors", "_keypads"];
_doors = (nearestObjects [player, ["Land_Bunker_01_blocks_3_F","Land_Bunker_01_blocks_1_F"], 10]);

if (!isNil "_doors") then
{
	{ [[netId _x, true], "A3W_fnc_hideObjectGlobal", _x] call A3W_fnc_MP } forEach _doors;

	_keypads = (nearestObjects [player, ["Land_Noticeboard_F"], 10]);

	if( !isNil "_keypads" ) then {

		{
			_x setObjectTextureGlobal [0, "media\keypadon.paa"];
		} forEach _keypads;

	};

	playMusic "PinLock";
	hint "Your door is opened";
}
else
{
	hint "No locked door found";
};
