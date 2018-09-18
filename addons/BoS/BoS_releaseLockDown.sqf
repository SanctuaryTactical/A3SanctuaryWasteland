//	@file Version:
//	@file Name:
//	@file Author: Cael817
//	@file Created:

/* private ["_generators"];

_generators = [cursorTarget, "WARNING!", "Lock down has been released...<br/>A generator will soon be required to power your base locker.  Better get one soon!"] execVM "1st\STCheckGenerator.sqf";



if( _generators > 0 ) then {

  sleep 5;



} */

cursorTarget setVariable ["lockDown", false, true];

hint "Released Lock Down";
playSound3d [MISSION_ROOT + "media\offline.ogg", cursorTarget, true, getPosASL cursorTarget, 2];
