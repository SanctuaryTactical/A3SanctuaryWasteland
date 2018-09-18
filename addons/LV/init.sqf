if(isNil("LV_ACskills"))then{LV_ACskills = compile preprocessFile "addons\LV\LV_functions\LV_fnc_ACskills.sqf";};
if(isNil("LV_vehicleInit"))then{LV_vehicleInit = compile preprocessFile "addons\LV\LV_functions\LV_fnc_vehicleInit.sqf";};
if(isNil("LV_fullLandVehicle"))then{LV_fullLandVehicle = compile preprocessFile "addons\LV\LV_functions\LV_fnc_fullLandVehicle.sqf";};
if(isNil("LV_fullAirVehicle"))then{LV_fullAirVehicle = compile preprocessFile "addons\LV\LV_functions\LV_fnc_fullAirVehicle.sqf";};
if(isNil("LV_fullWaterVehicle"))then{LV_fullWaterVehicle = compile preprocessFile "addons\LV\LV_functions\LV_fnc_fullWaterVehicle.sqf";};
if(isNil("LV_GetPlayers"))then{LV_GetPlayers = compile preprocessFile "addons\LV\LV_functions\LV_fnc_getPlayers.sqf";};

if(isNil("LV_militarize"))then{LV_militarize = compile preprocessFile "addons\LV\militarize.sqf";};
if(isNil("LV_fnc_simpleCache"))then{LV_fnc_simpleCache = compile preprocessFile "addons\LV\LV_functions\LV_fnc_simpleCache.sqf";};
if(isNil("LV_ambientCombat"))then{LV_ambientCombat = compile preprocessFile "addons\LV\ambientCombat.sqf";};
if(isNil("LV_removeAC"))then{LV_removeAC = compile preprocessFile "addons\LV\LV_functions\LV_fnc_removeAC.sqf";};
if(isNil("LV_heliParadrop"))then{LV_heliParadrop = compile preprocessFile "addons\LV\heliParadrop.sqf";};


diag_log "[1ST] Completed LV Initialization...";
