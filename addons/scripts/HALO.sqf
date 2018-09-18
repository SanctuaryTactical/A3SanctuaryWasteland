#define PRICE 5000

_message = format ["Cost is $%1 to halo, confirm?", PRICE call fn_numbersText];

if !([_message, "Confirm", true, true] call BIS_fnc_guiMessage) exitWith {};

_showInsufficientFundsError =
{
	hint "Not enough money";
	playSound 'FD_Finish_F';
};

_money = player getVariable ["cmoney", 0];

// Ensure the player has enough money
if (PRICE > _money) exitWith
{
  call _showInsufficientFundsError;
};

//Deduct
player setVariable ["cmoney", _money - PRICE, true];

openMap true;

onMapSingleClick {
onMapSingleClick {};
player setpos _pos;
_height = 1000;
[player,_height] spawn BIS_fnc_halo;
hint '';
openMap false;
true
};
