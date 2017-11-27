// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: customGroup.sqf
//	@file Author: AgentRev

if (!isServer) exitWith {};

private ["_group", "_pos", "_nbUnits", "_unitTypes", "_uPos", "_unit"];

_group = _this select 0;
_pos = _this select 1;
_nbUnits = [_this, 2, 7, [0]] call BIS_fnc_param;
_radius = [_this, 3, 10, [0]] call BIS_fnc_param;

_unitTypes =
[
	"C_man_polo_1_F", "C_man_polo_1_F_euro", "C_man_polo_1_F_afro", "C_man_polo_1_F_asia",
	"C_man_polo_2_F", "C_man_polo_2_F_euro", "C_man_polo_2_F_afro", "C_man_polo_2_F_asia",
	"C_man_polo_3_F", "C_man_polo_3_F_euro", "C_man_polo_3_F_afro", "C_man_polo_3_F_asia",
	"C_man_polo_4_F", "C_man_polo_4_F_euro", "C_man_polo_4_F_afro", "C_man_polo_4_F_asia",
	"C_man_polo_5_F", "C_man_polo_5_F_euro", "C_man_polo_5_F_afro", "C_man_polo_5_F_asia",
	"C_man_polo_6_F", "C_man_polo_6_F_euro", "C_man_polo_6_F_afro", "C_man_polo_6_F_asia"
];

for "_i" from 1 to _nbUnits do
{
	_uPos = _pos vectorAdd ([[random _radius, random _radius, 0], random 360] call BIS_fnc_rotateVector2D);
	_unit = _group createUnit [_unitTypes call BIS_fnc_selectRandom, _uPos, [], 0, "Form"];
	_unit setPosATL _uPos;
	
	removeAllWeapons _unit;
	removeAllAssignedItems _unit;
	removeUniform _unit;
	removeVest _unit;
	removeBackpack _unit;
	removeHeadgear _unit;
	removeGoggles _unit;

	_unit addVest "V_TacVest_blk_POLICE";
	_unit addUniform "U_C_Driver_3";

	switch (true) do
	{
		case (1):
		{
			_unit addUniform "U_B_CombatUniform_mcam_vest";
			_unit addBackpack "B_Kitbag_mcamo";
			_unit addWeapon "arifle_TRG20_F";
			_unit addMagazine "Titan_AA";
			_unit addWeapon "launch_B_Titan_F";
			_unit addMagazine "Titan_AA";
			_unit addMagazine "Titan_AA";
		};
		// AT every 5 units
		case (_i % 5 == 0):
		{
			_unit addBackpack "B_TacticalPack_blk";
			_unit addItem "NVGoggles";
			_unit assignItem "NVGoggles";
			_unit addMagazine "30Rnd_65x39_caseless_mag";
			_unit addWeapon "arifle_MX_F";
			_unit addMagazine "30Rnd_65x39_caseless_mag";
			_unit addMagazine "30Rnd_65x39_caseless_mag";
			_unit addMagazine "30Rnd_65x39_caseless_mag";
			_unit addPrimaryWeaponItem "optic_MRCO";
			_unit addMagazine "Titan_AT";
			_unit addWeapon "launch_Titan_short_F";
		};
		// Sniper every 6 units
		case (_i % 6 == 0):
		{
			_unit addMagazine "20Rnd_762x51_Mag";
			_unit addWeapon "srifle_DMR_06_olive_F";
			_unit addMagazine "20Rnd_762x51_Mag";
			_unit addMagazine "20Rnd_762x51_Mag";
			_unit addMagazine "20Rnd_762x51_Mag";
			_unit addPrimaryWeaponItem "optic_tws";
		};
		// AA every 7 units
		case (_i % 7 == 0):
		{
			_unit addBackpack "B_TacticalPack_blk";
			_unit addMagazine "30Rnd_65x39_caseless_mag";
			_unit addWeapon "arifle_MX_F";
			_unit addMagazine "30Rnd_65x39_caseless_mag";
			_unit addMagazine "30Rnd_65x39_caseless_mag";
			_unit addMagazine "30Rnd_65x39_caseless_mag";
			_unit addPrimaryWeaponItem "optic_Arco";
			_unit addMagazine "Titan_AA";
			_unit addWeapon "launch_I_Titan_F";
			
		};
		// Rifleman
		default
		{
			if (_unit == leader _group) then
			{
				_unit addMagazine "30Rnd_65x39_caseless_mag";
				_unit addWeapon "arifle_MXM_Black_F";
				_unit addMagazine "30Rnd_65x39_caseless_mag";
				_unit addMagazine "30Rnd_65x39_caseless_mag";
				_unit addMagazine "30Rnd_65x39_caseless_mag";
				_unit addPrimaryWeaponItem "optic_Hamr";
				_unit addMagazine "HandGrenade";
				_unit setRank "SERGEANT";
			}
			else
			{
				_unit addMagazine "30Rnd_556x45_Stanag_Tracer_Red";
				_unit addWeapon "arifle_TRG20_F";
				_unit addMagazine "30Rnd_556x45_Stanag_Tracer_Red";
				_unit addMagazine "30Rnd_556x45_Stanag_Tracer_Red";
				_unit addMagazine "30Rnd_556x45_Stanag_Tracer_Red";
				_unit addPrimaryWeaponItem "optic_Aco";
				_unit addMagazine "HandGrenade";
			};
		};
	};

	_unit addPrimaryWeaponItem "acc_flashlight";
	_unit enablegunlights "forceOn";

	_unit addRating 1e11;
	_unit addHeadgear "H_Cap_press";
	_unit addGoggles "G_Balaclava_blk";
	_unit spawn refillPrimaryAmmo;
	_unit call setMissionSkill;
	_unit addEventHandler ["Killed", server_playerDied];
};

[_group, _pos, "LandVehicle"] call defendArea;
