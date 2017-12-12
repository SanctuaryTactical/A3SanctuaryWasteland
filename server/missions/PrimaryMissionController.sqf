// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: PrimaryMissionController.sqf
//	@file Author: AgentRev

#define MISSION_CTRL_PVAR_LIST PrimaryMissions
#define MISSION_CTRL_TYPE_NAME "Artillery"
#define MISSION_CTRL_FOLDER "PrimaryMissions"
#define MISSION_CTRL_DELAY (["A3W_PrimaryMissionDelay", 40*60] call getPublicVar)
#define MISSION_CTRL_COLOR_DEFINE PrimaryMissionColor

#include "PrimaryMissions\PrimaryMissionDefines.sqf"
#include "missionController.sqf";
