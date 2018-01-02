// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: Door_closeRoof.sqf
//	@file Author: The Scotsman
//	@file Description: Close Roof Panels

private ["_roofs", "_roof", "_keypad", "_keypads"];

_keypads = (nearestObjects [player, ["Land_Noticeboard_F"], 10]);

if( count _keypads > 0 ) then {

  _keypad = _keypads select 0;

  _roofs = (nearestObjects [_keypad, ["ContainmentArea_01_forest_F"], 40]);

  if( count _roofs > 0 ) then {

    {
			[[netId _x, false], "A3W_fnc_hideObjectGlobal", _x] call A3W_fnc_MP;
		} forEach _roofs;

		_roof = _roofs select 0;
		playSound3d [MISSION_ROOT + "media\hiss.ogg", _roof, true, getPosASL _roof, 1];

		hint "Roof panels are now closed";

    //Switch Display on KeyPad
    _keypads = (nearestObjects [_roof, ["Land_Noticeboard_F"], 40]);

    if( !isNil "_keypads" ) then {

      {
        _x setObjectTextureGlobal [0, "media\keypad.paa"];
      } forEach _keypads;

    };

  } else {

    hint "No Roof Panels Found";
    playSound3d [MISSION_ROOT + "media\error.ogg", _roof, true, getPosASL _roof, 1];

  };

};
