// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: Lights_selectMenu.sqf
//	@file Author: The Scotsman
//	@file Description: Lighting Controller

#define PLAYER_CONDITION "((vehicle player == player || vehicle player != player) && {!isNull cursorTarget})"
#define ITEM_CONDITION "{cursortarget iskindof 'Land_PowerGenerator_F'} && {(player distance cursortarget) < 5}"
#define OBJECT_CONDITION "{cursorTarget getVariable ['objectLocked', false]}"
#define IS_LIGHT "{(typeof cursortarget) in ['Lamps_base_F','Land_PortableLight_single_F', 'Land_PortableLight_double_F']} && {(player distance cursortarget) < 5}"

Lights_on =  {

	execVM "addons\Lights\Lights_On.sqf";

};

Light_on =  {

	private ["_generators"];

	_generators = [cursorTarget, "ERROR", "A generator is required within 50 metres to power this light"] call CheckPowerSource;

	if( _generators > 0 ) then {

		cursorTarget switchLight "ON";
		cursorTarget setHit ["light_1_hitpoint", 0];
		cursorTarget setHit ["light_2_hitpoint", 0];

	};

};

Lights_off = {

	execVM "addons\Lights\Lights_Off.sqf";

};

Light_off = {

	cursorTarget switchLight "OFF";
	cursorTarget setHit ["light_1_hitpoint", 0.97];
	cursorTarget setHit ["light_2_hitpoint", 0.97];

};

Light_Actions = {
	{ [player, _x] call fn_addManagedAction } forEach
	[
		["<t color='#31AD08'><img image='client\icons\keypad.paa'/> Turn All Lights On</t>", Lights_on, [cursorTarget], -97, false, false, "", PLAYER_CONDITION + " && " + ITEM_CONDITION + " && " + OBJECT_CONDITION],
		["<t color='#BA150D'><img image='client\icons\keypad.paa'/> Turn All Lights Off</t>", Lights_off, [cursorTarget], -97, false, false, "", PLAYER_CONDITION + " && " + ITEM_CONDITION + " && " + OBJECT_CONDITION],
		["<t color='#31AD08'><img image='client\icons\keypad.paa'/> Light On</t>", Light_on, [cursorTarget], -97, false, false, "", PLAYER_CONDITION + " && " + IS_LIGHT + " && " + OBJECT_CONDITION],
		["<t color='#BA150D'><img image='client\icons\keypad.paa'/> Light Off</t>", Light_off, [cursorTarget], -97, false, false, "", PLAYER_CONDITION + " && " + IS_LIGHT + " && " + OBJECT_CONDITION]
	];
};

LightScriptInitialized = true;
