//	@file Version: 1.0
//	@file Name: midGroup.sqf
//	@file Author: [404] Deadbeat, [404] Costlyy, AgentRev
//	@file Created: 08/12/2012 21:58
//	@file Args:

if (!isServer) exitWith {};

private ["_group", "_pos", "_leader", "_man2", "_man3", "U_C_Scientist", "_man5", "_man6"];

_group = _this select 0;
_pos = _this select 1;

// Leader
_leader = _group createUnit ["C_man_polo_1_F", [(_pos select 0) + 10, _pos select 1, 0], [], 1, "Form"];
removeAllAssignedItems _leader;
_leader addUniform "U_I_C_Soldier_Para_5_F";
_leader addVest "V_Chestrig_blk";
_leader addBackpack "B_Carryall_oli";
_leader addMagazine "5.56mm x 39 30Rnd";
_leader addWeapon "arifle_mas_ak_74m_sf";
_leader addPrimaryWeaponItem "optic_Hamr";
_leader addMagazine "5.56mm x 39 30Rnd";
_leader addMagazine "5.56mm x 39 30Rnd";
_leader addMagazine "RPG32_F";
_leader addWeapon "launch_RPG32_F";
_leader addMagazine "RPG32_F";
_leader addHeadgear "H_Beret_02";
_leader addGoggles "G_Bandanna_aviator";


// Soldier2
_man2 = _group createUnit ["C_man_polo_2_F", [(_pos select 0) - 30, _pos select 1, 0], [], 1, "Form"];
removeAllAssignedItems _man2;
_man2 addUniform "U_I_C_Soldier_Para_4_F";
_man2 addVest "V_Chestrig_blk";
_man2 addBackpack "B_Carryall_oli";
_man2 addMagazine "5.56mm x 39 30Rnd";
_man2 addWeapon "arifle_mas_ak_74m_sf";
_man2 addPrimaryWeaponItem "optic_Hamr";
_man2 addMagazine "5.56mm x 39 30Rnd";
_man2 addMagazine "mas_MAAWS";
_man2 addWeapon "mas_launch_maaws_F";
_man2 addMagazine "mas_MAAWS";
_man2 addHeadgear "H_Booniehat_khk";
_man2 addGoggles "G_Bandanna_aviator";

// Soldier3
_man3 = _group createUnit ["C_man_polo_3_F", [_pos select 0, (_pos select 1) + 30, 0], [], 1, "Form"];
removeAllAssignedItems _man3;
_man3 addUniform "U_I_C_Soldier_Para_3_F";
_man3 addVest "V_Chestrig_blk";
_man3 addMagazine "5.56mm x 39 30Rnd";
_man3 addPrimaryWeaponItem "optic_Hamr";
_man3 addWeapon "arifle_mas_ak_74m_sf";
_man3 addMagazine "5.56mm x 39 30Rnd";
_man3 addMagazine "5.56mm x 39 30Rnd";
_man3 addHeadgear "H_Cap_tan";
_man3 addGoggles "G_Aviator";

// Soldier4
U_C_Scientist = _group createUnit ["C_man_polo_4_F", [_pos select 0, (_pos select 1) + 40, 0], [], 1, "Form"];
removeAllAssignedItems U_C_Scientist;
U_C_Scientist addUniform "U_I_C_Soldier_Para_2_F";
U_C_Scientist addVest "V_Chestrig_blk";
U_C_Scientist addMagazine "5.56mm x 39 30Rnd";
U_C_Scientist addWeapon "arifle_mas_ak_74m_sf";
U_C_Scientist addPrimaryWeaponItem "optic_Hamr";
U_C_Scientist addMagazine "5.56mm x 39 30Rnd";
U_C_Scientist addMagazine "5.56mm x 39 30Rnd";
U_C_Scientist addHeadgear "H_Cap_brn_SPECOPS";
U_C_Scientist addGoggles "G_Aviator";


// Soldier5
_man5 = _group createUnit ["C_man_polo_5_F", [_pos select 0, (_pos select 1) + 40, 0], [], 1, "Form"];
removeAllAssignedItems _man5;
_man5 addUniform "U_I_C_Soldier_Para_1_F";
_man5 addVest "V_PlateCarrierGL_rgr";
_man5 addMagazine "5.56mm x 39 30Rnd";
_man5 addWeapon "arifle_mas_ak_74m_sf";
_man5 addPrimaryWeaponItem "optic_Hamr";
_man5 addMagazine "5.56mm x 39 30Rnd";
_man5 addMagazine "5.56mm x 39 30Rnd";
_man5 addHeadgear "H_Cap_tan_specops_US";
_man5 addGoggles "G_Lowprofile";


// Soldier6
_man6 = _group createUnit ["C_man_polo_4_F", [_pos select 0, (_pos select 1) - 30, 0], [], 1, "Form"];
removeAllAssignedItems _man6;
_man6 addUniform "U_I_C_Soldier_Para_3_F";
_man6 addVest "V_PlateCarrierIA1_dgtl";
_man6 addMagazine "5.56mm x 39 30Rnd";
_man6 addWeapon "arifle_mas_ak_74m_sf";
_man6 addPrimaryWeaponItem "optic_MRCO";
_man6 addMagazine "5.56mm x 39 30Rnd";
_man6 addMagazine "5.56mm x 39 30Rnd";
_man6 addHeadgear "H_Booniehat_khk_hs";
_man6 addGoggles "G_Spectacles_Tinted";



_leader = leader _group;

{
	_x spawn refillPrimaryAmmo;
//	_x spawn addMilCap;
	_x call setMissionSkill;
	_x addRating 9999999;
	_x addEventHandler ["Killed", server_playerDied];
} forEach units _group;

[_group, _pos, "LandVehicle"] call defendArea;