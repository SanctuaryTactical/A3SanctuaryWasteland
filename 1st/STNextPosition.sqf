/*******************************************************************************************
* This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com
********************************************************************************************
* @file Name: STNextPosition.sqf
* @author: The Scotsman
*
* Finds next position for a vehicle
* Arguments: [ _vehicles ]:
*
*/

if (!isServer) exitWith {};

params ["_vehicles", ["_distance", 60]];
private ["_position"];

_position = (getPos (_vehicles select ((count _vehicles) - 1))) vectorAdd ([[random _distance, 0, 0], random 360] call BIS_fnc_rotateVector2D);

_position
