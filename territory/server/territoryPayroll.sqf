// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: territoryPayroll.sqf
//	@file Author: AgentRev

#define TERRITORY_MULTIPLIER (["ST_TERRITORY_MULTIPLIER", .05] call getPublicVar)

#define STRATEGIC_COUNT 7
#define MILITARY_COUNT 6
#define AIRFIELD_COUNT 9
#define POWER_COUNT 4
#define OTHER_COUNT 6
#define TRANSMITTER_COUNT 6

#define STRATEGIC_INDEX 2
#define MILITARY_INDEX 3
#define AIRFIELD_INDEX 4
#define POWER_INDEX 5
#define OTHER_INDEX 6
#define TRANSMITTER_INDEX 7
#define PAYROLL_INDEX 8

#define BLUEFOR_COLOR "#52bf90"
#define OPFOR_COLOR "#52bf90"
#define INDEPENDENT_COLOR "#52bf90"

if (!isServer) exitWith {};

_timeInterval = ["A3W_payrollInterval", 30*60] call getPublicVar;
_moneyAmount = ["A3W_payrollAmount", 100] call getPublicVar;

_territoryCapped = false;

while {true} do
{
	if (_territoryCapped) then {
		sleep _timeInterval;
	} else {
		sleep 60;
	};

	//[team, territory_count, strategic_count, military_count, airfield_count, power_count, other_count, transmitter_count, _payroll]
	_payouts = [];

	{

		_markerName = _x select 0;
		_territoryOwner = _x select 2;
		_territoryChrono = _x select 3;

		_return = ["get", _markerName] call territoryCategories;

		_category = _return select 0;
		_payrollvalue = _return select 1;

		if (_territoryChrono > 0) then {

			_territoryCapped = true;

			if (_territoryChrono >= _timeInterval) then {

				_added = false;

				{

					//Owned?
					if ((_x select 0) isEqualTo _territoryOwner) exitWith {

						_index = switch (_category) do {
						    case "POWER": { POWER_INDEX };
						    case "OTHER": { OTHER_INDEX };
								case "AIRFIELD": { AIRFIELD_INDEX };
								case "MILITARY": { MILITARY_INDEX };
								case "TRANSMITTER": { TRANSMITTER_INDEX };
								case "STRATEGIC": { STRATEGIC_INDEX };
						};

						_x set [1, (_x select 1) + 1];
						_x set [_index, (_x select _index) + 1];
						_x set [PAYROLL_INDEX, (_x select PAYROLL_INDEX) + _payrollvalue];

						_added = true;

					};
				} forEach _payouts;

				if (!_added) then {
					_payouts pushBack [_territoryOwner, 1, 0, 0, 0, 0, 0, 0, _payrollvalue];
				};

			};
		};
	} forEach currentTerritoryDetails;

	{
		//[team, territory_count, strategic_count, military_count, airfield_count, power_count, other_count, transmitter_count]

		_team = _x select 0;
		_count = _x select 1;
		_money = _x select PAYROLL_INDEX;

		//_money = _count * _moneyAmount;
		//_message =  format ["Your team received a $%1 bonus for holding %2 territor%3 during the past %4 minutes", [_money] call fn_numbersText, _count, if (_count == 1) then { "y" } else { "ies" }, ceil (_timeInterval / 60)];

		_bonus = "";
		_owned = "";
		_multiplier = 0;

		if( (_x select MILITARY_INDEX) >= MILITARY_COUNT ) then {
			_multiplier = _multiplier + TERRITORY_MULTIPLIER;
			_owned = "Military";
		};

		if( (_x select AIRFIELD_INDEX) >= AIRFIELD_COUNT ) then {
			_multiplier = _multiplier + TERRITORY_MULTIPLIER;
			if( count _owned > 0 ) then { _owned = _owned + ", Airfield"; } else { _owned = "Airfield"; };
		};

		if( (_x select POWER_INDEX) >= POWER_COUNT ) then {
			_multiplier = _multiplier + TERRITORY_MULTIPLIER;
			if( count _owned > 0 ) then { _owned = _owned + ", Power"; } else { _owned = "Power"; };
		};

		if( (_x select TRANSMITTER_INDEX) >= TRANSMITTER_COUNT ) then {
			_multiplier = _multiplier + TERRITORY_MULTIPLIER;
			if( count _owned > 0 ) then { _owned = _owned + ", Transmitter"; } else { _owned = "Transmitter"; };
		};

		if( (_x select STRATEGIC_INDEX) >= STRATEGIC_COUNT ) then {
			_multiplier = _multiplier + TERRITORY_MULTIPLIER;
			if( count _owned > 0 ) then { _owned = _owned + ", Strategic"; } else { _owned = "Strategic"; };
		};

		if( (_x select OTHER_INDEX) >= OTHER_COUNT ) then {
			_multiplier = _multiplier + TERRITORY_MULTIPLIER;
			if( count _owned > 0 ) then { _owned = _owned + ", Other"; } else { _owned = "Other"; };
		};

		if( _multiplier > 0 ) then {

			_money = _money + (_money * _multiplier);
			_bonus = format["<br/>Another %1%3 bonus was applied for holding all of the territories in (%2)", [(_multiplier * 100)] call fn_numbersText, _owned, "%"];

		};

		_message =  format ["Your team received a $%1 bonus for holding %2 territor%3 during the past %4 minutes.%5", [_money] call fn_numbersText, _count, if (_count == 1) then { "y" } else { "ies" }, ceil (_timeInterval / 60), _bonus];

		[[_message, _money, true], "A3W_fnc_territoryActivityHandler", _team, false] call A3W_fnc_MP;

	} forEach _payouts;
};
