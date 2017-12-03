// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: objectCreation.sqf
//	@file Author: [404] Deadbeat, [GoT] JoSchaap, AgentRev

if (!isServer) exitWith {};

private ["_objPos", "_objList", "_objClass", "_obj", "_allowDamage", "_adjustZ", "_pos"];
_objPos = _this select 0;
_objList = _this select 1;

_objClass = _objList call BIS_fnc_selectRandom;
_obj = createVehicle [_objClass, _objPos, [], 50, "NONE"];

_allowDamage = false;

switch (true) do
{
	case (_objClass == "Land_BarrelWater_F"):
	{
		_obj setVariable ["water", 50, true];
	};
	case (_objClass == "Land_WaterTank_F"):
	{
		_obj setVariable ["water", 500, true];
	};
	case (_objClass == "Land_CratesWooden_F"):
	{
		_obj setVariable ["water", 500, true];
	};
	case (_objClass == "Land_Sacks_goods_F"):
	{
		_obj setVariable ["food", 40, true];
	};
	case (_objClass == "Land_MobileScafolding_01_F"):
	{
		_obj enableSimulationGlobal false;
	};
	case (_objClass isKindOf "ReammoBox_F"):
	{
		clearMagazineCargoGlobal _obj;
		clearWeaponCargoGlobal _obj;
		clearItemCargoGlobal _obj;

		_obj addMagazineCargoGlobal ["16Rnd_9x21_Mag", 10];
		_obj addMagazineCargoGlobal ["9Rnd_45ACP_Mag", 10];
		//_obj addMagazineCargoGlobal ["Laserbatteries", 1];
		//_obj addWeaponCargoGlobal ["Laserdesignator", 1];
		_obj addWeaponCargoGlobal ["Rangefinder", 2];
		_obj addWeaponCargoGlobal ["Binocular", 5];
		_obj addItemCargoGlobal ["FirstAidKit", 10];
		_obj addItemCargoGlobal ["ItemGPS", 5];
		_obj addItemCargoGlobal ["Medikit", 4];
		_obj addItemCargoGlobal ["ToolKit", 2];
	};
	default
	{

		//_allowDamage = true;
		_allowDamage = !({_obj isKindOf _x} count ["ReammoBox_F", "Land_ConcreteWall_01_l_4m_F", "Land_ConcreteWall_01_l_8m_F", "Land_ConcreteWall_01_l_gate_F", "Land_Sidewalk_01_8m_F","Land_Sidewalk_01_4m_F","Land_Sidewalk_01_narrow_4m_F","Land_Sidewalk_01_narrow_8m_F"] > 0);
	};
};

_obj allowDamage _allowDamage;
_obj setVariable ["allowDamage", _allowDamage, true];

// fix for sunken/rissen objects :)
_adjustZ = switch (true) do
{
	case (_objClass == "Land_Scaffolding_F"):         { -3 };
	case (_objClass == "Land_Canal_WallSmall_10m_F"): { 3 };
	case (_objClass == "Land_Canal_Wall_Stairs_F"):   { 3 };
	case (_objClass == "Land_runway_edgelight"):   { 4 };
	case (_objClass == "Land_runway_edgelight_blue_F"):   { 4 };
	case (_objClass == "Land_Flush_Light_red_F"):   { 4 };
	default                                           { 0 };
};

_pos = getPosATL _obj;
_pos set [2, (_pos select 2) + _adjustZ];
_obj setPos _pos;

[_obj] call basePartSetup;
