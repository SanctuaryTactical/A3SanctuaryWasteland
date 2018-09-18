// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: init.sqf
//	@file Author: The Scotsman
//	@file Description: Adds controllable lights

waitUntil {time > 0};

//Check for a power source within 50 metres
CheckPowerSource = "addons\Lights\Lights_CheckGenerator.sqf" call mf_compile;

execVM "addons\Lights\Lights_SelectMenu.sqf";
waitUntil {!isNil "LightScriptInitialized"};
[player] call Light_Actions;
