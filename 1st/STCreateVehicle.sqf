
/*******************************************************************************************
* This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com
********************************************************************************************
* @file Name: STCreateVehicle.sqf
* @author: The Scotsman
*
* Creates a mission vehicle
* Arguments: [ _type, _position, _direction ]:
*
*/
#include "..\STConstants.h"

params ["_type", "_position", "_direction", "_group"];
private ["_mode", "_kind", "_vehicle", "_soldier", "_velocity"];

_mode = "NONE";
_kind = "Land";

//Fly?
if( _type isKindOf "Air" ) then { _mode = "FLY"; };

_vehicle = createVehicle [_type, _position, [], 0, _mode];

if( _vehicle isKindOf "Air" ) then {

  //Make it fly
  _kind = "Air";
  _velocity = [velocity _vehicle, -(_direction)] call BIS_fnc_rotateVector2D;
  _vehicle setDir _direction;
  _vehicle setVelocity _velocity;

};

diag_log format ["STCreateVehicle %1:%2 (%3)", _kind, _type, _mode];

_vehicle setVariable [call vChecksum, true, false];
_vehicle setVariable ["R3F_LOG_disabled", true, true];

_vehicle setVehicleReportRemoteTargets true;
_vehicle setVehicleReceiveRemoteTargets true;
_vehicle setVehicleRadar 1;
_vehicle confirmSensorTarget [west, true];
_vehicle confirmSensorTarget [east, true];
_vehicle confirmSensorTarget [resistance, true];

[_vehicle] call vehicleSetup;

_group addVehicle _vehicle;

//Commander positions
if( _vehicle isKindOf "LandVehicle" ) then {

  _soldier = [_group, _position] call createRandomSoldier;
  _soldier triggerDynamicSimulation true;
  _soldier moveInDriver _vehicle;

  if (_vehicle emptyPositions "gunner" > 0) then {

    _soldier = [_group, _position] call createRandomSoldier;
    _soldier triggerDynamicSimulation true;
    _soldier moveInGunner _vehicle;

  };

  if (_vehicle emptyPositions "commander" > 0) then {

    _soldier = [_group, _position] call createRandomSoldier;
    _soldier triggerDynamicSimulation true;
    _soldier moveInCommander _vehicle;

  };

} else {

  _soldier = [_group, _position] call createRandomPilot;
  _soldier triggerDynamicSimulation true;
  _soldier moveInDriver _vehicle;

  while { _vehicle emptyPositions "gunner" > 0 } do {

    _soldier = [_group, _position] call createRandomPilot;
    _soldier triggerDynamicSimulation true;
    _soldier moveInGunner _vehicle;

  };

};

[_vehicle, _group] spawn checkMissionVehicleLock;

_vehicle
