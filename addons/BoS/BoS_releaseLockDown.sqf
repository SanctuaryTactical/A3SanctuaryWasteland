//	@file Version:
//	@file Name:
//	@file Author: Cael817
//	@file Created:

private ["_generators"];

cursorTarget setVariable ["lockDown", false, true];

playSound3d [MISSION_ROOT + "media\offline.ogg", cursorTarget, true, getPosASL cursorTarget, 2];

_generators = [player, "WARNING", "A generator is required within 50 metres to power this base locker.<br/>Better get one soon!"] call CheckPowerSource;

if( _generators == 0 ) then {

	sleep 10;

};

hint "Released Lock Down";
