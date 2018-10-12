//	@file Version:
//	@file Name:
//	@file Author: Cael817
//	@file Created:

private ["_generators"];

//Close all doors within the base-locker's radius
nul = [false] execVM "addons\Door\SecureAll.sqf";

cursorTarget setVariable ["lockDown", true, true];

_generators = [player, "WARNING", "A generator is required within 50 metres to power this base locker.<br/>Better get one soon!"] call CheckPowerSource;

if( _generators == 0 ) then {

	sleep 10;

};

hint "Base is now under Lock Down... All doors have been secured.";
