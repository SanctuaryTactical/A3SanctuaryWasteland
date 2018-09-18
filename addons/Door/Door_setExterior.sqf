// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: Door_setExterior.sqf
//	@file Author: The Scotsman
//	@file Description: Sets a keypad as an "exterior" keypad (allows "Close" Only)

_keypads = (nearestObjects [player, ["Land_Noticeboard_F"], 10]);

if ( count _keypads > 0 ) then {

  _keypad = _keypads select 0;
  _keypad setVariable ["interior", false, true];

};
