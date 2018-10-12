if (!isServer) exitWith {};

diag_log "[1ST] Sanctuary Tactical - Initializing Server Functions";

//The Scotsman - Sanctuary functions
STPopCrateSmoke = ["1st", "STPopCrateSmoke.sqf"] call mf_compile;
STCreateConvenienceKit = ["1st", "STCreateConvenienceKit.sqf"] call mf_compile;
STTaskPatrol = ["1st", "STTaskPatrol.sqf"] call mf_compile;
STFixedCashReward = ["1st", "STFixedCashReward.sqf"] call mf_compile;
STRandomCashReward = ["1st", "STRandomCashReward.sqf"] call mf_compile;
STRandomCratesReward = ["1st", "STRandomCratesReward.sqf"] call mf_compile;
STFillCrate = ["1st", "STFillCrate.sqf"] call mf_compile;
STCreateVehicle = ["1st", "STCreateVehicle.sqf"] call mf_compile;
STCreateSpecialCrate = ["1st", "STCreateSpecialCrate.sqf"] call mf_compile;
STParaDropObject = ["1st", "STParaDropObject.sqf"] call mf_compile;
STNextPosition = ["1st", "STNextPosition.sqf"] call mf_compile;
