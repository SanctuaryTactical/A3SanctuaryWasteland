// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//@file Version: 1.0
//@file Name: init.sqf
//@file Author: LouD (based on init.sqf by MercyfulFate)
//@file Description: Initialize Vehicle pinlock

#define build(file) format["%1\%2", _path, file] call mf_compile;

private ["_path","_applypin"];
_path = _this;

_applypin = [_path, "applypin.sqf"] call mf_compile;
_maxVehiclePins = ceil (["A3W_maxVehiclePins", 2] call getPublicVar);

MF_ITEMS_PINLOCK = "pinlock";
MF_ITEMS_PINLOCK_TYPE = "Land_SatellitePhone_F";
MF_ITEMS_PINLOCK_ICON = "client\icons\keypad.paa";

mf_pinlock_nearest_vehicle = {
	["LandVehicle", "Air", "Ship"] call mf_nearest_vehicle
} call mf_compile;

hint "Released Lock Down";

[MF_ITEMS_PINLOCK, "Vehicle Pinlock", _applypin, MF_ITEMS_PINLOCK_TYPE, MF_ITEMS_PINLOCK_ICON, _maxVehiclePins] call mf_inventory_create;

mf_can_applypin = [_path, "can_applypin.sqf"] call mf_compile;

private ["_label1", "_execute1", "_condition1", "_action1"];
_label1 = format["<img image='%1'/> Install Vehicle Pinlock", MF_ITEMS_PINLOCK_ICON];
_execute1 = {MF_ITEMS_PINLOCK call mf_inventory_use};
_condition1 = "[] call mf_can_applypin == ''";
_action1 = [_label1, _execute1, [], 1, false, false, "", _condition1];
["pinlock-use", _action1] call mf_player_actions_set;

// Code a pin lock
_label1 = "<img image='client\icons\keypad.paa'/> Code vehicle pin lock";
_condition1 = "{_x getVariable ['keypads', 0] >= 1} count nearestObjects [player, ['Land_DataTerminal_01_F'], 3] > 0 && !(MF_ITEMS_PINLOCK call mf_inventory_is_full)";
_action1 = {

	_objs = nearestObjects [player, ["Land_DataTerminal_01_F"], 5];

	if (count _objs > 0) then {

		//_generators = [player, "ERROR", "A generator is required within 50 metres to power this pin generator station."] call mf_pinCheckGenerator;

		//if( _generators > 0 ) {

			player playActionNow "PutDown";

			_obj = _objs select 0;

			[_obj,3] call BIS_fnc_dataTerminalAnimate;

			_obj setVariable ["keypads", (_obj getVariable ["keypads", 0]) - 1, true];
			[MF_ITEMS_PINLOCK, 1] call mf_inventory_add;

			sleep 10;

			[_obj,0] call BIS_fnc_dataTerminalAnimate;

			sleep 2;

			if (_obj getVariable "keypads" < 1) then {
				_obj spawn {
					_pos = getPosATL _this;
					_vecDir = vectorDir _this;
					_vecUp = vectorUp _this;
					deleteVehicle _this;

					_obj = createVehicle ["Land_DataTerminal_01_F", _pos, [], 0, "CAN_COLLIDE"];
					_obj setVectorDirAndUp [_vecDir, _vecUp];
					_obj setDamage 1;
					sleep 5;
					deleteVehicle _obj;
				};

				["You have generated a new vehicle pin lock.\nCoding station offline", 5] call mf_notify_client;
			} else {
				[format ["You have generateda new vehicle pin lock.\n(Pin locks left: %1)", _obj getVariable "keypads"], 5] call mf_notify_client;
			};

	//	};

	};
};

["pinlock-make", [_label1, _action1, [], 0, true, true, "", _condition1]] call mf_player_actions_set;
