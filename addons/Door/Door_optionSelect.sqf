// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: Door_optionSelect.sqf
//	@file Author: LouD / Cael817 for original script
//	@file Description: Door script

#define Door_Menu_option 17001

#define DOOR_OPEN 0
#define DOOR_CLOSE 1
#define ROOF_OPEN 2
#define ROOF_CLOSE 3
#define CHANGE_PASSWORD 4
#define SET_TYPE_INTERIOR 5
#define SET_TYPE_EXTERIOR 6
#define SECURE_ALL 7

disableSerialization;

private ["_panelType","_displayDoor","_Door_select", "Door_switchType"];

Door_switchType = {

	params ["_int"];
	private ["_keypads","_keypad"];

	_keypads = (nearestObjects [player, ["Land_Noticeboard_F"], 10]);

	if ( count _keypads > 0 ) then {

	  _keypad = _keypads select 0;
	  _keypad setVariable ["interior", _int, true];

	};

};

_uid = getPlayerUID player;

if (!isNil "_uid") then {

	_panelType = _this select 0;
	_displayDoor = uiNamespace getVariable ["Door_Menu", displayNull];

	switch (true) do {
		case (!isNull _displayDoor): //Door panel
		{
			_Door_select = _displayDoor displayCtrl Door_Menu_option;

			switch (lbCurSel _Door_select) do {
				case DOOR_OPEN: //Lock Door
				{
					closeDialog 0;
					//execVM "addons\Door\Door_openDoor.sqf";
					nul = [true] execVM "addons\Door\DoorController.sqf";
				};
				case DOOR_CLOSE: //Unlock Door
				{
					closeDialog 0;
					//execVM "addons\Door\Door_closeDoor.sqf";
					nul = [false] execVM "addons\Door\DoorController.sqf";
				};
				case ROOF_OPEN: {

					//Open Roof
					closeDialog 0;
				  nul = [true] execVM "addons\Door\RoofController.sqf";

				};
				case ROOF_CLOSE: { //Close Roof

					closeDialog 0;
					nul = [false] execVM "addons\Door\RoofController.sqf";

				};
				case CHANGE_PASSWORD: //Change Password
				{
					closeDialog 0;
					execVM "addons\Door\ChangePassword.sqf";
				};
				case SET_TYPE_INTERIOR:
				{
					closeDialog 0;
					[true] call Door_switchType;
				};
				case SET_TYPE_EXTERIOR:
				{
					closeDialog 0;
					[false] call Door_switchType;
				};
				case SECURE_ALL: //Secure All Doors
				{
					closeDialog 0;
					nul = [true] execVM "addons\Door\SecureAll.sqf";

				};
			};
		};
	};
};
