// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: Lights_Off.sqf
//	@file Author: The Scotsman
//	@file Description: Lighting Controller

private ["_lights"];

_lights = nearestObjects [player, ["Lamps_base_F", "Land_PortableLight_single_F", "Land_PortableLight_double_F"], 50];

if ( count _lights > 0 ) then {

		{

      _x switchLight "OFF";
			_x setHit ["light_1_hitpoint", 0.97];
			_x setHit ["light_2_hitpoint", 0.97];

		} forEach _lights;

		hint "Lights have been switched off";

} else {

	hint "No Lights Found";

};
