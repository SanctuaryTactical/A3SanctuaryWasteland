/*
    Author: Firsty
    Copyright by Firsty (C) 2016
*/

// Triggers the audio intro.ogg via "class CfgMusic" from description.ext
[] spawn {
	playMusic "FirstyIntro";
};
// Loading text on black background change YOURTEXT with what you want. They appear in order, centered on the screen.
	titleCut ["", "BLACK FADED", 999];
[] Spawn {
	titleText ["Sanctuary Tactical Gaming Presents","PLAIN"]; 
	titleFadeOut 8;
	sleep 10;
	titleText ["A3Wasteland","PLAIN"];
	titleFadeOut 3;
	sleep 4;
	titleText ["Please see the server rules","PLAIN"];
	titleFadeOut 3;
	sleep 4;
	titleText ["and enjoy your stay","PLAIN"];
	titleFadeOut 3;
	sleep 3;
	titleCut ["", "BLACK IN", 5];
	};

/*
	
// Messages shown ingame on the right "storytelling"
private ["_messages", "_timeout"];

_messages = [
	["Welcome to Sanctuary Tactical A3Wasteland", (name player)], // change YOURMAPNAME with the Map you want the script to greet you with.
	["Recent Change Log",""], //First story text
	["Added 'h' hotkey to holster/unholster weapon",""], //Second story text
	["Added '0' hotkey to auto-run",""], //Third story text
	["Added DMV to change vehicle ownership",""], //Fourth story text
	["Added chapel in Edessa", ""],
	["Fixed the sell value of vehicles not found in the store",""], //Fourth story text
	["Fixed missing ammo types in the gun store",""], //Fourth story text
	["Decreased (slightly) mission AI size",""], //Fourth story text
	["Removed 'Drug Runners' mission", ""],
	["Added an 'improved' status bar (experimental)",""], //Fourth story text
	["Added player screen improvements (experimental)",""], //Fourth story text,
	["Added this introduction (experimental)",""], //Fourth story text
	["Locking/Unlocking your own objects is now MUCH faster",""],
	["Locking/Unlocking someone else's objects is now painfully slow",""],
	["Don't worry... Changes won't always be communicated this way", ""]
];

_timeout = 5;
{
	private ["_title", "_content", "_titleText"];
	uiSleep 2;
	_title = _x select 0;
	_content = _x select 1;
	_titleText = format[("<t font='TahomaB' size='0.40' color='#FFFFFF' align='left' shadow='1' shadowColor='#000000'>%1</t><br /><t shadow='1'shadowColor='#000000' font='TahomaB' size='0.60' color='#FFFFFF' align='left'>%2</t>"), _title, _content];
	[_titleText,[safezoneX + safezoneW - 0.8,0.50],[safezoneY + safezoneH - 0.8,0.7],_timeout,0.5] spawn BIS_fnc_dynamicText;
	uiSleep (_timeout * 1.2);
	
} forEach _messages;
*/