// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.2
//	@file Name: playerActions.sqf
//	@file Author: [404] Deadbeat, [404] Costlyy, [GoT] JoSchaap, AgentRev
//	@file Created: 20/11/2012 05:19

{ [player, _x] call fn_addManagedAction } forEach
[
	//["Holster Weapon", { player action ["SwitchWeapon", player, player, 100] }, [], -11, false, false, "", "vehicle player == player && currentWeapon player != '' && (stance player != 'CROUCH' || currentWeapon player != handgunWeapon player)"], // A3 v1.58 bug, holstering handgun while crouched causes infinite anim loop
	//["Unholster Primary Weapon", { player action ["SwitchWeapon", player, player, 0] }, [], -11, false, false, "", "vehicle player == player && currentWeapon player == '' && primaryWeapon player != ''"],

	[format ["<img image='client\icons\playerMenu.paa' color='%1'/> <t color='%1'>[</t>Player Menu<t color='%1'>]</t>", "#FF8000"], "client\systems\playerMenu\init.sqf", [], -10, false], //, false, "", ""],

	["<img image='client\icons\money.paa'/> Pickup Money", "client\actions\pickupMoney.sqf", [], 1, false, false, "", "{_x getVariable ['owner', ''] != 'mission'} count (player nearEntities ['Land_Money_F', 5]) > 0"],

	["<img image='\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\transport_ca.paa'/> <t color='#FFFFFF'>Cancel Action</t>", { doCancelAction = true }, [], 1, false, false, "", "mutexScriptInProgress"],

	["<img image='client\icons\repair.paa'/> Salvage", "client\actions\salvage.sqf", [], 1.1, false, false, "", "!isNull cursorTarget && !alive cursorTarget && {cursorTarget isKindOf 'AllVehicles' && !(cursorTarget isKindOf 'Man') && player distance cursorTarget <= (sizeOf typeOf cursorTarget / 3) max 3}"],
	[format ["<img image='client\icons\search.paa' color='%1'/> Find Your Stuff", "#FFE496"], "addons\scripts\markOwned.sqf", [], -95,false,false,"","{_x in ['ItemGPS','B_UavTerminal','O_UavTerminal','I_UavTerminal']} count assignedItems player > 0"],

	//[format ["<img image='client\icons\food.paa' color='%1'/> Pickup Can-o-Rabbit Meat", "#83140B"], "client\actions\rabbit.sqf", [], 1.1, false, false, "", "!isNull cursorTarget && !alive cursorTarget && {cursorTarget isKindOf 'Rabbit_F' && !(MF_ITEMS_CANNED_FOOD call mf_inventory_is_full) && player distance cursorTarget <= (sizeOf typeOf cursorTarget / 3) max 3}"],

	[format ["<img image='client\icons\rip.paa' color='%1'/> Bury Body", "#83140B"], "client\actions\hide.sqf", [], 1.1, false, false, "", "!isNull cursorTarget && !alive cursorTarget && {cursorTarget isKindOf 'Man' && player distance cursorTarget <= (sizeOf typeOf cursorTarget / 3) max 2}"],

	// If you have a custom vehicle licence system, simply remove/comment the following action
	//["<img image='client\icons\r3f_unlock.paa'/> Acquire Vehicle Ownership", "client\actions\takeOwnership.sqf", [], 1, false, false, "", "[] call fn_canTakeOwnership isEqualTo ''"],

	["[0]"] call getPushPlaneAction,
	["Push vehicle", "server\functions\pushVehicle.sqf", [2.5, true], 1, false, false, "", "[2.5] call canPushVehicleOnFoot"],
	["Push vehicle forward", "server\functions\pushVehicle.sqf", [2.5], 1, false, false, "", "[2.5] call canPushWatercraft"],
	["Push vehicle backward", "server\functions\pushVehicle.sqf", [-2.5], 1, false, false, "", "[-2.5] call canPushWatercraft"],

	["<img image='client\icons\driver.paa'/> Enable driver assist", fn_enableDriverAssist, [], 0.5, false, true, "", "_veh = objectParent player; alive _veh && !alive driver _veh && {effectiveCommander _veh == player && player in [gunner _veh, commander _veh] && {_veh isKindOf _x} count ['LandVehicle','Ship'] > 0 && !(_veh isKindOf 'StaticWeapon')}"],
	["<img image='client\icons\driver.paa'/> Disable driver assist", fn_disableDriverAssist, [], 0.5, false, true, "", "_driver = driver objectParent player; isAgent teamMember _driver && {(_driver getVariable ['A3W_driverAssistOwner', objNull]) in [player,objNull]}"],

	[format ["<t color='#FF0000'>Emergency eject (Ctrl+%1)</t>", (actionKeysNamesArray "GetOver") param [0,"<'Step over' keybind>"]],  { [[], fn_emergencyEject] execFSM "call.fsm" }, [], -9, false, true, "", "(vehicle player) isKindOf 'Air' && !((vehicle player) isKindOf 'ParachuteBase')"],
	[format ["<t color='#FF00FF'>Open magic parachute (%1)</t>", (actionKeysNamesArray "GetOver") param [0,"<'Step over' keybind>"]], A3W_fnc_openParachute, [], 20, true, true, "", "vehicle player == player && (getPos player) select 2 > 2.5"],
	[format ["<img image='\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\supplydrop_ca.paa' color='%1'/> <t color='%1'>[</t>Airdrop Menu<t color='%1'>]</t>", "#FF0000"],"addons\APOC_Airdrop_Assistance\APOC_cli_menu.sqf",[], -100, false, false]

];

