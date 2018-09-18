// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 2.1
//	@file Name: mission_MoneyShipment.sqf
//	@file Author: JoSchaap / routes by Del1te - (original idea by Sanjo), AgentRev
//	@file Created: 31/08/2013 18:19

if (!isServer) exitwith {};
#include "moneyMissionDefines.sqf";

private ["_MoneyShipment", "_reward", "_convoys", "_vehChoices", "_moneyText", "_vehClasses", "_vehicles", "_veh2", "_leader", "_speedMode", "_waypoint", "_vehicleName", "_numWaypoints", "_cash"];

_setupVars = {

	_locationsArray = LandConvoyPaths;

	// Money Shipments settings
	// Difficulties : Min = 1, Max = infinite
	// Convoys per difficulty : Min = 1, Max = infinite
	// Vehicles per convoy : Min = 1, Max = infinite
	// Choices per vehicle : Min = 1, Max = infinite

	//Small - Three Vehicles, One chopper
	//Medium - Four Vehicles, Two choppers
	//Large - Five Vehicles, Three Choppers (Escort)
	//Heavy - Eight Vehicles, Three Choppers (attack)

//NATO, CSAT, AAF
	_MoneyShipment =
	[
		// Easy
		[
			"Small Money Shipment", // Marker text
			30000, // Money
			[
				[ // NATO convoy
					["B_MRAP_01_hmg_F", "B_MRAP_01_gmg_F"], // Veh 1
					["B_MRAP_01_hmg_F", ST_M113A1], // Veh 2
					["O_Heli_Light_02_F", "I_Heli_light_03_F"] // Veh 3
				],
				[ // CSAT convoy
					[ST_M113A1, "O_MRAP_02_gmg_F"], // Veh 1
					[ST_BRADLEY, "O_MRAP_02_gmg_F"], // Veh 2
					["O_Heli_Light_02_F", "I_Heli_light_03_F"] // Veh 3
				],
				[ // AAF convoy
					["I_MRAP_03_hmg_F", ST_M113A1], // Veh 1
					[ST_ABRAMS_MC, ST_BRADLEY], // Veh 2
					["O_Heli_Light_02_F", "I_Heli_light_03_F"] // Veh 3
				]
			]
		],
		// Medium
		[
			"Medium Money Shipment", // Marker text
			40000, // Money
			[
				[ // NATO convoy
					["B_MRAP_01_hmg_F", "B_MRAP_01_gmg_F"], // Veh 1
					["B_APC_Wheeled_01_cannon_F", ST_M113A1, "B_APC_Tracked_01_AA_F"], // Veh 2
					["B_MRAP_01_hmg_F", "B_MRAP_01_gmg_F"], // Veh 3
					["O_Heli_Light_02_F", "I_Heli_light_03_F"] // Veh 4
				],
				[ // CSAT convoy
					["O_MRAP_02_hmg_F", "O_MRAP_02_gmg_F"], // Veh 1
					["O_APC_Wheeled_02_rcws_F", "O_APC_Tracked_02_cannon_F", "O_APC_Tracked_02_AA_F"], // Veh 2
					[ST_ABRAMS_MC, "O_MRAP_02_gmg_F"], // Veh 3
					["O_Heli_Light_02_F", "I_Heli_light_03_F"] // Veh 4
				],
				[ // AAF convoy
					["I_MRAP_03_hmg_F", "I_MRAP_03_gmg_F"], // Veh 1
					["I_APC_Wheeled_03_cannon_F", "I_APC_tracked_03_cannon_F"], // Veh 2
					["I_MRAP_03_hmg_F", "I_MRAP_03_gmg_F"], // Veh 3
					[ST_LITTLE_BIRD, ST_LITTLE_BIRD] // Veh 4
				]
			]
		],
		// Hard
		[
			"Large Money Shipment", // Marker text
			50000, // Money
			[
				[ // NATO convoy
					["B_APC_Wheeled_01_cannon_F", "B_APC_Tracked_01_rcws_F", "B_APC_Tracked_01_AA_F"], // Veh 1
					["B_MBT_01_cannon_F", ST_ABRAMSM1], // Veh 2
					["B_APC_Wheeled_01_cannon_F", "B_APC_Tracked_01_rcws_F", "B_APC_Tracked_01_AA_F"], // Veh 3
					["O_Heli_Light_02_F", ST_LITTLE_BIRD], // Veh 4
					["B_Heli_Attack_01_F", ST_LITTLE_BIRD] //Veh 5
				],
				[ // CSAT convoy
					["O_APC_Wheeled_02_rcws_F", "O_APC_Tracked_02_cannon_F", "O_APC_Tracked_02_AA_F"], // Veh 1
					["O_MBT_02_cannon_F"], // Veh 2
					["O_APC_Wheeled_02_rcws_F", "O_APC_Tracked_02_cannon_F", "O_APC_Tracked_02_AA_F"], // Veh 3
					[ST_LITTLE_BIRD, ST_LITTLE_BIRD], // Veh 4
					["B_Heli_Attack_01_F", "O_Heli_Attack_02_F"] //Veh 5
				],
				[ // AAF convoy
					["I_APC_Wheeled_03_cannon_F", ST_ABRAMS_MC], // Veh 1
					["O_MBT_02_cannon_F"], // Veh 2
					["I_APC_Wheeled_03_cannon_F", ST_M113A2], // Veh 3
					["O_Heli_Light_02_F", "I_Heli_light_03_F"], // Veh 4
					[ST_LITTLE_BIRD, "O_Heli_Attack_02_F"] //Veh 5
				]
			]
		],

		// Extreme
		[
			"Heavy Money Shipment", // Marker text
			80000, // Money
			[
				[ // NATO convoy
					[ST_ABRAMS_MC, "B_APC_Tracked_01_rcws_F", "B_APC_Tracked_01_AA_F", ST_ABRAMSM2_TUSK, "B_MBT_01_TUSK_F"], // Veh 1
					["B_APC_Tracked_01_AA_F", "B_MBT_01_cannon_F", "B_MBT_01_TUSK_F"], // Veh 2
					["B_APC_Wheeled_01_cannon_F", "B_APC_Tracked_01_rcws_F", ST_BRADLEY, "B_MBT_01_cannon_F", ST_ABRAMSM1], // Veh 3
					["B_APC_Wheeled_01_cannon_F", "B_APC_Tracked_01_rcws_F", "B_APC_Tracked_01_AA_F", "B_MBT_01_cannon_F", "O_MBT_02_cannon_F"], // Veh 4
					["O_Heli_Light_02_F", "I_Heli_light_03_F"], // Veh 4
					[ST_LITTLE_BIRD, ST_LITTLE_BIRD], // Veh 5
					[ST_LITTLE_BIRD, "O_Heli_Attack_02_F"] //Veh 6
				],
				[ // CSAT convoy
					["O_APC_Wheeled_02_rcws_F", "O_APC_Tracked_02_cannon_F", "O_APC_Tracked_02_AA_F", ST_ABRAMSM1], // Veh 1
					["O_APC_Tracked_02_AA_F", "O_MBT_02_cannon_F"], // Veh 2
					["O_APC_Wheeled_02_rcws_F", "O_APC_Tracked_02_cannon_F", "O_APC_Tracked_02_AA_F", ST_ABRAMSM1], // Veh 3
					["O_APC_Wheeled_02_rcws_F", "O_APC_Tracked_02_cannon_F", "O_APC_Tracked_02_AA_F", ST_ABRAMS_MC], // Veh 4
					["O_Heli_Light_02_F", "I_Heli_light_03_F"], // Veh 4
					["O_Heli_Light_02_F", "I_Heli_light_03_F"], // Veh 5
					[ST_APACHE, "O_Heli_Attack_02_F"] //Veh 6
				],
				[ // AAF convoy
					["I_APC_Wheeled_03_cannon_F", "I_APC_tracked_03_cannon_F", "I_MBT_03_cannon_F"], // Veh 1
					["I_APC_tracked_03_cannon_F", "I_MBT_03_cannon_F"], // Veh 2
					["I_APC_Wheeled_03_cannon_F", ST_BRADLEY, "O_MBT_02_cannon_F"], // Veh 3
					[ST_ABRAMS_MC, "I_APC_tracked_03_cannon_F", ST_ABRAMSM2_TUSK], // Veh 4
					["O_Heli_Light_02_F", "I_Heli_light_03_F"], // Veh 4
					["O_Heli_Light_02_F", ST_LITTLE_BIRD], // Veh 5
					["B_Heli_Attack_01_F", ST_LITTLE_BIRD] //Veh 6
				]
			]
		]
	]
	call BIS_fnc_selectRandom;

	_missionType = _MoneyShipment select 0;
	_reward = _MoneyShipment select 1;
	_convoys = _MoneyShipment select 2;
	_vehChoices = _convoys call BIS_fnc_selectRandom;

	_moneyText = format ["$%1", [_reward] call fn_numbersText];

	_vehClasses = [];
	{ _vehClasses pushBack (_x call BIS_fnc_selectRandom) } forEach _vehChoices;
};

