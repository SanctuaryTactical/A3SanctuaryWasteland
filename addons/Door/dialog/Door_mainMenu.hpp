// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
#define Door_Menu_dialog 17000
#define Door_Menu_option 17001

class Door_Menu
{
	idd = Door_Menu_dialog;
	movingEnable=1;
	onLoad = "uiNamespace setVariable ['Door_Menu', _this select 0]";

	class controlsBackground {

		class Door_Menu_background: IGUIBack
		{
			idc=-1;
			colorText[] = {1, 1, 1, 1};
			colorBackground[] = {0, 0, 0, 0.6};
			x=0.28;
			y=0.10;
			w=0.3505;
			h=0.70;
		};

		class TopBar: IGUIBack
		{
			idc = -1;
			colorText[] = {1, 1, 1, 1};
			colorBackground[] = {A3W_UICOLOR_R, A3W_UICOLOR_G, A3W_UICOLOR_B, A3W_UIFILL};

			x=0.28;
			y=0.10;
			w=0.3505;
			h=0.05;
		};

		class Door_Menu_Title:w_RscText
		{
			idc=-1;
			text="Door Menu";
			x=0.29;
			y=0.108;
			w=0.088;
			h=0.035;
		};
	};

	class controls {

		class Door_Menu_options:w_Rsclist
		{
			idc = Door_Menu_option;
			x=0.30;
			y=0.18;
			w=0.31;
			h=0.49;
		};

		class Door_Menu_activate:w_RscButton
		{
			idc=-1;
			text="Select";
			onButtonClick = "[1] execVM 'addons\Door\Door_optionSelect.sqf'";
			x=0.345;
			y=0.70;
			w=0.22;
			h=0.071;
		};
	};
};

