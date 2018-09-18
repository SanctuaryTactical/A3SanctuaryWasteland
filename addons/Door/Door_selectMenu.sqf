// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: Door_selectMenu.sqf
//	@file Author: LouD / Cael817 for original script
//	@file Description: Door script

//#define PLAYER_CONDITION "(vehicle player == player && {!isNull cursorTarget})"
//#define PLAYER_CONDITION "({!isNull cursorTarget})"
#define PLAYER_CONDITION "((vehicle player == player || vehicle player != player) && {!isNull cursorTarget})"
#define ITEM_CONDITION "{cursortarget iskindof 'Land_Noticeboard_F'} && {(player distance cursortarget) < 10}"
#define OBJECT_CONDITION "{cursorTarget getVariable ['objectLocked', false]}"
#define OPEN_CONDITION "{(cursorTarget getVariable ['objectLocked', false]) && (cursorTarget getVariable ['interior', false])}"

Door_menu = {

	private ["_unit","_uid,", "_owner"];

	_unit = _this select 0;
	_uid = getPlayerUID _unit;
	_owner = cursorTarget getvariable "ownerUID";

	if (!isNull (uiNamespace getVariable ["Door_Menu", displayNull]) && !(player call A3W_fnc_isUnconscious)) exitWith {};

	switch (true) do
	{
		case (_uid == _owner || _uid != _owner):
		{
			execVM "addons\Door\password_enter.sqf";
			hint "Welcome";
		};
		case (isNil _uid || isNull _uid):
		{
			hint "You need to lock the object first!";
		};
		default
		{
		hint "An unknown error occurred. This could be because your door is not locked."
		};

	};
};
Door_close =  {

	execVM "addons\Door\Door_closeDoor.sqf";

};

Door_open = {

	execVM "addons\Door\Door_openDoor.sqf";

};

Door_secure = {

	execVM "addons\BoS\BoS_closeAllDoors.sqf";
	hint "All doors have been secured";

};

Door_Actions =
{
	{ [player, _x] call fn_addManagedAction } forEach
	[
		["<t color='#FFE496'><img image='client\icons\keypad.paa'/> Open door menu</t>", Door_menu, [cursorTarget], -97, false, false, "", PLAYER_CONDITION + " && " + ITEM_CONDITION + " && " + OBJECT_CONDITION],
		["<t color='#31AD08'><img image='client\icons\keypad.paa'/> Open Door</t>", Door_open, [cursorTarget], -97, false, false, "", PLAYER_CONDITION + " && " + ITEM_CONDITION + " && " + OPEN_CONDITION],
		["<t color='#BA150D'><img image='client\icons\keypad.paa'/> Close Door</t>", Door_close, [cursorTarget], -97, false, false, "", PLAYER_CONDITION + " && " + ITEM_CONDITION + " && " + OBJECT_CONDITION],
		["<t color='#BA150D'><img image='client\icons\keypad.paa'/> Secure All Doors</t>", Door_secure, [cursorTarget], -97, false, false, "", PLAYER_CONDITION + " && " + ITEM_CONDITION + " && " + OBJECT_CONDITION]
	];
};

DoorScriptInitialized = true;
