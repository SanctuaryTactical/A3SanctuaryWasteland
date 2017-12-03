/**
 * MAIN CONFIGURATION FILE
 *
 * English and French comments
 * Commentaires anglais et fran袩s
 *
 * (EN)
 * This file contains the configuration variables of the logistics system.
 * For the configuration of the creation factory, see the file "config_creation_factory.sqf".
 * IMPORTANT NOTE : when a logistics feature is given to an object/vehicle class name, all the classes which inherit
 *                  of the parent/generic class (according to the CfgVehicles) will also have this feature.
 *                  CfgVehicles tree view example : http://madbull.arma.free.fr/A3_stable_1.20.124746_CfgVehicles_tree.html
 *
 * (FR)
 * Fichier contenant les variables de configuration du syst鮥 de logistique.
 * Pour la configuration de l'usine de crꢴion, voir le fichier "config_creation_factory.sqf".
 * NOTE IMPORTANTE : lorsqu'une fonctionnalit顬ogistique est accordꥠࡵn nom de classe d'objet/vꩩcule, les classes
 *                   h곩tant de cette classe m鳥/gꯩrique (selon le CfgVehicles) se verront ꨡlement dot꦳ de cette fonctionnalit鮊 *                   Exemple d'arborescence du CfgVehicles : http://madbull.arma.free.fr/A3_stable_1.20.124746_CfgVehicles_tree.html
 */

/**
 * DISABLE LOGISTICS ON OBJECTS BY DEFAULT
 *
 * (EN)
 * Define if objects and vehicles have logistics features by default,
 * or if it must be allowed explicitely on specific objects/vehicles.
 *
 * If false : all objects are enabled according to the class names listed in this configuration file
 *            You can disable some objects with : object setVariable ["R3F_LOG_disabled", true];
 * If true :  all objects are disabled by default
 *            You can enable some objects with : object setVariable ["R3F_LOG_disabled", false];
 *
 *
 * (FR)
 * Dꧩni si les objets et vꩩcules disposent des fonctionnalit고logistiques par dꧡut,
 * ou si elles doivent 뵲e autoris고explicitement sur des objets/vꩩcules spꤩfiques.
 *
 * Si false : tous les objets sont actifs en accord avec les noms de classes list고dans ce fichier
 *            Vous pouvez d괡ctiver certains objets avec : objet setVariable ["R3F_LOG_disabled", true];
 * Si true :  tous les objets sont inactifs par dꧡut
 *            Vous pouvez activer quelques objets avec : objet setVariable ["R3F_LOG_disabled", false];
 */
R3F_LOG_CFG_disabled_by_default = false;

/**
 * LOCK THE LOGISTICS FEATURES TO SIDE, FACTION OR PLAYER
 *
 * (EN)
 * Define the lock mode of the logistics features for an object.
 * An object can be locked to the a side, faction, a player (respawn) or a unit (life).
 * If the object is locked, the player can unlock it according to the
 * value of the config variable R3F_LOG_CFG_unlock_objects_timer.
 *
 * If "none" : no lock features, everyone can used the logistics features.
 * If "side" : the object is locked to the last side which interacts with it.
 * If "faction" : the object is locked to the last faction which interacts with it.
 * If "player" : the object is locked to the last player which interacts with it. The lock is transmitted after respawn.
 * If "unit" : the object is locked to the last player which interacts with it. The lock is lost when the unit dies.
 *
 * Note : for military objects (not civilian), the lock is initialized to the object's side.
 *
 * See also the config variable R3F_LOG_CFG_unlock_objects_timer.
 *
 * (FR)
 * Dꧩni le mode de verrouillage des fonctionnalit고logistics pour un objet donn鮊 * Un objet peut 뵲e verrouill顰our une side, une faction, un joueur (respawn) ou une unit頨vie).
 * Si l'objet est verrouill鬠le joueur peut le d귥rrouiller en fonction de la
 * valeur de la variable de configiration R3F_LOG_CFG_unlock_objects_timer.
 *
 * Si "none" : pas de verrouillage, tout le monde peut utiliser les fonctionnalit고logistiques.
 * Si "side" : l'objet est verrouill顰our la derni鳥 side ayant interagit avec lui.
 * Si "faction" : l'objet est verrouill顰our la derni鳥 faction ayant interagit avec lui.
 * Si "player" : l'objet est verrouill顰our le dernier joueur ayant interagit avec lui. Le verrou est transmis apr鳠respawn.
 * Si "unit" : l'objet est verrouill顰our le dernier joueur ayant interagit avec lui. Le verrou est perdu quand l'unit顭eurt.
 *
 * Note : pour les objets militaires (non civils), le verrou est initialis顠 la side de l'objet.
 *
 * Voir aussi la variable de configiration R3F_LOG_CFG_unlock_objects_timer.
 */
R3F_LOG_CFG_lock_objects_mode = "none";

/**
 * COUNTDOWN TO UNLOCK AN OBJECT
 *
 * Define the countdown duration (in seconds) to unlock a locked object.
 * Set to -1 to deny the unlock of objects.
 * See also the config variable R3F_LOG_CFG_lock_objects_mode.
 *
 * Dꧩni la durꥠ(en secondes) du compte-லebours pour d귥rrouiller un objet.
 * Mettre ࠭1 pour qu'on ne puisse pas d귥rrouiller les objets.
 * Voir aussi la variable de configiration R3F_LOG_CFG_lock_objects_mode.
 */
R3F_LOG_CFG_unlock_objects_timer = 1;

