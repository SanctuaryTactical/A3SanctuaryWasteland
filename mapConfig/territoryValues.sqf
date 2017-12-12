// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: territoryValues.sqf
//	@file Author: The Scotsman

// Controls the periodic reward values for each territory
//
// 1 - Territory marker name. Must begin with 'TERRITORY_'
// 2 - Repeating monitary value

//A multiplier will be used if a faction controls all of a given category
//FUTURE: Tie resource availability into occupied territories

strategicMultiplier = 2;

strategicResources = compileFinal str
[
  ["TERRITORY_CHARKIA_CONTAINER_YARD", 300],
  ["TERRITORY_HOSPITAL", 250],
  ["TERRITORY_CARRIER", 500],
  ["TERRITORY_AIRFIELD_DOCKS", 100],
  ["TERRITORY_CORE_FACTORY", 500],
  ["TERRITORY_KAVALA_PORT", 250],
  ["TERRITORY_ATHIRA_FACTORY", 750],
  ["TERRITORY_OILRIG", 1000]
];

militaryResources = compileFinal str
[
  ["TERRITORY_MILITARY_RESEARCH", 150],
	["TERRITORY_MILITARY_HILL", 150],
  ["TERRITORY_NIDASOS_MILITARYBASE", 150],
	["TERRITORY_FRINI_MILITARY_COMPOUND", 150],
	["TERRITORY_PYRGOS_MILITARYBASE", 150],
  ["TERRITORY_MILITARY_RESEARCH", 150]
];

airfieldResources = compileFinal str
[
  ["TERRITORY_SW_AIRFIELD", 200],
  ["TERRITORY_MAIN_AIRBASE_SW", 200],
  ["TERRITORY_MAIN_AIRBASE_CENTER", 200],
  ["TERRITORY_MAIN_AIRBASE_NE", 200],
  ["TERRITORY_NE_AIRFIELD", 200],
  ["TERRITORY_SE_AIRFIELD", 200],
  ["TERRITORY_NW_AIRFIELD", 200],
  ["TERRITORY_SALTFLATS_AIRFIELD", 200]
];

powerResource = compileFinal str
[
  ["TERRITORY_WEST_POWER_PLANT", 100],
  ["TERRITORY_CENTER_POWER_PLANT", 100],
  ["TERRITORY_SE_POWERPLANT", 100],
  ["TERRITORY_EDESSA_POWERPLANT", 100]
];

otherResources = compileFinal str
[
  ["TERRITORY_IRAKLIA_RUINS", 50],
  ["TERRITORY_ARTINARKI_RUINS", 50],
	["TERRITORY_THRONOS_CASTLE", 50],
  ["TERRITORY_STADIUM", 75],
  ["TERRITORY_XIROLIMNI_DAM", 50],
  ["TERRITORY_CAMP_NOWHERE", 1500]
];

transmitterResources = compileFinal str [
  ["TERRITORY_MAGOS_TRANSMITTER", 250],
  ["TERRITORY_PYRSOS_TRANSMITTER", 250],
	["TERRITORY_TRANSMITTER", 250],
  ["TERRITORY_SOUTH_TRANSMITTER", 250],
  ["TERRITORY_PEFKAS_TRANSMITTER",250],
  ["TERRITORY_ZAROS_TRANSMITTER", 250]
];
