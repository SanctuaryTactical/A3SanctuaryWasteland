if (!isServer) exitWith {};

diag_log "1ST SERVER FUNCTIONS - Initializing Sanctuary Functions Compile";

//The Scotsman - Sanctuary functions
STPopCrateSmoke = ["1st", "STPopCrateSmoke.sqf"] call mf_compile;
STCreateConvenienceKit = ["1st", "STCreateConvenienceKit.sqf"] call mf_compile;