/**
 * ALLOW NO GRAVITY OVER GROUND
 *
 * Define if movable objects with no gravity simulation can be set in height over the ground (no ground contact).
 * The no gravity objects corresponds to most of decoration and constructions items.
 *
 * Dꧩni si les objets d걬a袢le sans simulation de gravit顰euvent 뵲e position en hauteur sans 뵲e contact avec le sol.
 * Les objets sans gravit顣orrespondent ࡬a plupart des objets de d꤯rs et de construction.
 */
R3F_LOG_CFG_no_gravity_objects_can_be_set_in_height_over_ground = true;

/**
 * LANGUAGE
 *
 * Automatic language selection according to the game language.
 * New languages can be easily added (read below).
 *
 * Sꭥction automatique de la langue en fonction de la langue du jeu.
 * De nouveaux langages peuvent facilement 뵲e ajout고(voir ci-dessous).
 */
R3F_LOG_CFG_language = switch (language) do
{
	case "English":{"en"};
	case "French":{"fr"};

	// Feel free to create you own language file named "XX_strings_lang.sqf", where "XX" is the language code.
	// Make a copy of an existing language file (e.g. en_strings_lang.sqf) and translate it.
	// Then add a line with this syntax : case "YOUR_GAME_LANGUAGE":{"LANGUAGE_CODE"};
	// For example :

	//case "Czech":{"cz"}; // Not supported. Need your own "cz_strings_lang.sqf"
	//case "Polish":{"pl"}; // Not supported. Need your own "pl_strings_lang.sqf"
	//case "Portuguese":{"pt"}; // Not supported. Need your own "pt_strings_lang.sqf"
	//case "YOUR_GAME_LANGUAGE":{"LANGUAGE_CODE"};  // Need your own "LANGUAGE_CODE_strings_lang.sqf"

	default {"en"}; // If language is not supported, use English
};

/**
 * CONDITION TO ALLOW LOGISTICS
 *
 * (EN)
 * This variable allow to set a dynamic SQF condition to allow/deny all logistics features only on specific clients.
 * The variable must be a STRING delimited by quotes and containing a valid SQF condition to evaluate during the game.
 * For example you can allow logistics only on few clients having a known game ID by setting the variable to :
 * "getPlayerUID player in [""76xxxxxxxxxxxxxxx"", ""76yyyyyyyyyyyyyyy"", ""76zzzzzzzzzzzzzzz""]"
 * Or based on the profile name : "profileName in [""john"", ""jack"", ""james""]"
 * Or only for the server admin : "serverCommandAvailable "#kick"""
 * The condition is evaluted in real time, so it can use condition depending on the mission progress : "alive officer && taskState task1 == ""Succeeded"""
 * Or to deny logistics in a circular area defined by a marker : "player distance getMarkerPos ""markerName"" > getMarkerSize ""markerName"" select 0"
 * Note that quotes of the strings inside the string condition must be doubled.
 * Note : if the condition depends of the aimed objects/vehicle, you can use the command cursorTarget
 * To allow the logistics to everyone, just set the condition to "true".
 *
 * (FR)
 * Cette variable permet d'utiliser une condition SQF dynamique pour autoriser ou non les fonctions logistiques sur des clients spꤩfiques.
 * La variable doit 뵲e une CHAINE de caract鳥s dꭩmitꥠpar des guillemets et doit contenir une condition SQF valide qui sera 귡luꥠdurant la mission.
 * Par exemple pour autoriser la logistique sur seulement quelques joueurs ayant un ID de jeu connu, la variable peut 뵲e dꧩni comme suit :
 * "getPlayerUID player in [""76xxxxxxxxxxxxxxx"", ""76yyyyyyyyyyyyyyy"", ""76zzzzzzzzzzzzzzz""]"
 * Ou elle peut se baser sur le nom de profil : "profileName in [""maxime"", ""martin"", ""marc""]"
 * Ou pour n'autoriser que l'admin de serveur : "serverCommandAvailable "#kick"""
 * Les condition sont 귡lu꦳ en temps rꦬ, et peuvent donc d걥ndre du d곯ulement de la mission : "alive officier && taskState tache1 == ""Succeeded"""
 * Ou pour interdire la logistique dans la zone dꧩni par un marqueur circulaire : "player distance getMarkerPos ""markerName"" > getMarkerSize ""markerName"" select 0"
 * Notez que les guillemets des chaﯥs de caract鳥s dans la chaﯥ de condition doivent 뵲e doubl곮
 * Note : si la condition d걥nd de l'objet/vꩩcule point鬠vous pouvez utiliser la commande cursorTarget
 * Pour autoriser la logistique chez tout le monde, il suffit de dꧩnir la condition ࠢtrue".
 */
R3F_LOG_CFG_string_condition_allow_logistics_on_this_client = "true";

