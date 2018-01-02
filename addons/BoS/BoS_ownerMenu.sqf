//	@file Version:
//	@file Name:
//	@file Author: Cael817, all credit to A3W
//	@file Created:

#define BoS_Menu_option 17001
disableSerialization;

private ["_start","_panelOptions","_BoS_select","_displayBoS"];
_uid = getPlayerUID player;
if (!isNil "_uid") then {
	_start = createDialog "BoS_Menu";

	_displayBoS = uiNamespace getVariable "BoS_Menu";
	_BoS_select = _displayBoS displayCtrl BoS_Menu_option;

	_panelOptions = [
		"Show objects owned by you",
		"Show Base Border",
		"Repair Locker",
		format ["<img image='addons\vactions\icons\lock.paa' color='#ff0000'/>Lock Down Base"],
		format ["<img image='addons\vactions\icons\lock.paa' color='#06ef00'/>Release Lock Down"],
		"Lights OFF",
		"Lights ON",
		"Open All Doors",
		"Secure All Doors",
		"Remote Auto-Lock Vehicles",
		"Change PIN"
	];

	{
		_BoS_select lbAdd _x;
	} forEach _panelOptions;
};
