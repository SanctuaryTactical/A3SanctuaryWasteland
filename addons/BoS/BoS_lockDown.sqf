//	@file Version:
//	@file Name:
//	@file Author: Cael817
//	@file Created:

/* private ["_generators"]; */

//Close all doors within the base-locker's radius
execVM "addons\Bos\BoS_closeAllDoors.sqf";

/* _generators = [cursorTarget, "WARNING!", "Base is now under Lock Down... All doors have been secured.<br/>A generator will soon be required to power your base locker.  Better get one soon!"] execVM "1st\STCheckGenerator.sqf";

if( _generators > 0 ) then {

  sleep 5;


} */

hint "Base is now under Lock Down... All doors have been secured.";
cursorTarget setVariable ["lockDown", true, true];

//hint " ";