/**
 * CONDITION TO ALLOW CREATION FACTORY
 *
 * (EN)
 * This variable allow to set a dynamic SQF condition to allow/deny the access to the creation factory only on specific clients.
 * The variable must be a STRING delimited by quotes and containing a valid SQF condition to evaluate during the game.
 * For example you can allow the creation factory only on few clients having a known game ID by setting the variable to :
 * "getPlayerUID player in [""76xxxxxxxxxxxxxxx"", ""76yyyyyyyyyyyyyyy"", ""76zzzzzzzzzzzzzzz""]"
 * Or based on the profile name : "profileName in [""john"", ""jack"", ""james""]"
 * Or only for the server admin : "serverCommandAvailable "#kick"""
 * Note that quotes of the strings inside the string condition must be doubled.
 * Note : if the condition depends of the aimed objects/vꩩcule, you can use the command cursorTarget
 * Note also that the condition is evaluted in real time, so it can use condition depending on the mission progress :
 * "alive officer && taskState task1 == ""Succeeded"""
 * To allow the creation factory to everyone, just set the condition to "true".
 *
 * (FR)
 * Cette variable permet d'utiliser une condition SQF dynamique pour rendre accessible ou non l'usine de crꢴion sur des clients spꤩfiques.
 * La variable doit 뵲e une CHAINE de caract鳥s dꭩmitꥠpar des guillemets et doit contenir une condition SQF valide qui sera 귡luꥠdurant la mission.
 * Par exemple pour autoriser l'usine de crꢴion sur seulement quelques joueurs ayant un ID de jeu connu, la variable peut 뵲e dꧩni comme suit :
 * "getPlayerUID player in [""76xxxxxxxxxxxxxxx"", ""76yyyyyyyyyyyyyyy"", ""76zzzzzzzzzzzzzzz""]"
 * Ou elle peut se baser sur le nom de profil : "profileName in [""maxime"", ""martin"", ""marc""]"
 * Ou pour n'autoriser que l'admin de serveur : "serverCommandAvailable "#kick"""
 * Notez que les guillemets des chaﯥs de caract鳥s dans la chaﯥ de condition doivent 뵲e doubl곮
 * Note : si la condition d걥nd de l'objet/vꩩcule point鬠vous pouvez utiliser la commande cursorTarget
 * Notez aussi que les condition sont 귡lu꦳ en temps rꦬ, et peuvent donc d걥ndre du d곯ulement de la mission :
 * "alive officier && taskState tache1 == ""Succeeded"""
 * Pour autoriser l'usine de crꢴion chez tout le monde, il suffit de dꧩnir la condition ࠢtrue".
 */
R3F_LOG_CFG_string_condition_allow_creation_factory_on_this_client = "false";

/*
 ********************************************************************************************
 * BELOW IS THE CLASS NAMES CONFIGURATION / CI-DESSOUS LA CONFIGURATION DES NOMS DE CLASSES *
 ********************************************************************************************
 *
 * (EN)
 * There are two ways to manage new objects with the logistics system. The first one is to add these objects in the
 * following appropriate lists. The second one is to create a new external file in the /addons_config/ directory,
 * based on /addons_config/TEMPLATE.sqf, and to add a #include below to.
 * The first method is better to add/fix only some various class names.
 * The second method is better to take into account an additional addon.
 *
 * These variables are based on the inheritance principle according to the CfgVehicles tree.
 * It means that a features accorded to a class name, is also accorded to all child classes.
 * Inheritance tree view : http://madbull.arma.free.fr/A3_1.32_CfgVehicles_tree.html
 *
 * (FR)
 * Deux moyens existent pour g곥r de nouveaux objets avec le syst鮥 logistique. Le premier consiste ࡡjouter
 * ces objets dans les listes appropri꦳ ci-dessous. Le deuxi鮥 est de crꦲ un fichier externe dans le r걥rtoire
 * /addons_config/ bas顳ur /addons_config/TEMPLATE.sqf, et d'ajouter un #include ci-dessous.
 * La premi鳥 m굨ode est prꧩrable lorsqu'il s'agit d'ajouter ou corriger quelques classes diverses.
 * La deuxi鮥 m굨ode est prꧩrable s'il s'agit de prendre en compte le contenu d'un addon supplꮥntaire.
 *
 * Ces variables sont bas꦳ sur le principe d'h곩tage utilis고dans l'arborescence du CfgVehicles.
 * Cela signifie qu'une fonctionnalit顡ccordꥠࡵne classe, le sera aussi pour toutes ses classes filles.
 * Vue de l'arborescence d'h곩tage : http://madbull.arma.free.fr/A3_1.32_CfgVehicles_tree.html
 */

/****** LIST OF ADDONS CONFIG TO INCLUDE / LISTE DES CONFIG D'ADDONS A INCLURE ******/
//#include "addons_config\A3_vanilla.sqf"
//#include "addons_config\All_in_Arma.sqf"
//#include "addons_config\R3F_addons.sqf"
//#include "addons_config\YOUR_ADDITIONAL_ADDON.sqf"

/****** TOW WITH VEHICLE / REMORQUER AVEC VEHICULE ******/

/**
 * List of class names of ground vehicles which can tow objects.
 * Liste des noms de classes des vꩩcules terrestres pouvant remorquer des objets.
 */
R3F_LOG_CFG_can_tow = R3F_LOG_CFG_can_tow +
[
	// e.g. : "MyTowingVehicleClassName1", "MyTowingVehicleClassName2"
	"Quadbike_01_base_F",
	"SUV_01_base_F",
	"Offroad_01_base_F",
	"Van_01_base_F",
	"MRAP_01_base_F",
	"MRAP_02_base_F",
	"MRAP_03_base_F",
	"Truck_01_base_F",
	"Truck_02_base_F",
	"Truck_03_base_F",
	"Wheeled_APC_F",
	"APC_Tracked_01_base_F",
	"APC_Tracked_02_base_F",
	"APC_Tracked_03_base_F",
	"MBT_01_base_F",
	"MBT_02_base_F",
	"MBT_03_base_F",
	"B_CTRG_LSV_01_light_F",
	"B_T_LSV_01_unarmed_F",
	"B_T_LSV_01_armed_F",
	"O_T_LSV_02_unarmed_F",
	"O_T_LSV_02_armed_F",
	"C_Offroad_02_unarmed_F",
	"I_C_Offroad_02_unarmed_F",
	"Boat_Armed_01_base_F",
	"CUP_B_M1128_MGS_Desert",
	"CUP_B_M7Bradley_USA_D",
	"CUP_B_M1126_ICV_M2_Desert_Slat",
	"CUP_B_LAV25_desert_USMC",
	"CUP_B_M6LineBacker_USA_D",
	"CUP_B_FV510_GB_W",
	"CUP_B_M1A2_TUSK_MG_DES_US_Army",
	"CUP_B_Challenger2_Desert_BAF",
	"CUP_B_HMMWV_M2_USA",
	"CUP_B_HMMWV_SOV_M2_USA",
	"CUP_B_HMMWV_Unarmed_USA",
	"CUP_B_LR_Transport_GB_D",
	"CUP_B_BDRM2_CZ_Des",
	"CUP_B_T72_CZ"
];

