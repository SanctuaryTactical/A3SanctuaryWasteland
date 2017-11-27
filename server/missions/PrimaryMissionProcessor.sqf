// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: PrimaryMissionProcessor.sqf
//	@file Author: AgentRev

#define MISSION_PROC_TYPE_NAME "Primary"
#define MISSION_PROC_TIMEOUT (["A3W_PrimaryMissionTimeout", 60*60] call getPublicVar)
#define MISSION_PROC_COLOR_DEFINE PrimaryMissionColor

#include "PrimaryMissions\PrimaryMissionDefines.sqf"
#include "missionProcessor.sqf";