if (["A3W_vehicleLocking"] call isConfigOn) then
{
	//[player, ["<img image='client\icons\r3f_unlock.paa'/> Pick Lock", "addons\scripts\lockPick.sqf", [cursorTarget], 1, false, false, "", "alive cursorTarget && player distance cursorTarget <= (sizeOf typeOf cursorTarget / 3) max 3 && {{cursorTarget isKindOf _x} count ['LandVehicle','Ship','Air'] > 0 && {locked cursorTarget == 2 && !(cursorTarget getVariable ['A3W_lockpickDisabled',false]) && cursorTarget getVariable ['ownerUID','0'] != getPlayerUID player && 'ToolKit' in items player}}"]] call //fn_addManagedAction;
};

// Hehehe..
if !(288520 in getDLCs 1) then
{
	[player, ["<t color='#00FFFF'>Get in as Driver</t>", "client\actions\moveInDriver.sqf", [], 6, true, true, "", "cursorTarget isKindOf 'Kart_01_Base_F' && player distance cursorTarget < 3.4 && isNull driver cursorTarget"]] call fn_addManagedAction;
};

//Sad Attempt at "pick-up all"
/* _pickUpAll = {

	//Now What?
	_things = _this select 0;

	{
		switch(true) do
			case( _x isKindOf "Land_Money_F"): { ExecVM "client\actions\pickupMoney.sqf"; };
			case( _x isKindOf "Land_BakedBeans_F"): { [MF_ITEMS_CANNED_FOOD, "Canned Food", {50 call mf_items_survival_eat}, "Land_BakedBeans_F","client\icons\cannedfood.paa", 5] call mf_inventory_create; };
			case( _x isKindOf "Land_BottlePlastic_V2_F"): { [MF_ITEMS_WATER, "Water Bottle", {50 call mf_items_survival_drink}, "Land_BottlePlastic_V2_F","client\icons\waterbottle.paa", 5] call mf_inventory_create; };
			//case( _x isKindOf "Land_SatellitePhone_F"): { [MF_ITEMS_PINLOCK, "Vehicle Pinlock", _applypin, MF_ITEMS_PINLOCK_TYPE, MF_ITEMS_PINLOCK_ICON, _maxVehiclePins] call mf_inventory_create; };
			case( _x isKindOf "Land_Sleeping_bag_folded_F"): {};
			case( _x isKindOf "Land_SuitCase_F"): {};
		};

		//[MF_ITEMS_CANNED_FOOD, "Canned Food", {50 call mf_items_survival_eat}, "Land_BakedBeans_F","client\icons\cannedfood.paa", 5] call mf_inventory_create;
		//[MF_ITEMS_WATER, "Water Bottle", {50 call mf_items_survival_drink}, "Land_BottlePlastic_V2_F","client\icons\waterbottle.paa", 5] call mf_inventory_create;

	} foreach _things;

};

_stuff = nearestObjects [player, ["Land_Money_F", "Land_BakedBeans_F", "Land_BottlePlastic_V2_F", "Land_SatellitePhone_F", "Land_Sleeping_bag_folded_F", "Land_SuitCase_F"], 10];

[player, ["Pick Up Stuff", { [_stuff] call _pickUpAll }, [], -9.5, false, true, "", "!(isNil '_stuff') && _stuff count > 0"]] call fn_addManagedAction; */


if (["A3W_savingMethod", "profile"] call getPublicVar == "extDB") then
{
	if (["A3W_vehicleSaving"] call isConfigOn) then
	{
		[player, ["<img image='client\icons\save.paa'/> Force Save Vehicle", { cursorTarget call fn_forceSaveVehicle }, [], -9.5, false, true, "", "call canForceSaveVehicle"]] call fn_addManagedAction;
	};

	if (["A3W_staticWeaponSaving"] call isConfigOn) then
	{
		[player, ["<img image='client\icons\save.paa'/> Force Save Turret", { cursorTarget call fn_forceSaveObject }, [], -9.5, false, true, "", "call canForceSaveStaticWeapon"]] call fn_addManagedAction;
	};
};
