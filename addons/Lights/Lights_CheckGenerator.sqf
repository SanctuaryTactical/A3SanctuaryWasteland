
// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: Lights_CheckGenerator.sqf
//	@file Author: The Scotsman
//	@file Description: Checks for a power source within the specified range (or 50 metres)

params ["_target", "_title", "_message", ["_distance", 50]];

private ["_generators", "_hint", "_count", "_image"];

_generators = nearestObjects [_target, ["Land_PowerGenerator_F"], _distance];
_count = (count _generators);

if( _count == 0 ) then {

  playMusic "ErrorSound";

  //TODO: Generator must be locked
  //"A generator within 50 metres is required to power your base locker.<br/>Better add one soon or your base locker will cease to function properly.
  _image = parseText "<br/><br/><t align='center'><img size='6' image='media\Land_PowerGenerator_F.paa'/></t>";
  _hint = composeText [(parseText _title), _image, (parseText "<br />------------------------<br />") , (parseText _message)];

  hint _hint;

};

_count
