// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
/*********************************************************#
# @@ScriptName: territoryActivityHandler.sqf
# @@Author: Nick 'Bewilderbeest' Ludlam <bewilder@recoil.org>
# @@Create Date: 2013-09-15 19:33:17
# @@Modify Date: 2013-09-15 20:15:37
# @@Function:
#*********************************************************/

// Called with [_message, _money(optional), _payday], "A3W_fnc_territoryActivityHandler", side, false] call A3W_fnc_MP;

diag_log format["A3W_fnc_territoryActivityHandler called with %1", _this];

if (typeName _this == "ARRAY" && {count _this >= 1}) then {

	_msg = _this select 0;
	_money = 0; if (count _this >= 2) then { _money = _this select 1; };
	_payday = _this select 2;

	if( isNil "_payday" ) then {

		titleText [_msg, "plain down", 0.5];

	} else {

		_picture = "client\icons\money.paa";
		_text = format[
			"<t shadow='2' size='1.75'>Payday</t><br/>" +
			"<t>--------------------------------</t><br/>" +
			"<img size='5' image='%1'/><br/>%2",
			_picture,
			_msg
		];

		hint parseText _text;

	};

	if (_money > 0) then {
		player setVariable ["cmoney", (player getVariable ["cmoney", 0]) + _money, true];
	};

	playSound 'FD_Finish_F'; // Nice sound effect to draw players attention to the notification
};