/**
 * List of class names of objects which can be towed.
 * Liste des noms de classes des objets remorquables.
 */
R3F_LOG_CFG_can_be_towed = R3F_LOG_CFG_can_be_towed +
[
	// e.g. : "MyTowableObjectClassName1", "MyTowableObjectClassName2"
	"Hatchback_01_base_F",
	"SUV_01_base_F",
	"Offroad_01_base_F",
	"Van_01_base_F",
	"MRAP_01_base_F",
	"MRAP_02_base_F",
	"MRAP_03_base_F",
	"Truck_01_base_F",
	"Truck_02_base_F",
	"Truck_03_base_F",
	"APC_Tracked_01_base_F",
	"APC_Tracked_02_base_F",
	"APC_Tracked_03_base_F",
	"Wheeled_APC_F",
	"MBT_01_base_F",
	"MBT_02_base_F",
	"MBT_03_base_F",
	"UGV_01_base_F",
	"SDV_01_base_F",
	"Boat_Civil_01_base_F",
	"Boat_Armed_01_base_F",
	"Helicopter_Base_F",
	"Plane",
	"Ship_F",
	"B_CTRG_LSV_01_light_F",
	"B_T_LSV_01_unarmed_F",
	"B_T_LSV_01_armed_F",
	"O_T_LSV_02_unarmed_F",
	"O_T_LSV_02_armed_F",
	"C_Offroad_02_unarmed_F",
	"UAV_03_base_F",
 	"Heli_Light_01_base_F",
 	"Heli_Light_02_base_F",
 	"Heli_light_03_base_F",
 	"Heli_Attack_01_base_F",
    "B_Heli_Light_01_F",
	"I_C_Offroad_02_unarmed_F",
 	"Tank_F",
 	"Heli_Attack_02_base_F",
 	"Heli_Transport_01_base_F",
 	"Heli_Transport_02_base_F",
 	"Heli_Transport_03_base_F",
 	"Heli_Transport_04_base_F",
 	"VTOL_base_F",
 	"UAV_05_Base_F",
 	"Plane_Fighter_01_Base_F",
 	"Plane_Fighter_02_Base_F",
 	"Plane_CAS_01_base_F",
 	"Plane_CAS_02_base_F",
	"B_T_VTOL_01_armed_F",
	"CUP_B_M1128_MGS_Desert",
	"CUP_B_M7Bradley_USA_D",
	"CUP_B_M1126_ICV_M2_Desert_Slat",
	"CUP_B_LAV25_desert_USMC",
	"CUP_B_M6LineBacker_USA_D",
	"CUP_B_FV510_GB_W",
	"CUP_B_M1A2_TUSK_MG_DES_US_Army",
	"CUP_B_Challenger2_Desert_BAF",
	"CUP_B_AV8B_DYN_USMC",
	"I_Plane_Fighter_04_F",
	"O_Plane_Fighter_02_F",
	"CUP_B_HMMWV_M2_USA",
	"CUP_B_HMMWV_SOV_M2_USA",
	"CUP_B_HMMWV_Unarmed_USA",
	"CUP_B_LR_Transport_GB_D",
	"CUP_B_UH60S_USN",
	"CUP_B_CH53E_VIV_USMC",
	"CUP_B_C47_USA",
	"CUP_B_C130J_USMC",
	"CUP_B_L39_CZ",
	"CUP_B_F35B_BAF",
	"CUP_B_MH60L_DAP_4x_USN",
	"CUP_B_BDRM2_CZ_Des",
	"CUP_B_T72_CZ",
	"O_Plane_CAS_02_dynamicLoadout_F",
	"I_Plane_Fighter_03_dynamicLoadout_F"

];


/****** LIFT WITH VEHICLE / HELIPORTER AVEC VEHICULE ******/

/**
 * List of class names of helicopters which can lift objects.
 * Liste des noms de classes des hꭩcopt鳥s pouvant hꭩporter des objets.
 */
R3F_LOG_CFG_can_lift = R3F_LOG_CFG_can_lift +
[
	// e.g. : "MyLifterVehicleClassName1", "MyLifterVehicleClassName2"
	"B_Heli_Light_01_F",
	"Helicopter_Base_F",
	"B_Heli_Light_01_armed_F",
	"Heli_Light_02_base_F",
	"Heli_light_03_base_F",
	"Heli_Attack_01_base_F",
	"Heli_Attack_02_base_F",
	"Heli_Transport_01_base_F",
	"Heli_Transport_02_base_F",
	"Heli_Transport_03_base_F",
	"Heli_Transport_04_base_F",
	"O_T_VTOL_02_vehicle_F",
	"VTOL_base_F",
	"B_T_VTOL_01_armed_F",
	"CUP_B_AH64D_DL_USA",
	"CUP_B_UH1Y_Gunship_Dynamic_USMC",
	"CUP_B_AH1Z_Dynamic_USMC",
	"CUP_B_Mi35_Dynamic_CZ_Des",
	"CUP_B_UH60S_USN",
	"CUP_B_CH53E_VIV_USMC",
	"CUP_B_MH60L_DAP_4x_USN"
];

