//Configuration for Airdrop Assistance
//Author: Apoc

APOC_AA_VehOptions =
[
// ["Menu Text",		ItemClassname,						 Price,	 "Drop Type"]
["Quadbike (Civilian)", "C_Quadbike_01_F", 					 1000, 	 "vehicle"],
["Offroad", 			"B_G_Offroad_01_F",					 3300,   "vehicle"],
["Strider",             "I_MRAP_03_F",                       12000,  "vehicle"],
["Strider HMG",         "I_MRAP_03_hmg_F",                   30000,  "vehicle"],
["Hummingbird", 		"B_Heli_Light_01_F", 				 15000,  "vehicle"],
["AH-9 Pawnee",         "B_Heli_Light_01_armed_F",           100000, "vehicle"],
["UH-80 Ghost Hawk",    "B_Heli_Transport_01_camo_F",        75000,  "vehicle"],
["Rescue Boat", 		"C_Boat_Civil_01_rescue_F", 		 2800, 	 "vehicle"]
];

APOC_AA_SupOptions =
[// ["stringItemName", 	"Crate Type for fn_refillBox 	,Price," drop type"]
["Launchers", 			"airdrop_launchers", 			12000, "supply"],
["Weapons", 			"airdrop_weapons", 				15000, "supply"],
["Ordinance", 			"airdrop_ordinance", 			10000, "supply"],
["Ammunition", 			"airdrop_ammo", 				10000, "supply"],
["Supplies", 			"airdrop_supplies", 			10000, "supply"],

//"Menu Text",			"Crate Type", 			"Cost", "drop type"
["Food",				"Land_Sacks_goods_F",	3000, 	"picnic"],
["Water",				"Land_BarrelWater_F",	3000, 	"picnic"],

//"Menu Text",             "Base carrier",                   Price,  "Drop type"]
["Base in a Box (Small)",  "Land_CargoBox_V1_F",             50000,  "base"],
["Base in a Box (Medium)", "Land_Cargo20_yellow_F",          75000, "base1"],
["Base in a Box (Large)",  "Land_Cargo40_white_F",           100000, "base2"]
];