_setupObjects = {
	private ["_starts", "_startDirs", "_waypoints"];
	call compile preprocessFileLineNumbers format ["mapConfig\convoys\%1.sqf", _missionLocation];

	_aiGroup = createGroup CIVILIAN;

	_vehicles = [];
	{
		_vehicles pushBack ([_x, _starts select 0, _startdirs select 0, _aiGroup] call STCreateVehicle);
	} forEach _vehClasses;

	_veh2 = _vehClasses select (1 min (count _vehClasses - 1));

	_leader = effectiveCommander (_vehicles select 0);
	_aiGroup selectLeader _leader;

	_aiGroup setCombatMode "YELLOW"; // units will defend themselves
	_aiGroup setBehaviour "SAFE"; // units feel safe until they spot an enemy or get into contact
	_aiGroup setFormation "STAG COLUMN";

	_speedMode = if (missionDifficultyHard) then { "NORMAL" } else { "LIMITED" };

	_aiGroup setSpeedMode _speedMode;

	{
		_waypoint = _aiGroup addWaypoint [_x, 0];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointCompletionRadius 25;
		_waypoint setWaypointCombatMode "YELLOW";
		_waypoint setWaypointBehaviour "SAFE"; // safe is the best behaviour to make AI follow roads, as soon as they spot an enemy or go into combat they WILL leave the road for cover though!
		_waypoint setWaypointFormation "STAG COLUMN";
		_waypoint setWaypointSpeed _speedMode;
	} forEach _waypoints;

	_missionPos = getPosATL leader _aiGroup;

	_missionPicture = getText (configFile >> "CfgVehicles" >> _veh2 >> "picture");
	_vehicleName = getText (configFile >> "cfgVehicles" >> _veh2 >> "displayName");

	_missionHintText = format ["A convoy transporting <t color='%1'>%2</t> escorted by a <t color='%1'>%3</t> is en route to an unknown location.<br/>Stop them!", moneyMissionColor, _moneyText, _vehicleName];

	_numWaypoints = count waypoints _aiGroup;
};

_waitUntilMarkerPos = {getPosATL _leader};
_waitUntilExec = nil;
_waitUntilCondition = {currentWaypoint _aiGroup >= _numWaypoints};

_failedExec = nil;

// _vehicles are automatically deleted or unlocked in missionProcessor depending on the outcome

_successExec = {

	// Mission completed
	[_marker, _reward] call STFixedCashReward;

	_successHintMessage = "The convoy has been stopped, the money and vehicles are now yours to take.";
};

_this call moneyMissionProcessor;