/**
 * List of class names of objects which can be lifted.
 * Liste des noms de classes des objets hꭩportables.
 */
R3F_LOG_CFG_can_be_lifted = R3F_LOG_CFG_can_be_lifted +
[
	// e.g. : "MyLiftableObjectClassName1", "MyLiftableObjectClassName2"
	"B_GEN_Offroad_01_gen_F",
	"C_Offroad_02_unarmed_F",
	"I_C_Offroad_02_unarmed_F",
	"I_C_Van_01_transport_F",
	"Hatchback_01_base_F",
	"SUV_01_base_F",
	"Offroad_01_base_F",
	"Van_01_base_F",
	"MRAP_01_base_F",
	"MRAP_02_base_F",
	"MRAP_03_base_F",
	"APC_Tracked_01_base_F",
	"APC_Tracked_02_base_F",
	"APC_Tracked_03_base_F",
	"Wheeled_APC_F",
	"Truck_01_base_F",
	"Truck_02_base_F",
	"Truck_03_base_F",
	"UGV_01_base_F",
	"SDV_01_base_F",
	"Boat_Civil_01_base_F",
	"Boat_Armed_01_base_F",
	"B_CTRG_LSV_01_light_F",
	"B_T_LSV_01_unarmed_F",
	"B_T_LSV_01_armed_F",
	"O_T_LSV_02_unarmed_F",
	"O_T_LSV_02_armed_F",
	"MBT_01_base_F",
	"MBT_02_base_F",
	"MBT_03_base_F",
	"I_C_Offroad_02_unarmed_F",
	"Land_Cargo20_military_green_F",
	"Land_Cargo20_grey_F",
	"Land_CargoBox_V1_F",
	"Land_Cargo20_yellow_F",
	"Land_Cargo40_white_F",
	"Land_Cargo40_military_green_F",
	"B_Heli_Light_01_F",
	"Helicopter_Base_F",
	"B_Heli_Light_01_armed_F",
	"Heli_Light_02_base_F",
	"Heli_light_03_base_F",
	"Heli_Attack_01_base_F",
	"Heli_Attack_02_base_F",
	"Heli_Transport_01_base_F",
	"Heli_Transport_02_base_F",
	"Heli_Transport_03_base_F",
	"Heli_Transport_04_base_F",
	"O_T_VTOL_02_vehicle_F",
	"VTOL_base_F",
	"I_CargoNet_01_ammo_F",
	"O_CargoNet_01_ammo_F",
  "B_CargoNet_01_ammo_F",
	"B_T_VTOL_01_armed_F",
	"CUP_B_M1128_MGS_Desert",
	"CUP_B_M7Bradley_USA_D",
	"CUP_B_M1126_ICV_M2_Desert_Slat",
	"CUP_B_LAV25_desert_USMC",
	"CUP_B_M6LineBacker_USA_D",
	"CUP_B_FV510_GB_W",
	"CUP_B_M1A2_TUSK_MG_DES_US_Army",
	"CUP_B_Challenger2_Desert_BAF",
	"CUP_B_AH64D_DL_USA",
	"CUP_B_UH1Y_Gunship_Dynamic_USMC",
	"CUP_B_AH1Z_Dynamic_USMC",
	"CUP_B_Mi35_Dynamic_CZ_Des",
	"CUP_B_HMMWV_M2_USA",
	"CUP_B_HMMWV_SOV_M2_USA",
	"CUP_B_HMMWV_Unarmed_USA",
	"CUP_B_LR_Transport_GB_D",
	"CUP_B_UH60S_USN",
	"CUP_B_CH53E_VIV_USMC",
	"CUP_B_C47_USA",
	"CUP_B_C130J_USMC",
	"CUP_B_L39_CZ",
	"CUP_B_F35B_BAF",
	"CUP_B_MH60L_DAP_4x_USN",
	"CUP_B_BDRM2_CZ_Des",
	"CUP_B_T72_CZ",
	"O_Plane_CAS_02_dynamicLoadout_F",
	"I_Plane_Fighter_03_dynamicLoadout_F"

];


/****** LOAD IN VEHICLE / CHARGER DANS LE VEHICULE ******/

/*
* (EN)
 * This section uses a numeric quantification of capacity and cost of the objets.
 * For example, in a vehicle has a capacity of 100, we will be able to load in 5 objects costing 20 capacity units.
 * The capacity doesn't represent a real volume or weight, but a choice made for gameplay.
 *
 * (FR)
 * Cette section utilise une quantification num곩que de la capacit顥t du co󴠤es objets.
 * Par exemple, dans un vꩩcule d'une capacit顤e 100, nous pouvons charger 5 objets co󴡮t 20 unit고de capacit鮊 * La capacit顮e repr괥nte ni un poids, ni un volume, mais un choix fait pour la jouabilit鮊 */

/**
 * List of class names of vehicles or cargo objects which can transport objects.
 * The second element of the nested arrays is the load capacity (in relation with the capacity cost of the objects).
 *
 * Liste des noms de classes des vꩩcules ou "objets contenant" pouvant transporter des objets.
 * Le deuxi鮥 ꭩment des sous-tableaux est la capacit顤e chargement (en relation avec le co󴠤e capacit顤es objets).
 */
