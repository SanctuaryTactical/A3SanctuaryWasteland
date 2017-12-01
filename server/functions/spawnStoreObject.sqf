// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: spawnStoreObject.sqf
//	@file Author: AgentRev
//	@file Created: 11/10/2013 22:17
//	@file Args:

if (!isServer) exitWith {};

scopeName "spawnStoreObject";
private ["_isGenStore", "_isGunStore", "_isVehStore", "_timeoutKey", "_objectID", "_playerSide", "_objectsArray", "_results", "_itemEntry", "_itemPrice", "_safePos", "_object"];

params [["_player",objNull,[objNull]], ["_itemEntrySent",[],[[]]], ["_npcName","",[""]], ["_key","",[""]]];

_itemEntrySent params [["_class","",[""]]];

_isGenStore = ["GenStore", _npcName] call fn_startsWith;
_isGunStore = ["GunStore", _npcName] call fn_startsWith;
_isVehStore = ["VehStore", _npcName] call fn_startsWith;

private _storeNPC = missionNamespace getVariable [_npcName, objNull];
private _marker = _npcName;

if (_key != "" && isPlayer _player && {_isGenStore || _isGunStore || _isVehStore}) then
{
	_timeoutKey = _key + "_timeout";
	_objectID = "";
	private _seaSpawn = false;
	private _playerGroup = group _player;
	_playerSide = side _playerGroup;

	if (_isGenStore || _isGunStore) then
	{
		_npcName = _npcName + "_objSpawn";

		switch (true) do
		{
			case _isGenStore: { _objectsArray = genObjectsArray };
			case _isGunStore: { _objectsArray = staticGunsArray };

		};

		if (!isNil "_objectsArray") then
		{
			_results = (call _objectsArray) select {_x select [1,999] isEqualTo _itemEntrySent};

			if (count _results > 0) then
			{
				_itemEntry = _results select 0;
				_marker = _marker + "_objSpawn";
			};
		};
	};

	if (_isVehStore) then
	{
		// LAND VEHICLES
		{
			_results = (call _x) select {_x select [1,999] isEqualTo _itemEntrySent};

			if (count _results > 0) then
			{
				_itemEntry = _results select 0;
				_marker = _marker + "_landSpawn";
			};
		} forEach [landArray, armoredArray, tanksArray];

		// SEA VEHICLES
		if (isNil "_itemEntry") then
		{
			_results = (call boatsArray) select {_x select [1,999] isEqualTo _itemEntrySent};

			if (count _results > 0) then
			{
				_itemEntry = _results select 0;
				_marker = _marker + "_seaSpawn";
				_seaSpawn = true;
			};
		};

		// HELICOPTERS
		if (isNil "_itemEntry") then
		{
			_results = (call helicoptersArray) select {_x select [1,999] isEqualTo _itemEntrySent};

			if (count _results > 0) then
			{
				_itemEntry = _results select 0;
				_marker = _marker + "_heliSpawn";
			};
		};

		// AIRPLANES
		if (isNil "_itemEntry") then
		{
			_results = (call planesArray) select {_x select [1,999] isEqualTo _itemEntrySent};

			if (count _results > 0) then
			{
				_itemEntry = _results select 0;
				_marker = _marker + "_planeSpawn";
			};
		};
	};

	if (!isNil "_itemEntry" && markerShape _marker != "") then
	{
		_itemPrice = _itemEntry select 2;
		_skipSave = "SKIPSAVE" in (_itemEntry select [3,999]);

		/*if (_class isKindOf "Box_NATO_Ammo_F") then
		{
			switch (side _player) do
			{
				case OPFOR:       { _class = "Box_East_Ammo_F" };
				case INDEPENDENT: { _class = "Box_IND_Ammo_F" };
			};
		};*/

		if (_player getVariable ["cmoney", 0] >= _itemPrice) then
		{
			private _markerPos = markerPos _marker;
			private _npcPos = getPosASL _storeNPC;
			private _canFloat = (round getNumber (configFile >> "CfgVehicles" >> _class >> "canFloat") > 0);
			private _waterNonBoat = false;
			private "_spawnPosAGL";

			// non-boat spawn over water (e.g. aircraft carrier)
			if (!isNull _storeNPC && surfaceIsWater _npcPos && !_seaSpawn) then
			{
				_markerPos set [2, _npcPos select 2];
				_spawnPosAGL = ASLtoAGL _markerPos;
				_safePos = if (_canFloat) then { _spawnPosAGL } else { ASLtoATL _markerPos };
				_waterNonBoat = true;
			}
			else // normal spawn
			{
				_safePos = _markerPos findEmptyPosition [0, 50, _class];
				if (count _safePos == 0) then { _safePos = _markerPos };
				_spawnPosAGL = _safePos;
			};

			// delete wrecks near spawn
			{
				if (!alive _x) then
				{
					deleteVehicle _x;
				};
			} forEach nearestObjects [_spawnPosAGL, ["LandVehicle","Air","Ship"], 25 max sizeOf _class];

			if (_player getVariable [_timeoutKey, true]) then { breakOut "spawnStoreObject" }; // Timeout

			_object = createVehicle [_class, _safePos, [], 0, "NONE"];

			if (_waterNonBoat) then
			{
				private _posSurf = getPos _object;
				private _posASL = getPosASL _object;

				if (_posSurf select 2 < 0) then
				{
					_object setPosASL [_posSurf select 0, _posSurf select 1, (_posASL select 2) - (_posSurf select 2) + 0.05];
				};
			};

			if (_player getVariable [_timeoutKey, true]) then // Timeout
			{
				deleteVehicle _object;
				breakOut "spawnStoreObject";
			};

			_objectID = netId _object;
			_object setVariable ["A3W_purchasedStoreObject", true];
			_object setVariable ["ownerUID", getPlayerUID _player, true];
			_object setVariable ["ownerName", name _player, true];

			private _variant = (_itemEntry select {_x isEqualType "" && {_x select [0,8] == "variant_"}}) param [0,""];

			if (_variant != "") then
			{
				_object setVariable ["A3W_vehicleVariant", _variant select [8], true];
			};

			private _isUAV = (round getNumber (configFile >> "CfgVehicles" >> _class >> "isUav") > 0);

			if (_isUAV) then
			{
				createVehicleCrew _object;

				//assign AI to the vehicle so it can actually be used
				[_object, _playerSide, _playerGroup] spawn
				{
					params ["_uav", "_playerSide", "_playerGroup"];

					_grp = [_uav, _playerSide, true] call fn_createCrewUAV;

					if (isNull (_uav getVariable ["ownerGroupUAV", grpNull])) then
					{
						_uav setVariable ["ownerGroupUAV", _playerGroup, true]; // not currently used
					};
				};
			};

			if (isPlayer _player && !(_player getVariable [_timeoutKey, true])) then
			{
				_player setVariable [_key, _objectID, true];
			}
			else // Timeout
			{
				if (!isNil "_object") then { deleteVehicle _object };
				breakOut "spawnStoreObject";
			};

			if (_object isKindOf "AllVehicles" && !(_object isKindOf "StaticWeapon")) then
			{
				if (!surfaceIsWater _safePos) then
				{
					_object setPosATL [_safePos select 0, _safePos select 1, 0.05];
				};

				_object setVelocity [0,0,0.01];
				// _object spawn cleanVehicleWreck;
				_object setVariable ["A3W_purchasedVehicle", true, true];

				if (["A3W_vehicleLocking"] call isConfigOn && !_isUAV) then
				{
					[_object, 2] call A3W_fnc_setLockState; // Lock
				};
			};

			_object setDir (if (_object isKindOf "Plane") then { markerDir _marker } else { random 360 });

			//Prevent Object Dammage
			//_isDamageable = !(_object isKindOf "ReammoBox_F"); // ({_object isKindOf _x} count ["AllVehicles", "Lamps_base_F", "Cargo_Patrol_base_F", "Cargo_Tower_base_F"] > 0);
			_isDamageable = !({_object isKindOf _x} count ["ReammoBox_F", "Land_Noticeboard_F", "Land_ConcreteWall_01_l_4m_F", "Land_ConcreteWall_01_l_8m_F", "Land_ConcreteWall_01_l_gate_F", "Land_Sidewalk_01_8m_F","Land_Sidewalk_01_4m_F","Land_Sidewalk_01_narrow_4m_F","Land_Sidewalk_01_narrow_8m_F"] > 0);

			[_object] call vehicleSetup;
			_object allowDamage _isDamageable;
			_object setVariable ["allowDamage", _isDamageable, true];

			//Controls Object Default content/code
			switch(true) do
			{
				case ({_object isKindOf _x} count ["Land_Noticeboard_F", "Land_Device_assembled_F", "Box_NATO_AmmoVeh_F"] > 0):
				{
					_object setVariable ["password", "0000", true];
				};
				// Add food to bought food sacks.
				case ({_object isKindOf _x} count ["Land_Sacks_goods_F"] > 0):
				{
					_object setVariable ["food", 50, true];
				};
				// Add food to bought food sacks.
				case ({_object isKindOf _x} count ["Land_CratesWooden_F"] > 0):
				{
					_object setVariable ["food", 500, true];
				};
				// Add water to bought water barrels.
				case ({_object isKindOf _x} count ["Land_BarrelWater_F"] > 0):
				{
					_object setVariable ["water", 50, true];
				};
				// Add water to bought water tanks.
				case ({_object isKindOf _x} count ["Land_WaterTank_F"] > 0):
				{
					_object setVariable ["water", 500, true];
				};
				case ({_object isKindOf _x} count ["B_CargoNet_01_ammo_F"] > 0):
				{
					[_object] remoteExecCall ["A3W_fnc_setupResupplyTruck", 0, _object];
				};
				case ({_object isKindOf _x} count ["Land_MobileScafolding_01_F"] > 0):
				{
					_object enableSimulationGlobal false;
				};

				case ({_object isKindOf _x} count ["Land_CargoBox_V1_F"] > 0):
				{
					[_object, [["Land_Canal_Wall_Stairs_F", 2],["Land_BarGate_F", 2],["Land_Cargo_Patrol_V1_F", 2],["Land_HBarrier_3_F", 4],["Land_Canal_WallSmall_10m_F", 6],["Land_LampShabby_F", 10], ["Land_RampConcrete_F",1],["Land_Crash_barrier_F",4],["B_HMG_01_high_F",1]] ] execVM "addons\R3F_LOG\auto_load_in_vehicle.sqf";
				};
				case ({_object isKindOf _x} count ["Land_Cargo20_yellow_F"] > 0):
				{
					[_object, ["Land_Cargo_Tower_V1_F", ["Land_Canal_Wall_Stairs_F", 4],["Land_BarGate_F", 2],["Land_Cargo_Patrol_V1_F", 2],["Land_HBarrierWall6_F", 4],["Land_Canal_WallSmall_10m_F", 10],["Land_LampShabby_F", 10], ["Land_RampConcreteHigh_F",2], ["Land_RampConcrete_F", 2],["Land_Crash_barrier_F",6],["B_HMG_01_high_F",2]] ] execVM "addons\R3F_LOG\auto_load_in_vehicle.sqf";
				};

				case ({_object isKindOf _x} count ["Land_Cargo40_white_F"] > 0):
				{
					[_object, [["Land_Cargo_Tower_V1_F",2],["Land_GH_Platform_F",10],["Land_Canal_Wall_Stairs_F", 10],["Land_BarGate_F", 4],["Land_Cargo_Patrol_V1_F", 4],["Land_HBarrierWall6_F", 10],["Land_Canal_WallSmall_10m_F", 20],["Land_LampHalogen_F", 10], ["Land_RampConcreteHigh_F",4], ["Land_RampConcrete_F", 4],["Land_Crash_barrier_F",6],["B_GMG_01_F",2],["B_static_AA_F",2],["B_static_AT_F",2],["B_Quadbike_01_F",4],["C_Heli_light_01_digital_F",1]] ] execVM "addons\R3F_LOG\auto_load_in_vehicle.sqf";
				};

				case ({_object isKindOf _x} count ["Box_NATO_AmmoVeh_F", "Box_East_AmmoVeh_F", "Box_IND_AmmoVeh_F"] > 0):
				{
					_object setAmmoCargo 5;
				};
				case (_object isKindOf "O_Heli_Transport_04_ammo_F"):
				{
					_object setAmmoCargo 10;
				};

				case ({_object isKindOf _x} count ["B_Truck_01_ammo_F", "O_Truck_02_Ammo_F", "O_Truck_03_ammo_F", "I_Truck_02_ammo_F"] > 0):
				{
					_object setAmmoCargo 25;
				};

				case ({_object isKindOf _x} count ["C_Van_01_fuel_F", "I_G_Van_01_fuel_F", "O_Heli_Transport_04_fuel_F"] > 0):
				{
					_object setFuelCargo 10;
				};

				case ({_object isKindOf _x} count ["B_Truck_01_fuel_F", "O_Truck_02_fuel_F", "O_Truck_03_fuel_F", "I_Truck_02_fuel_F"] > 0):
				{
					_object setFuelCargo 25;
				};

				case (_object isKindOf "Offroad_01_repair_base_F"):
				{
					_object setRepairCargo 5;
				};

				case (_object isKindOf "O_Heli_Transport_04_repair_F"):
				{
					_object setRepairCargo 10;
				};

				case ({_object isKindOf _x} count ["B_Truck_01_Repair_F", "O_Truck_02_box_F", "O_Truck_03_repair_F", "I_Truck_02_box_F"] > 0):
				{
					_object setRepairCargo 25;
				};
				case ({_object isKindOf _x} count ["Land_MetalBarrel_F"] > 0):
				{
					_object setFuelCargo 25;
				};
				case ({_object isKindOf _x} count ["I_CargoNet_01_ammo_F"] > 0):
				{
					_object setAmmoCargo 10;
					_object allowDamage false; // No more fucking busted crates
					_object setVariable ["allowDamage", false, true];
					_object setVariable ["A3W_inventoryLockR3F", true, true];

					clearMagazineCargoGlobal _object;
					clearWeaponCargoGlobal _object;
					clearItemCargoGlobal _object;

					_object addMagazineCargoGlobal ["Titan_AA", 30];
					_object addWeaponCargoGlobal ["launch_B_Titan_F", 1];

				};
				case ({_object isKindOf _x} count ["O_CargoNet_01_ammo_F"] > 0):
				{
					_object setAmmoCargo 10;
					_object allowDamage false; // No more fucking busted crates
					_object setVariable ["allowDamage", false, true];
					_object setVariable ["A3W_inventoryLockR3F", true, true];

					clearMagazineCargoGlobal _object;
					clearWeaponCargoGlobal _object;
					clearItemCargoGlobal _object;

					_object addMagazineCargoGlobal ["Titan_AT", 28];
					_object addMagazineCargoGlobal ["Titan_AP", 5];
					_object addWeaponCargoGlobal ["launch_I_Titan_short_F", 1];

				};

			};

			clearBackpackCargoGlobal _object;

			if (_skipSave) then
			{
				_object setVariable ["A3W_skipAutoSave", true, true];
			}
			else
			{
				if (_object getVariable ["A3W_purchasedVehicle", false] && !isNil "fn_manualVehicleSave") then
				{
					_object call fn_manualVehicleSave;
				};
			};

			if (_object isKindOf "AllVehicles") then
			{
				if (isNull group _object) then
				{
					_object setOwner owner _player; // tentative workaround for exploding vehicles
				}
				else
				{
					(group _object) setGroupOwner owner _player;
				};
			};
		};
	};
};
