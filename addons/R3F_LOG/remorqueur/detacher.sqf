/**
 * D�tacher un objet d'un v�hicule
 *
 * @param 0 l'objet � d�tacher
 *
 * Copyright (C) 2014 Team ~R3F~
 *
 * This program is free software under the terms of the GNU General Public License version 3.
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

if (R3F_LOG_mutex_local_verrou) then
{
	hintC STR_R3F_LOG_mutex_action_en_cours;
}
else
{
	R3F_LOG_mutex_local_verrou = true;

	private ["_remorqueur", "_objet"];

	_objet = _this select 0;
	_remorqueur = _objet getVariable "R3F_LOG_est_transporte_par";

	// Ne pas permettre de d�crocher un objet s'il est en fait h�liport�
	if (_remorqueur getVariable "R3F_LOG_fonctionnalites" select R3F_LOG_IDX_can_tow) then
	{
		[player, "AinvPknlMstpSlayWrflDnon_medic"] call switchMoveGlobal;

		_towerBB = _remorqueur call fn_boundingBoxReal;
		_towerMinBB = _towerBB select 0;
		_towerMaxBB = _towerBB select 1;

		if ((getPosASL player) select 2 > 0) then
		{
			player attachTo [_remorqueur,
			[
				(_towerMinBB select 0) - 0.25,
				(_towerMinBB select 1) - 0.25,
				_towerMinBB select 2
			]];

			player setDir 90;
			player setPos (getPos player);
			sleep 0.05;
			detach player;
		};

		sleep 2;

		// On m�morise sur le r�seau que le v�hicule remorque quelque chose
		_remorqueur setVariable ["R3F_LOG_remorque", objNull, true];
		// On m�morise aussi sur le r�seau que le objet est attach� en remorque
		_objet setVariable ["R3F_LOG_est_transporte_par", objNull, true];

		if (local _objet) then
		{
			[_objet] call detachTowedObject;
		}
		else
		{
			pvar_detachTowedObject = [netId _objet];
			publicVariable "pvar_detachTowedObject";
		};

		sleep 4;

		if (isNull objectParent player) then
		{
			[player, ""] call switchMoveGlobal;
		};

		if ({_objet isKindOf _x} count R3F_LOG_CFG_objets_deplacables > 0) then
		{
			if (_objet getVariable "R3F_LOG_fonctionnalites" select R3F_LOG_IDX_can_be_moved_by_player) then
			{
				// Si personne n'a touch� � l'objet pendant le sleep 7
				if (isNull (_remorqueur getVariable "R3F_LOG_remorque") &&
					(isNull (_objet getVariable "R3F_LOG_est_transporte_par")) &&
					(isNull (_objet getVariable "R3F_LOG_est_deplace_par"))
				) then
				{
					[_objet, player, 0, true] spawn R3F_LOG_FNCT_objet_deplacer;
				};
			}
			else
			{
				systemChat STR_R3F_LOG_action_detacher_fait;
			};
		};
	}
	else
	{
		hintC STR_R3F_LOG_action_detacher_impossible_pour_ce_vehicule;
	};

	R3F_LOG_mutex_local_verrou = false;
};