R3F_LOG_CFG_can_transport_cargo = R3F_LOG_CFG_can_transport_cargo +
[
	// e.g. : ["MyTransporterClassName1", itsCapacity], ["MyTransporterClassName2", itsCapacity]
	["Quadbike_01_base_F", 5],
	["UGV_01_base_F", 10],
	["Hatchback_01_base_F", 10],
	["SUV_01_base_F", 20],
	["Offroad_01_base_F", 30],
	["Offroad_02_base_F", 20],
	["Van_01_base_F", 40],
	["LSV_01_base_F", 15],
	["LSV_02_base_F", 15],
	["MRAP_01_base_F", 20],
	["MRAP_02_base_F", 20],
	["MRAP_03_base_F", 20],
	["APC_Tracked_01_base_F", 25],
	["APC_Tracked_02_base_F", 25],
	["APC_Tracked_03_base_F", 25],
	["B_Truck_01_box_F", 150],
	["Truck_F", 75],
	["Wheeled_APC_F", 30],
	["Tank_F", 30],
	["Rubber_duck_base_F", 10],
	["Boat_Civil_01_base_F", 10],
	["Boat_Transport_02_base_F", 15],
	["Boat_Armed_01_base_F", 16],
	["Heli_Light_01_base_F", 16],
	["Heli_Light_02_base_F", 16],
	["Heli_light_03_base_F", 16],
	["Heli_Transport_01_base_F", 75],
	["Heli_Transport_02_base_F", 75],
	["Heli_Transport_03_base_F", 75],
	["Heli_Transport_04_base_F", 75],
	["Heli_Attack_01_base_F", 15],
	["Heli_Attack_02_base_F", 20],
	["Plane_Civil_01_base_F", 5],
	["VTOL_01_base_F", 50],
	["VTOL_02_base_F", 30],
	["Land_CargoBox_V1_F", 300],
	["Land_Cargo20_yellow_F", 800],
	["Land_Cargo40_white_F", 900],
	["Land_Cargo20_military_green_F", 800],
	["Land_Cargo20_grey_F", 800],
	["Land_Cargo40_military_green_F", 900],
	["CUP_B_M1128_MGS_Desert",30],
	["CUP_B_M7Bradley_USA_D",30],
	["CUP_B_M1126_ICV_M2_Desert_Slat",30],
	["CUP_B_LAV25_desert_USMC",30],
	["CUP_B_M6LineBacker_USA_D",30],
	["CUP_B_FV510_GB_W",30],
	["CUP_B_M1A2_TUSK_MG_DES_US_Army",30],
	["CUP_B_Challenger2_Desert_BAF",30],
	["CUP_B_AH64D_DL_USA",25],
	["CUP_B_UH1Y_Gunship_Dynamic_USMC",25],
	["CUP_B_AH1Z_Dynamic_USMC",25],
	["CUP_B_Mi35_Dynamic_CZ_Des",25],
	["CUP_B_HMMWV_M2_USA",30],
	["CUP_B_HMMWV_SOV_M2_USA",30],
	["CUP_B_HMMWV_Unarmed_USA",30],
	["CUP_B_LR_Transport_GB_D",30],
	["CUP_B_UH60S_USN",30],
	["CUP_B_MH60L_DAP_4x_USN", 30],
	["CUP_B_CH53E_VIV_USMC",30],
	["CUP_B_C47_USA", 50],
	["CUP_B_C130J_USMC", 150],
	["CUP_B_L39_CZ", 20],
	["CUP_B_F35B_BAF",20],
	["CUP_B_BDRM2_CZ_Des", 30],
	["CUP_B_T72_CZ",30]

];

/**
 * List of class names of objects which can be loaded in transport vehicle/cargo.
 * The second element of the nested arrays is the cost capacity (in relation with the capacity of the vehicles).
 *
 * Liste des noms de classes des objets transportables.
 * Le deuxi鮥 ꭩment des sous-tableaux est le co󴠤e capacit頨en relation avec la capacit顤es vꩩcules).
 */
