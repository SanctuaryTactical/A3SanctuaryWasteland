//Configuration for Airdrop Assistance
//Author: Apoc
#include "..\..\STConstants.h"

APOC_AA_VehOptions =
[
  // ["Menu Text", ItemClassname,	Price,"Drop Type"]
  ["Quadbike (Civilian)", "C_Quadbike_01_F", 2000, "vehicle"],
  ["Strider",  "I_MRAP_03_F", 16000, "vehicle"],
  ["Humvee Unarmed", ST_HUMVEE_UNARMED, 20000, "vehicle"],
  ["Humvee MG", ST_HUMVEE_ARMED1, 36000, "vehicle"],
  ["Hummingbird", "B_Heli_Light_01_F", 10000, "vehicle"],
  ["AH-9 Pawnee", "B_Heli_Light_01_armed_F", 70000, "vehicle"]
];

APOC_AA_SupOptions =
[
  // ["stringItemName",	"Crate Type for fn_refillBox, Price, "drop type"]
  ["Weapons", "airdrop_weapons", 15000, "supply"],
  ["Launchers", "airdrop_launchers", 12000, "supply"],
  ["Supplies", 	"airdrop_supplies", 10000, "supply"],
  ["Food", "Land_Sacks_goods_F",	3000, "picnic"],
  ["Water", "Land_WaterBottle_01_stack_F",	3000, "picnic"]
];
