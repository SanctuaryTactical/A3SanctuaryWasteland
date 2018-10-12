// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: Door_RoofController.sqf
//	@file Author: The Scotsman
//	@file Description: Control roof panels and domes

#include "DoorDefines.sqf"

params ["_open"];

private ["_roofs", "_roof", "_keypad", "_keypads", "_generators", "_keypadTexture", "_hint", "_object"];

_keypadTexture = "media\keypad.paa";

if( _open ) then { _keypadTexture = "media\keypadon.paa"; };

_generators = [player, "WARNING", "A generator is required within 50 metres to power roof panels.<br/>Better get one REALLY soon man!"] call CheckPowerSource;

if( _generators == 0 ) then { sleep 5; };

//Must have power generator nearby
//if( count (nearestObjects [_keypad, ["Land_PowerGenerator_F"], 200) == 0 ) then { hint "No Power Generator could be found, go to the General Store and buy one!"; };

_keypads = (nearestObjects [player, [KEYPAD], 10]);

if( count _keypads > 0 ) then {

  _keypad = _keypads select 0;
	_roofs = (nearestObjects [_keypad, [DOME], 20]);

  //If a Dome is found within 5-metres use that, otherwise look for Roof Panels
	if( count _roofs == 0 ) then {

    //Find Roof Panels within 40 metres
		_roofs = (nearestObjects [_keypad, [ROOF_PANEL], 40]);

	   //Get All roofs "connected" to this roof (within 10 metres)
		if( count _roofs > 0 ) then { _roofs = (nearestObjects [(_roofs select 0), [ROOF_PANEL], 20]); };

	};

	if( count _roofs == 0 ) then {

		hint "No Roof Panels Found";
		playSound3d [MISSION_ROOT + "media\error.ogg", player, true, getPosASL player, 1];

  } else {

    _roof = _roofs select 0;

    playSound3d [MISSION_ROOT + "media\hiss.ogg", _roof, true, getPosASL _roof, 1];

    //Open (Or Close)the detected objects
    {
      [[netId _x, _open], "A3W_fnc_hideObjectGlobal", _x] call A3W_fnc_MP;
    } forEach _roofs;

    //Switch the texture on the keypads
    {
      _x setObjectTextureGlobal [0, _keypadTexture];
    } forEach _keypads;

    _object = if( _roof isKindOf DOME ) then { "Dome" } else { "Roof Panels" };
    _hint = if( _open ) then { "opened" } else { "closed" };

    hint format ["%1 %2", _object, _hint];

  };

};
