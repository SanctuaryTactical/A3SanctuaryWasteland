//	@file Version:
//	@file Name:
//	@file Author: Cael817
//	@file Created:

#define BoS_Menu_option 17001
disableSerialization;

private ["_panelType","_displayBoS","_BoS_select","_money"];
_uid = getPlayerUID player;
if (!isNil "_uid") then
{
	_panelType = _this select 0;
	_displayBoS = uiNamespace getVariable ["BoS_Menu", displayNull];

	//Must have power generator nearby
	//if( count (nearestObjects [_keypad, ["Land_PowerGenerator_F"], 200) == 0 ) then { hint "No Power Generator could be found, go to the General Store and buy one!"; };

	switch (true) do
	{
		case (!isNull _displayBoS): //BoS panel
		{
			_BoS_select = _displayBoS displayCtrl BoS_Menu_option;

			switch (lbCurSel _BoS_select) do
			{
				case 0: //Mark Owned Object
				{
					closeDialog 0;
					execVM "addons\BoS\BoS_markOwned.sqf";
				};
				case 1: //Show Base Border
				{
					closeDialog 0;
					execVM "addons\BoS\BoS_showBorder.sqf";
				};
				case 2: //Repair Base Locker
				{
					closeDialog 0;
					execVM "addons\BoS\BoS_repairLocker.sqf";
				};
				case 3: //Lock Down Base
				{
					closeDialog 0;
					execVM "addons\BoS\BoS_lockDown.sqf";
				};
				case 4: //Release Lock Down
				{
					closeDialog 0;
					execVM "addons\BoS\BoS_releaseLockDown.sqf";
				};
				case 5: //Turn off all lights
				{
					closeDialog 0;
					execVM "addons\BoS\BoS_lightsOff.sqf";;
				};
				case 6: //Turn on all lighs
				{
					closeDialog 0;
					execVM "addons\BoS\BoS_lightsOn.sqf";
				};
				case 7: //Open Doors
				{
					closeDialog 0;
					execVM "addons\Bos\BoS_OpenAllDoors.sqf";
					hint "All doors have been Opened, Stay Alert!";
				};
				case 8: //Secure Doors
				{
					closeDialog 0;
					nul = [true] execVM "addons\Door\SecureAll.sqf";
				};
				case 9: //Lock All Vehicles
				{
					closeDialog 0;
					execVM "addons\BoS\BoS_LockAllVehicles.sqf";
				};
				case 10: //Change Password
				{
					closeDialog 0;
					execVM "addons\Bos\password_change.sqf";
				};
			};
		};
	};
};