R3F_LOG_CFG_can_be_transported_cargo = R3F_LOG_CFG_can_be_transported_cargo +
[
	// e.g. : ["MyTransportableObjectClassName1", itsCost], ["MyTransportableObjectClassName2", itsCost]

	["I_CargoNet_01_ammo_F", 10],
	["O_CargoNet_01_ammo_F", 10],
	["Static_Designator_01_base_F", 2],
 	["Static_Designator_02_base_F", 2],
	["StaticWeapon", 5],
 	["Box_NATO_AmmoVeh_F", 10],
 	["B_supplyCrate_F", 5],
 	["ReammoBox_F", 3],
 	["Kart_01_Base_F", 5],
 	["Quadbike_01_base_F", 6],
 	["Rubber_duck_base_F", 10],
 	["UAV_01_base_F", 2],
 	["Land_PierLadder_F", 3],
 	["Land_BagBunker_Large_F", 10],
 	["Land_BagBunker_Small_F", 5],
 	["Land_BagBunker_Tower_F", 7],
 	["Land_BagFence_Corner_F", 2],
 	["Land_BagFence_End_F", 2],
 	["Land_BagFence_Long_F", 3],
 	["Land_BagFence_Round_F", 2],
 	["Land_BagFence_Short_F", 2],
 	["Land_BarGate_F", 3],
 	["Land_Canal_WallSmall_10m_F", 4],
 	["Land_Canal_Wall_Stairs_F", 3],
 	["Land_CargoBox_V1_F", 10],
 	["Land_Cargo_Patrol_V1_F", 7],
 	["Land_Cargo_Tower_V1_F", 30],
 	["Land_CncBarrier_F", 4],
 	["Land_CncBarrierMedium_F", 4],
 	["Land_CncBarrierMedium4_F", 4],
 	["Land_CncShelter_F", 2],
 	["Land_CncWall1_F", 3],
 	["Land_CncWall4_F", 5],
 	["Land_Crash_barrier_F", 5],
 	["Land_HBarrierBig_F", 5],
	["Land_HBarrierTower_F", 8],
 	["Land_HBarrierWall4_F", 4],
 	["Land_HBarrierWall6_F", 6],
 	["Land_HBarrier_1_F", 3],
 	["Land_HBarrier_3_F", 4],
 	["Land_HBarrier_5_F", 5],
	["Land_LampHarbour_F", 2],
 	["Land_LampShabby_F", 2],
 	["Land_MetalBarrel_F", 2],
 	["Land_Mil_ConcreteWall_F", 5],
 	["Land_Mil_WallBig_4m_F", 5],
 	["Land_Obstacle_Ramp_F", 5],
 	["Land_Pipes_large_F", 5],
 	["Land_RampConcreteHigh_F", 6],
 	["Land_RampConcrete_F", 5],
 	["Land_Razorwire_F", 5],
 	["Land_Sacks_goods_F", 2],
 	["Land_Scaffolding_F", 5],
 	["Land_Shoot_House_Wall_F", 3],
 	["Land_Stone_8m_F", 5],
 	["Land_ToiletBox_F", 2],
 	["Land_BarrelWater_F", 2],
	["Land_PowerGenerator_F", 4],
	["Land_WheelieBin_01_F", 2],
	["Land_Walkover_01_F", 4],
	["Land_GH_Stairs_F", 4],
	["Land_FireEscape_01_short_F", 10],
	["Land_FireEscape_01_tall_F", 15],
	["StorageBladder_01_fuel_sand_F", 10],
	["Land_Wall_Tin_4", 2],
	["Land_CncBarrier_stripes_F", 2],
	["Land_MobileScafolding_01_F", 2],
	["Land_GarbageContainer_closed_F", 2],
	["Land_LampStreet_small_F", 2],
	["Land_PierLadder_F", 2],
	["Land_TouristShelter_01_F", 8],
	["Land_PillboxBunker_01_hex_F", 10],
	["Land_PillboxBunker_01_big_F", 10],
	["Land_PillboxBunker_01_rectangle_F", 10],
	["Land_PillboxWall_01_3m_F", 3],
	["Land_PillboxWall_01_6m_F", 6],
	["Land_ConcretePipe_F", 6],
	["Land_ConcreteWall_01_l_4m_F", 8],
	["Land_InfoStand_V2_F", 2],
	["Land_Device_assembled_F", 10],
	["Box_NATO_Ammo_F", 6],
	["Land_i_Shed_Ind_F", 50],
	["Land_Shed_Small_F", 50],
	["Land_Shed_Big_F", 75],
	["Land_SCF_01_shed_F", 75],
	["Land_Airport_01_controlTower_F", 50],
	["Land_AirstripPlatform_01_F", 75],
	["Land_Hangar_F", 75],
	["Land_Canal_Wall_10m_F", 15],
	["Land_Noticeboard_F", 10],
	["Land_WaterTank_F", 25],
	["Land_Cargo20_yellow_F", 50],
	["Land_Cargo40_white_F", 75],
	["Land_Cargo40_military_green_F", 75],
	["Land_ConcreteWall_01_l_pole_F", 5],
	["Land_ConcreteWall_01_l_gate_F", 10],
	["Land_ConcreteWall_01_l_8m_F", 5],
	["BlockConcrete_F", 10],
	["Land_Warehouse_01_ladder_F", 10],
	["Land_Warehouse_02_ladder_F", 10],
	["Land_Sidewalk_01_8m_F", 10],
	["Land_ConcreteWall_02_m_gate_F", 10],
	["Land_Shed_06_F", 10],
	["Land_Sidewalk_01_narrow_4m_F", 10],
	["Land_Sidewalk_01_narrow_8m_F", 10],
	["Land_Cargo20_military_green_F", 75],
	["Land_Cargo20_grey_F", 75],
	["Land_CratesWooden_F", 25],
	["Land_Sidewalk_01_4m_F", 5],
	["Land_GH_Platform_F", 6],
	["Land_PipeFence_02_s_4m_F", 4],
	["Land_PipeFence_02_s_8m_F", 8],
	["Land_Bunker_01_big_F", 75],
	["Land_Bunker_01_small_F", 50],
	["Land_Bunker_01_tall_F", 50],
	["Land_LampHalogen_F", 15],
	["Land_LampAirport_F", 20],
	["Land_ConcreteKerb_02_4m_F", 4],
	["Land_ConcreteKerb_02_8m_F", 8],
	["Land_ConcreteKerb_03_BY_short_F", 4],
	["Land_ConcreteKerb_03_BY_long_F", 8],
	["Land_ConcreteKerb_02_2m_F", 5],
	["Land_ConcreteWall_01_m_4m_F", 4],
	["Land_ConcreteWall_01_m_8m_F", 8],
	["Land_Bunker_01_blocks_3_F", 8],
	["Land_Bunker_01_blocks_1_F", 4]
];

/****** MOVABLE-BY-PLAYER OBJECTS / OBJETS DEPLACABLES PAR LE JOUEUR ******/

/**
 * List of class names of objects which can be carried and moved by a player.
 * Liste des noms de classes des objets qui peuvent 뵲e port고et d걬ac고par le joueur.
 */
