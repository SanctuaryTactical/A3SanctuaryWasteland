// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: territories.sqf
//	@file Author: AgentRev, Bewilderbeest

// Territory system definitions. See territory/README.md for more details.
//
// 1 - Territory marker name. Must begin with 'TERRITORY_'
// 2 - Descriptive name
// 3 - Monetary value
// 4 - Territory category, currently unused. See territory/README.md for details.

[

	["TERRITORY_SW_AIRFIELD", "AAC Airfield", 1000, "AIRFIELD", 250],
	["TERRITORY_MAIN_AIRBASE_SW", "Altis Airport (SW)", 1000, "AIRFIELD", 500],
	["TERRITORY_MAIN_AIRBASE_CENTER", "Altis Airport (Center)", 1000, "AIRFIELD", 500],
	["TERRITORY_MAIN_AIRBASE_NE", "Altis Airport (NE)", 1000, "AIRFIELD", 500],
	["TERRITORY_NE_AIRFIELD", "Molos Airfield", 500, "AIRFIELD", 250],
	["TERRITORY_SE_AIRFIELD", "Selakano Airfield", 500, "AIRFIELD", 250],
	["TERRITORY_NW_AIRFIELD", "Northwest Airfield", 1000, "AIRFIELD", 250],
	["TERRITORY_SALTFLATS_AIRFIELD", "Saltflats", 1000, "AIRFIELD", 500],
	["TERRITORY_CARRIER", "Aircraft Carrier", 3000, "AIRFIELD", 1000],

	["TERRITORY_WEST_POWER_PLANT", "West Power Plant", 500, "POWER", 300],
	["TERRITORY_CENTER_POWER_PLANT", "Center Power Plant", 500, "POWER", 300],
	["TERRITORY_SE_POWERPLANT", "Sofia Power Plant", 500, "POWER", 300],
	["TERRITORY_EDESSA_POWERPLANT", "Edessa Power Plant", 500, "POWER", 300],

	["TERRITORY_THRONOS_CASTLE", "Thronos Castle", 500, "OTHER", 150],
	["TERRITORY_IRAKLIA_RUINS", "Iraklia Ruins", 500, "OTHER", 150],
	["TERRITORY_ARTINARKI_RUINS", "Artinarki Ruins", 500, "OTHER", 150],
	["TERRITORY_STADIUM", "Stadium", 750, "OTHER", 250],
	["TERRITORY_XIROLIMNI_DAM", "Xirolimini Dam", 500, "OTHER", 150],
	["TERRITORY_CAMP_NOWHERE", "Camp Nowhere", 500, "OTHER", 1500],

	["TERRITORY_MAGOS_TRANSMITTER", "Magos Transmitter", 500, "TRANSMITTER", 500],
	["TERRITORY_PYRSOS_TRANSMITTER", "Pyrsos Transmitter", 500, "TRANSMITTER", 300],
	["TERRITORY_TRANSMITTER", "Remote Transmitter", 1500, "TRANSMITTER", 300],
	["TERRITORY_SOUTH_TRANSMITTER", "South Transmitter", 500, "TRANSMITTER", 200],
	["TERRITORY_PEFKAS_TRANSMITTER", "Pefkas Transmitter", 500, "TRANSMITTER", 250],
	["TERRITORY_ZAROS_TRANSMITTER", "Zaros Transmitter", 500, "TRANSMITTER", 250],

	["TERRITORY_MILITARY_HILL", "Military Hill", 1000, "MILITARY", 500],
	["TERRITORY_TELOS_MILITARYBASE", "Telos Military Base", 1000, "MILITARY", 750],
	["TERRITORY_NIDASOS_MILITARYBASE", "Nidasos Military Base", 500 , "MILITARY", 250],
	["TERRITORY_FRINI_MILITARY_COMPOUND", "Frini Military Compound", 500, "MILITARY", 150],
	["TERRITORY_MILITARY_RESEARCH", "Military Research Compound", 500, "MILITARY", 500],
	["TERRITORY_PYRGOS_MILITARYBASE", "Pyrgos Military Base", 500, "MILITARY", 150],

	["TERRITORY_OILRIG", "Oil Rig", 2500, "STRATEGIC", 1000],
	["TERRITORY_CHARKIA_CONTAINER_YARD", "Charkia Container Station", 1500, "STRATEGIC", 750],
	["TERRITORY_ATHIRA_FACTORY", "Athira Factory", 1000, "STRATEGIC", 500],
	["TERRITORY_HOSPITAL", "Kavala Hospital", 500, "STRATEGIC", 250],
	["TERRITORY_AIRFIELD_DOCKS", "Airfield Docks", 500, "STRATEGIC", 250],
	["TERRITORY_CORE_FACTORY", "Core Production Plant", 1000, "STRATEGIC", 250],
	["TERRITORY_KAVALA_PORT", "Port of Kavala", 1000, "STRATEGIC", 250]

]
