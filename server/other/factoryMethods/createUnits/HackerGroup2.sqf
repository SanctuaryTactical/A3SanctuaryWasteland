// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: hackerGroup2.sqf
//	@file Author: AgentRev
//  @file Edit: Lodac

if (!isServer) exitWith {};

private ["_group", "_pos", "_nbUnits", "_unitTypes", "_uPos", "_unit", "_radius"];

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
	_uPos = _pos vectorAdd ([[random 60, 0, 0], random 360] call BIS_fnc_rotateVector2D);
	_unit = _group createUnit [_unitTypes call BIS_fnc_selectRandom, _uPos, [], 1, "Form"];
	_unit setPosATL _uPos;
	
	removeAllAssignedItems _unit;
	sleep 0.1;

	_unit addVest "V_PlateCarrier_Kerry";
	_unit addHeadgear "H_HelmetB_black";

	switch (true) do
	{
		// Titan AT every 3 units
		case (_i % 3 == 0):
		{
			_unit addUniform "U_B_CTRG_1";
			_unit addBackpack "B_Carryall_oli";
			_unit addMagazine "Titan_AT";
			_unit addWeapon "launch_B_Titan_short_F";
			_unit addMagazine "Titan_AT";
			_unit addMagazine "Titan_AT";
			_unit addMagazine "30Rnd_65x39_caseless_green";
			_unit addWeapon "arifle_Katiba_GL_F";
			_unit addPrimaryWeaponItem "optic_MRCO";
			_unit addPrimaryWeaponItem "acc_pointer_IR";
			_unit addMagazine "30Rnd_65x39_caseless_green";
			_unit addMagazine "30Rnd_65x39_caseless_green";
			_unit addMagazine "30Rnd_65x39_caseless_green";
			_unit addMagazine "30Rnd_65x39_caseless_green";
			_unit addMagazine ["SmokeShell", 4];
			_unit addMagazine ["HandGrenade", 2];
			_unit addMagazine ["Chemlight_red", 2];
		};
		// Titan AA every 7 units, starting from second one
		case ((_i + 5) % 7 == 0):
		{
			_unit addUniform "U_B_CTRG_1";
			_unit addBackpack "B_Carryall_khk";
			_unit addMagazine "Titan_AA";
			_unit addWeapon "launch_Titan_F";
			_unit addMagazine "Titan_AA";
			_unit addMagazine "Titan_AA";
			_unit addMagazine "30Rnd_65x39_caseless_green";
			_unit addWeapon "arifle_Katiba_GL_F";
			_unit addPrimaryWeaponItem "optic_MRCO";
			_unit addPrimaryWeaponItem "acc_pointer_IR";
			_unit addMagazine "30Rnd_65x39_caseless_green";
			_unit addMagazine "30Rnd_65x39_caseless_green";
			_unit addMagazine "30Rnd_65x39_caseless_green";
			_unit addMagazine "30Rnd_65x39_caseless_green";
			_unit addMagazine ["SmokeShell", 4];
			_unit addMagazine ["HandGrenade", 2];
			_unit addMagazine ["Chemlight_red", 2];
			_unit addMagazines ["SmokeShellYellow", 1];
		};
		case ((_i + 2) % 2 == 0):
		{
			_unit addUniform "U_B_CTRG_1";
			_unit addBackpack "B_Bergen_blk";
			_unit addMagazine "130Rnd_338_Mag";
			_unit addWeapon "MMG_02_black_F";
			_unit addPrimaryWeaponItem "acc_pointer_IR";
			_unit addMagazine "130Rnd_338_Mag";
			_unit addMagazine "130Rnd_338_Mag";
			_unit addMagazine ["SmokeShell", 4];
			_unit addMagazine ["HandGrenade", 2];
			_unit addMagazine ["Chemlight_red", 2];
		};
		default
		{
			_unit addUniform "U_B_CTRG_1";
			_unit addBackpack "B_Bergen_blk";
			_unit addMagazine "20Rnd_762x51_Mag";
			_unit addWeapon "srifle_EBR_ARCO_pointer_snds_F";
			_unit addPrimaryWeaponItem "acc_pointer_IR";
			_unit addMagazine "20Rnd_762x51_Mag";
			_unit addMagazine "20Rnd_762x51_Mag";
			_unit addMagazine ["SmokeShell", 4];
			_unit addMagazine ["HandGrenade", 2];
			_unit addMagazine ["Chemlight_red", 2];
		};
	};

	_unit addRating 1e11;
	_unit call setMissionSkill;
	_unit addEventHandler ["Killed", server_playerDied];
};

[_group, _pos] call defendArea;
