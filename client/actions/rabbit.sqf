// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.1
//	@file Name: rabbit.sqf
//	@file Author: The Scotsman
//	@file Date modified: 11/09/2017
//	@file Args:

#define PICK_DISTANCE 5

// Check if mutex lock is active.
if (mutexScriptInProgress) exitWith
{
	player globalChat "You are already performing another action.";
};

if (vehicle player != player) exitWith
{
	titleText ["You can't pick up canned rabbit meat while in a vehicle", "PLAIN DOWN", 0.5];
};

mutexScriptInProgress = true;

private ["_objects", "_rabbit"];

_objects = nearestObjects [player, ["Rabbit_F"], PICK_DISTANCE];


if (count _objects > 0) then
{
	_rabbit = _objects select 0;
};

if (isNil "_rabbit" || {player distance _rabbit > PICK_DISTANCE}) exitWith
{
	titleText ["You are too far to pick the can up.", "PLAIN DOWN", 0.5];
	mutexScriptInProgress = false;
};

//player playMove ([player, "AmovMstpDnon_AinvMstpDnon", "putdown"] call getFullMove);
player playActionNow "PutDown";
sleep 0.25;

[MF_ITEMS_CANNED_FOOD, 1] call mf_inventory_add;

["Enjoy your can of rabbit meat", 5] call mf_notify_client;

deleteVehicle _rabbit;

sleep 0.75;
mutexScriptInProgress = false;





