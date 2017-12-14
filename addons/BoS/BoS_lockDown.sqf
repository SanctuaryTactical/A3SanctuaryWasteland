//	@file Version:
//	@file Name:
//	@file Author: Cael817
//	@file Created:

//Close all doors within the base-locker's radius
execVM "addons\Bos\BoS_closeAllDoors.sqf";

cursorTarget setVariable ["lockDown", true, true];
hint "Base is now under Lock Down\nAll doors have been secured ";