R3F_LOG_CFG_can_be_moved_by_player = R3F_LOG_CFG_can_be_moved_by_player +
[
	// e.g. : "MyMovableObjectClassName1", "MyMovableObjectClassName2"

	"I_CargoNet_01_ammo_F",
	"O_CargoNet_01_ammo_F",
  "B_CargoNet_01_ammo_F",
 	"StaticWeapon",
 	"ReammoBox_F",
 	"Kart_01_Base_F",
 	"Quadbike_01_base_F",
	"Land_Mil_WallBig_4m_F",
 	"Rubber_duck_base_F",
 	"SDV_01_base_F",
 	"UAV_01_base_F",
 	"Land_PierLadder_F",
 	"Land_BagBunker_Large_F",
 	"Land_BagBunker_Small_F",
 	"Land_BagBunker_Tower_F",
 	"Land_BagFence_Corner_F",
 	"Land_BagFence_End_F",
 	"Land_BagFence_Long_F",
	"Land_BagFence_Round_F",
 	"Land_BagFence_Short_F",
 	"Land_BarGate_F",
 	"Land_Canal_WallSmall_10m_F",
 	"Land_Canal_Wall_Stairs_F",
 	"Land_CargoBox_V1_F",
 	"Land_Cargo_Patrol_V1_F",
 	"Land_Cargo_Tower_V1_F",
 	"Land_CncBarrier_F",
 	"Land_CncBarrierMedium_F",
 	"Land_CncBarrierMedium4_F",
 	"Land_CncShelter_F",
 	"Land_CncWall1_F",
 	"Land_CncWall4_F",
 	"Land_Crash_barrier_F",
 	"Land_HBarrierBig_F",
 	"Land_HBarrierTower_F",
 	"Land_HBarrierWall4_F",
 	"Land_HBarrierWall6_F",
 	"Land_HBarrier_1_F",
 	"Land_HBarrier_3_F",
 	"Land_HBarrier_5_F",
 	"Land_LampHarbour_F",
	"Land_LampShabby_F",
 	"Land_MetalBarrel_F",
 	"Land_Mil_ConcreteWall_F",
 	"Land_Obstacle_Ramp_F",
 	"Land_Pipes_large_F",
	"Land_RampConcreteHigh_F",
 	"Land_RampConcrete_F",
 	"Land_Razorwire_F",
 	"Land_Sacks_goods_F",
 	"Land_Scaffolding_F",
 	"Land_Shoot_House_Wall_F",
 	"Land_Stone_8m_F",
 	"Land_ToiletBox_F",
 	"Land_BarrelWater_F",
	"Land_Stone_8m_F",
	"Land_BarrelWater_F",
	"BlockConcrete_F",
	"Land_PowerGenerator_F",
	"Land_Cargo20_military_green_F",
	"Land_WheelieBin_01_F",
	"Land_Walkover_01_F",
	"Land_SM_01_shelter_narrow_",
	"Land_SCF_01_shed_F",
	"Land_Cargo20_grey_F",
	"Land_i_Shed_Ind_F",
	"Land_Shed_Small_F",
	"Land_Shed_Big_F",
	"StorageBladder_01_fuel_sand_F",
	"Land_Wall_Tin_4",
	"Land_CncBarrier_stripes_F",
	"Land_MobileScafolding_01_F",
	"Land_GarbageContainer_closed_F",
	"Land_LampStreet_small_F",
	"Land_TouristShelter_01_F",
	"Land_GH_Stairs_F",
	"Land_FireEscape_01_short_F",
	"Land_Airport_01_controlTower_F",
	"Land_AirstripPlatform_01_F",
	"Land_PillboxBunker_01_hex_F",
	"Land_PillboxBunker_01_big_F",
	"Land_PillboxBunker_01_rectangle_F",
	"Land_PillboxWall_01_3m_F",
	"Land_PillboxWall_01_6m_F",
	"Land_ConcreteWall_01_l_8m_F",
	"Land_ConcreteWall_01_l_pole_F",
	"Land_ConcreteWall_01_l_gate_F",
	"Land_ConcretePipe_F",
	"Land_ConcreteWall_01_l_4m_F",
	"Land_InfoStand_V2_F",
	"Land_Device_assembled_F",
	"Box_NATO_AmmoVeh_F",
	"Box_NATO_Ammo_F",
	"Land_Noticeboard_F",
	"Land_WaterTank_F",
	"Land_CargoBox_V1_F",
	"Land_Cargo40_military_green_F",
	"Land_Canal_Wall_10m_F",
	"Land_Warehouse_01_ladder_F",
	"Land_Warehouse_02_ladder_F",
	"Land_ConcreteWall_02_m_gate_F",
	"Land_FireExtinguisher_F",
	"Land_Shed_06_F",
	"Land_Sidewalk_01_8m_F",
	"Land_Sidewalk_01_4m_F",
	"Land_Sidewalk_01_narrow_4m_F",
	"Land_Sidewalk_01_narrow_8m_F",
	"Land_Cargo20_yellow_F",
	"Land_Cargo40_white_F",
	"Land_CratesWooden_F",
	"Land_GH_Platform_F",
	"Land_PipeFence_02_s_4m_F",
	"Land_PipeFence_02_s_8m_F",
	"Land_Bunker_01_big_F",
	"Land_Bunker_01_small_F",
	"Land_Bunker_01_tall_F",
	"Land_LampHalogen_F",
	"Land_LampAirport_F",
	"Land_ConcreteKerb_02_4m_F",
	"Land_ConcreteKerb_02_8m_F",
	"Land_ConcreteKerb_03_BY_short_F",
	"Land_ConcreteKerb_03_BY_long_F",
	"Land_ConcreteKerb_02_2m_F",
	"Land_ConcreteWall_01_m_4m_F",
	"Land_ConcreteWall_01_m_8m_F",
	"Land_Bunker_01_blocks_3_F",
	"Land_Bunker_01_blocks_1_F",
	"Land_FireEscape_01_tall_F",
	"Land_Hangar_F"
];
