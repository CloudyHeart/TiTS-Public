﻿package classes
{

	import classes.RoomClass;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Rectangle;
	import flash.net.FileReference;
	import flash.net.SharedObject;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.AntiAliasType;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.ui.Keyboard;
	import flash.ui.Mouse;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;


	import classes.StatBarSmall;
	import classes.StatBarBig;

	//Build the bottom drawer
	public class GUI extends MovieClip
	{
		//this.leftSideBar.sceneTitle.filters = [glow];

		var textBuffer:Array;
		//Used for temp buffer stuff
		var tempText:String;
		var tempAuthor:String;
		var currentPCNotes:String;
		//Used for output()
		var outputBuffer:String;
		var outputBuffer2:String;
		var authorBuffer:Array;
		var textPage:int;
		public var days:int;
		public var hours:int;
		public var minutes:int;

	
		//Lazy man state checking
		var showingPCAppearance:Boolean;


		//temporary nonsense variables.
		public var tempEvent:MouseEvent;
		var temp:int;

		var textInput:TextField;
		
		var buttonDrawer:BottomButtonDrawer;
		var buttons:Array;
		var buttonData:Array;
		var buttonPage:int;
		public var leftSideBar:LeftBar;
		var fadeOut:*;
		var titsPurple:*;
		var titsBlue:*;
		var titsWhite:*;
		
		var buttonPagePrev:leftButton;
		var buttonPageNext:rightButton;
		var pagePrev:leftButton;
		var pageNext:rightButton;
		public var rightSidebar:RightBar;

		var monsterHP:StatBarBig;
		var monsterLust:StatBarBig;
		var monsterEnergy:StatBarBig;
		var monsterLevel:StatBarSmall;
		var monsterRace:StatBarSmall;
		var monsterSex:StatBarSmall;
		var playerShields:StatBarBig;
		var playerHP:StatBarBig;
		var playerLust:StatBarBig;
		var playerEnergy:StatBarBig;


		var playerLevel:StatBarSmall;
		var playerXP:StatBarSmall;
		var playerCredits:StatBarSmall;
		var playerPhysique:StatBarSmall;
		var playerReflexes:StatBarSmall;
		var playerAim:StatBarSmall;
		var playerIntelligence:StatBarSmall;
		var playerWillpower:StatBarSmall;
		var playerLibido:StatBarSmall;

		var format1:TextFormat;
		var mainFont:Font3;
		var mainTextField:TextField;
		var mainTextField2:TextField;
		var upScrollButton:arrow;
		var downScrollButton:arrow;
		var scrollBar:Bar;
		var scrollBG:Bar;
		var mainMenuButtons:Array;
		var titleDisplay:titsLogo;
		var warningBackground:warningBG;
		var creditText:TextField;
		var warningText:TextField;
		var websiteDisplay:TextField;
		var titleFormat:TextFormat;
		public var myGlow:GlowFilter;


		var titsClassPtr:*;
		var stagePtr:*;

		public function GUI(titsClassPtrArg:*, stagePtrArg:*)
		{
			trace("GUI Constructor")

			// Pointer to the TiTS class
			// this is THE MOST HORRIBLE WORK-AROUND EVEN THEORETICALLY POSSIBLE.
			this.titsClassPtr = titsClassPtrArg;
			this.stagePtr = stagePtrArg;

			//Lazy man state checking
			this.showingPCAppearance = false;

			this.textBuffer = new Array("","","","");
			//Used for temp buffer stuff
			this.tempText = "";
			this.tempAuthor = "";
			this.currentPCNotes = undefined;
			//Used for output()
			this.outputBuffer = "";
			this.outputBuffer2 = "";
			this.authorBuffer = new Array("","","","");
			this.textPage = 4;
			this.days = 0;
			this.hours = 0;
			this.minutes = 0;


			this.buttonDrawer = new BottomButtonDrawer;
			this.titsClassPtr.addChild(buttonDrawer);
			this.buttonDrawer.x = 0;
			this.buttonDrawer.y = 800;

			//Build the buttons
			this.buttons = new Array();
			this.buttonData = new Array();
			this.buttonPage = 1;
			this.initializeButtons();

			//Build left sidebar
			this.leftSideBar = new LeftBar;
			this.leftSideBar.x = 0;
			this.leftSideBar.y = 0;
			this.titsClassPtr.addChild(this.leftSideBar);
			//Fading out Perks and Level Up Buttons

			this.fadeOut = new ColorTransform();
			this.titsPurple = new ColorTransform();
			this.titsBlue = new ColorTransform();
			this.titsWhite = new ColorTransform();

			this.fadeOut.color = 0x333E52;
			this.titsPurple.color = 0x84449B;
			this.titsBlue.color = 0x333E52;
			this.titsWhite.color = 0xFFFFFF;

			this.leftSideBar.levelUpButton.plusses.transform.colorTransform = fadeOut;
			this.leftSideBar.perksButton.star.transform.colorTransform = fadeOut;


			this.monsterHP = new StatBarBig();
			this.titsClassPtr.addChild(this.monsterHP);
			this.monsterHP.x = 10;
			this.monsterHP.y = 237;
			this.monsterHP.background.x = -150;
			this.monsterHP.bar.width = 30;
			this.monsterHP.values.text = "SOUTH ESBETH 3";
			this.monsterHP.visible = false;

			this.monsterLust = new StatBarBig();
			this.titsClassPtr.addChild(this.monsterLust);
			this.monsterLust.x = 10;
			this.monsterLust.y = 278;
			this.monsterLust.masks.labels.text = "LUST";
			this.monsterLust.values.text = "25";
			this.monsterLust.background.x = -1 * (1 - 25 / 100) * 180;
			this.monsterLust.bar.width = (25 / 100) * 180;
			this.monsterLust.highBad = true;
			this.monsterLust.visible = false;

			this.monsterEnergy = new StatBarBig();
			this.titsClassPtr.addChild(this.monsterEnergy);
			this.monsterEnergy.x = 10;
			this.monsterEnergy.y = 319;
			this.monsterEnergy.masks.labels.text = "ENERGY";
			this.monsterEnergy.values.text = "HOTEL ROOM"
;
			this.monsterEnergy.visible = false;


			this.monsterLevel = new StatBarSmall();
			this.titsClassPtr.addChild(this.monsterLevel);
			this.monsterLevel.x = 10;
			this.monsterLevel.y = 363;
			this.setupStatBar(this.monsterLevel,"LEVEL",5);
			this.monsterLevel.visible = false;


			this.monsterRace = new StatBarSmall();
			this.titsClassPtr.addChild(this.monsterRace);
			this.monsterRace.x = 10;
			this.monsterRace.y = 392;
			this.setupStatBar(this.monsterRace,"RACE","Galotian");
			this.monsterRace.visible = false;


			this.monsterSex = new StatBarSmall();
			this.titsClassPtr.addChild(this.monsterSex);
			this.monsterSex.x = 10;
			this.monsterSex.y = 421;
			this.setupStatBar(this.monsterSex,"SEX","Unknown");
			this.monsterSex.visible = false;


			leftBarClear();

			//Build the right sidebar
			this.rightSidebar = new RightBar;
			this.titsClassPtr.addChild(this.rightSidebar);
			this.rightSidebar.nameText.text = "Penis";
			this.rightSidebar.x = 1000;
			this.rightSidebar.y = 0;
			trace("Calling statBar constructors");
			this.playerHP = new StatBarBig();
			this.playerLust = new StatBarBig();
			this.playerEnergy = new StatBarBig();
			this.playerShields = new StatBarBig();
			this.titsClassPtr.addChild(playerShields);
			this.titsClassPtr.addChild(playerHP);
			this.titsClassPtr.addChild(playerLust);
			this.titsClassPtr.addChild(playerEnergy);
			this.playerShields.x = 1010;
			this.playerShields.y = 65;
			this.playerHP.x = 1010;
			this.playerHP.y = 106;
			this.playerLust.x = 1010;
			this.playerLust.y = 147;
			this.playerEnergy.x = 1010;
			this.playerEnergy.y = 188;
			this.playerShields.masks.labels.text = "SHIELDS";
			this.playerShields.bar.width = 30;
			this.playerShields.values.text = "SOUTH ESBETH 3";
			this.playerShields.background.x = -150;
			this.playerHP.x = 1010;
			this.playerHP.y = 65;
			this.playerLust.x = 1010;
			this.playerLust.y = 106;
			this.playerEnergy.x = 1010;
			this.playerEnergy.y = 147;
			this.playerHP.background.x = -150;
			this.playerHP.bar.width = 30;
			this.playerHP.values.text = "SOUTH ESBETH 3";
			this.playerLust.masks.labels.text = "LUST";
			this.playerLust.values.text = "25";
			this.playerLust.background.x = -1 * (1 - 25 / 100) * 180;
			this.playerLust.bar.width = (25 / 100) * 180;
			this.playerLust.highBad = true;
			this.playerEnergy.masks.labels.text = "ENERGY";
			this.playerEnergy.values.text = "HOTEL ROOM"
;
			this.buttonPagePrev = new leftButton;
			this.titsClassPtr.addChild(this.buttonPagePrev);
			this.buttonPagePrev.x = 1000;
			this.buttonPagePrev.y = 750;
			this.buttonPagePrev.alpha = .3;
			this.buttonPageNext = new rightButton;
			this.titsClassPtr.addChild(this.buttonPageNext);
			this.buttonPageNext.x = 1100;
			this.buttonPageNext.y = 750;
			this.buttonPageNext.alpha = .3;
			this.pagePrev = new leftButton;
			this.titsClassPtr.addChild(this.pagePrev);
			this.pagePrev.x = 010;
			this.pagePrev.y = 750;
			this.pagePrev.alpha = .3;
			this.pageNext = new rightButton;
			this.titsClassPtr.addChild(this.pageNext);
			this.pageNext.x = 110;
			this.pageNext.y = 750;
			this.pageNext.alpha = .3;
			this.playerLevel = new StatBarSmall();
			this.playerXP = new StatBarSmall();
			this.playerCredits = new StatBarSmall();
			this.playerLevel.x = 1010;
			this.playerLevel.y = 456;
			this.playerLevel.masks.labels.text = "LEVEL";
			this.playerLevel.bar.visible = false;
			this.playerLevel.background.x = -180;
			this.playerLevel.values.text = "WEST ESBETH 1";
			this.playerLevel.noBar = true;
			this.playerXP.x = 1010;
			this.playerXP.y = 485;
			this.playerXP.masks.labels.text = "XP";
			this.playerXP.bar.width = (50 / 500) * 180;
			this.playerXP.background.x =  -1 * (1 - 50 / 500) * 180;
			this.playerXP.values.text = "50 / 1000";
			this.playerCredits.x = 1010;
			this.playerCredits.y = 514;
			this.playerCredits.noBar = true;
			this.playerCredits.masks.labels.text = "CREDITS";
			this.playerCredits.bar.visible = false;
			this.playerCredits.background.x =  -180;
			this.playerCredits.values.text = "Over 9000";
			this.titsClassPtr.addChild(this.playerLevel);
			this.titsClassPtr.addChild(this.playerXP);
			this.titsClassPtr.addChild(this.playerCredits);
			this.playerPhysique = new StatBarSmall();
			this.playerReflexes = new StatBarSmall();
			this.playerAim = new StatBarSmall();
			this.playerIntelligence = new StatBarSmall();
			this.playerWillpower = new StatBarSmall();
			this.playerLibido = new StatBarSmall();
			this.titsClassPtr.addChild(this.playerPhysique);
			this.titsClassPtr.addChild(this.playerReflexes);
			this.titsClassPtr.addChild(this.playerAim);
			this.titsClassPtr.addChild(this.playerIntelligence);
			this.titsClassPtr.addChild(this.playerWillpower);
			this.titsClassPtr.addChild(this.playerLibido);
			this.playerPhysique.x = 1010;
			this.playerPhysique.y = 255;
			this.playerReflexes.x = 1010;
			this.playerReflexes.y = 284;
			this.playerAim.x = 1010;
			this.playerAim.y = 313;
			this.playerIntelligence.x = 1010;
			this.playerIntelligence.y = 342;
			this.playerWillpower.x = 1010;
			this.playerWillpower.y = 371;
			this.playerLibido.x = 1010;
			this.playerLibido.y = 400;

			this.setupStatBar(this.playerPhysique,"PHYSIQUE",50,100);
			this.setupStatBar(this.playerReflexes,"REFLEXES",30,100);
			this.setupStatBar(this.playerAim,"AIM",30,100);
			this.setupStatBar(this.playerIntelligence,"INTELLIGENCE",90,100);
			this.setupStatBar(this.playerWillpower,"WILLPOWER",5,100);
			this.setupStatBar(this.playerLibido,"LIBIDO",97,100);

			this.hidePCStats();


			//Set up the main text field
			this.format1 = new TextFormat();
			this.format1.size = 18;
			this.format1.color = 0xFFFFFF;
			this.format1.tabStops = [35];
			mainFont = new Font3;
			format1.font = mainFont.fontName;
			this.mainTextField = new TextField();
			this.prepTextField(this.mainTextField);
			this.mainTextField.text = "Trails in Tainted Space booting up...\nLoading horsecocks...\nSpreading vaginas...\nLubricating anuses...\nPlacing traps...\n\n...my body is ready.";
			//Set up backup text field
			this.mainTextField2 = new TextField();
			this.prepTextField(this.mainTextField2);


			//Set up standard input box!
			this.textInput = new TextField();
			this.textInput.width = 250;
			this.textInput.height = 25;
			this.textInput.backgroundColor = 0xFFFFFF;
			this.textInput.border = true;
			this.textInput.borderColor = 0xFFFFFF;

			this.textInput.type = TextFieldType.INPUT;
			this.textInput.setTextFormat(format1);
			this.textInput.defaultTextFormat = format1;


			//SCROLLBAR!
			upScrollButton = new arrow();
			upScrollButton.x = mainTextField.x + mainTextField.width;
			upScrollButton.y = mainTextField.y
			downScrollButton = new arrow();
			downScrollButton.x = mainTextField.x + mainTextField.width + downScrollButton.width;
			downScrollButton.y = mainTextField.y + mainTextField.height;
			downScrollButton.rotation = 180;
			scrollBar = new Bar();
			scrollBar.x = mainTextField.x + mainTextField.width;
			scrollBar.y = mainTextField.y + upScrollButton.height;
			scrollBar.height = 50;
			scrollBG = new Bar();
			scrollBG.x = mainTextField.x + mainTextField.width;
			scrollBG.y = mainTextField.y + upScrollButton.height;
			scrollBG.height = mainTextField.height - upScrollButton.height - downScrollButton.height;
			scrollBG.transform.colorTransform = fadeOut;
			this.titsClassPtr.addChild(scrollBG);
			this.titsClassPtr.addChild(scrollBar);
			this.titsClassPtr.addChild(upScrollButton);
			this.titsClassPtr.addChild(downScrollButton);
			//Since downscroll starts clickable...
			downScrollButton.buttonMode = true;

			clearMenu();
			/*
			clearMenu();
			addButton(0,"Horsecock",horsecock);
			addButton(14,"CLEAR!",clearOutput);
			addButton(16,"2Horse4Me",horsecock);
			*/

			//4. MAIN MENU STUFF
			this.mainMenuButtons = new Array();
			titleDisplay = new titsLogo();
			warningBackground = new warningBG();
			creditText = new TextField();
			warningText = new TextField();
			websiteDisplay = new TextField();
			titleFormat = new TextFormat();
			myGlow = new GlowFilter();
			myGlow.color = 0x84449B;
			myGlow.alpha = 1;
			myGlow.blurX = 10;
			myGlow.blurY = 10;
			myGlow.strength = 5;

			//Credit Text
			creditText.border = false;
			creditText.background = false;
			creditText.multiline = true;
			creditText.wordWrap = true;
			creditText.border = false;
			creditText.x = 210;
			creditText.y = 305;
			creditText.height = 77;
			creditText.width = 780;
			//Website Text
			websiteDisplay.border = false;
			websiteDisplay.htmlText = "http://www.trialsInTaintedSpace.com";
			websiteDisplay.background = false;
			websiteDisplay.multiline = true;
			websiteDisplay.wordWrap = true;
			websiteDisplay.border = false;
			websiteDisplay.x = 210;
			websiteDisplay.y = 475;
			websiteDisplay.height = 25;
			websiteDisplay.width = 780;
			//Warning Text
			warningText.border = false;

			warningText.background = false;
			warningText.multiline = true;
			warningText.wordWrap = true;
			warningText.border = false;
			warningText.x = 305;
			warningText.y = 390;
			warningText.height = 75;
			warningText.width = 655;
			//Set the formats
			titleFormat.size = 18;
			titleFormat.color = 0xFFFFFF;
			titleFormat.tabStops = [35];
			titleFormat.font = mainFont.fontName;
			titleFormat.align = TextFormatAlign.CENTER;

			creditText.setTextFormat(titleFormat);
			creditText.defaultTextFormat = titleFormat;
			warningText.setTextFormat(titleFormat);
			warningText.defaultTextFormat = titleFormat;
			websiteDisplay.setTextFormat(titleFormat);
			websiteDisplay.defaultTextFormat = titleFormat;

			titleDisplay.x = 368;
			titleDisplay.y = 142;

			//Add warning display
			warningBackground.x = 210;
			warningBackground.y = 380;
			this.titsClassPtr.addChild(titleDisplay);
			this.titsClassPtr.addChild(warningBackground);
			this.titsClassPtr.addChild(creditText);
			this.titsClassPtr.addChild(warningText);
			this.titsClassPtr.addChild(websiteDisplay);
			websiteDisplay.visible = false;
			creditText.visible = false;
			warningText.visible = false;
			titleDisplay.visible = false;
			websiteDisplay.visible = false;
			warningBackground.visible = false;

			//setupInputEventHandlers();

			initializeMainMenu();
			//mainMenu();
		}

		//Build the main 15 buttons!
		public function initializeButtons():void 
		{
			trace("Initializing buttons")
			var temp = 0;
			//X and Y values for our buttons.
			var ex:int = 52;
			var why:int = 650;
			var texts:String = "Random#: ";
			while (temp < 60) {
				buttonData[temp] = new purpleButton;
				temp++;
			}
			temp = 0;
			while (temp < 15) {
				//Adjust for new rows
				if(temp % 5 == 0 && temp > 0) {
					ex -= 790;
					why += 50;
				}
				//Add on from previous button value.
				ex += 158;
				
				if (temp == 6 || temp == 10 || temp == 11 || temp == 12) {
					buttons[temp] = new purpleButton;
				}
				else {
					buttons[temp] = new blueButton;
				}
				this.titsClassPtr.addChild(buttons[temp]);
				buttons[temp].caption.htmlText = texts + String(Math.round(Math.random()*10));
				buttons[temp].x = ex;
				buttons[temp].y = why;
				buttons[temp].mouseChildren = false;
				//Add hotkey tags as appropriate.
				switch(temp) {
					case 0:
						buttons[temp].hotkey.text = "SPACEPORT ELEVATOR";
						break;
					case 1:
						buttons[temp].hotkey.text = "CUSTOMS OFFICE";
						break;
					case 2:
						buttons[temp].hotkey.text = "ESBETH'S NORTH PATH";
						break;
					case 3:
						buttons[temp].hotkey.text = "NORTHWEST ESBETH";
						break;
					case 4:
						buttons[temp].hotkey.text = "WEST ESBETH 1";
						break;
					case 5:
						buttons[temp].hotkey.text = "Q";
						break;
					case 6:
						buttons[temp].hotkey.text = "W";
						break;
					case 7:
						buttons[temp].hotkey.text = "E";
						break;
					case 8:
						buttons[temp].hotkey.text = "R";
						break;
					case 9:
						buttons[temp].hotkey.text = "T";
						break;
					case 10:
						buttons[temp].hotkey.text = "A";
						break;
					case 11:
						buttons[temp].hotkey.text = "S";
						break;
					case 12:
						buttons[temp].hotkey.text = "D";
						break;
					case 13:
						buttons[temp].hotkey.text = "F";
						break;
					case 14:
						buttons[temp].hotkey.text = "G";
						break;
				}
				temp++;
			}
		}



		//1. BUTTON STUFF
		public function clearMenu():void {
			for(var x:int = 0; x < buttons.length ;x++) {
				buttons[x].func = undefined;
				buttons[x].arg = undefined;
				buttons[x].alpha = .3;
				buttons[x].caption.text = "";
				buttons[x].buttonMode = false;
				while(buttons[x].hasEventListener(MouseEvent.CLICK)) buttons[x].removeEventListener(MouseEvent.CLICK,titsClassPtr.buttonClick);
			}
			for(x = 0; x < buttonData.length; x++) {
				buttonData[x].func = undefined;
				buttonData[x].arg = undefined;
				buttonData[x].caption.text = "";
			}
			menuPageChecker();
		}
		//Used for ghost menus in main menu and options.
		public function clearGhostMenu():void {
			for(var x:int = 0; x < buttons.length ;x++) {
				buttons[x].func = undefined;
				buttons[x].arg = undefined;
				buttons[x].alpha = .3;
				buttons[x].caption.text = "";
				buttons[x].buttonMode = false;
				while(buttons[x].hasEventListener(MouseEvent.CLICK)) buttons[x].removeEventListener(MouseEvent.CLICK,titsClassPtr.buttonClick);
			}
			//menuPageChecker();
		}

		public function forwardPageButtons(e:MouseEvent):void {
			pageButtons();
		}
		public function backPageButtons(e:MouseEvent):void {
			pageButtons(false);
		}

		public function menuPageChecker():void {
			var lastButton:int = 0;
			for(var x:int = 0; x < buttonData.length; x++) {
				if(buttonData[x].caption.text != "") {
					lastButton = x;
				}
			}
			//If you can go right still.
			if((lastButton + 1)/15 > buttonPage) {
				if(buttonPageNext.alpha != 1) {
					buttonPageNext.addEventListener(MouseEvent.CLICK,forwardPageButtons);
					buttonPageNext.alpha = 1;
					buttonPageNext.buttonMode = true;
				}
			}
			//If you can't go right but the button aint turned off.
			else if(buttonPageNext.alpha != .3) {
				buttonPageNext.removeEventListener(MouseEvent.CLICK,forwardPageButtons);
				buttonPageNext.alpha = .3;
				buttonPageNext.buttonMode = false;
			}
			//Left hooo!
			if(buttonPage != 1) {
				if(buttonPagePrev.alpha != 1) {
					buttonPagePrev.addEventListener(MouseEvent.CLICK,backPageButtons);
					buttonPagePrev.alpha = 1;
					buttonPagePrev.buttonMode = true;
				}
			}
			//If you can't go right but the button aint turned off.
			else if(buttonPagePrev.alpha != .3) {
				buttonPagePrev.removeEventListener(MouseEvent.CLICK,backPageButtons);
				buttonPagePrev.alpha = .3;
				buttonPagePrev.buttonMode = false;
			}
		}

		public function pageButtons(forward:Boolean = true):void {
			if(forward) buttonPage++;
			else buttonPage--;
			if(buttonPage < 1) buttonPage = 1;
			else if(buttonPage > 4) buttonPage = 4;
			var diff:int = (buttonPage-1) * 15;
			for(var x:int = 0; x < buttons.length ;x++) {
				buttons[x].func = buttonData[x+diff].func;
				//Inactive button gets put transparent and listeners removed.
				if(buttonData[x+diff].caption.text == "" || buttonData[x+diff].func == undefined) {
					buttons[x].alpha = .3;
					buttons[x].caption.text = buttonData[x+diff].caption.text;
					while(buttons[x].hasEventListener(MouseEvent.CLICK)) buttons[x].removeEventListener(MouseEvent.CLICK,titsClassPtr.buttonClick);
					buttons[x].buttonMode = false;
				}
				else {
					buttons[x].arg = buttonData[x+diff].arg;
					buttons[x].alpha = 1;
					buttons[x].buttonMode = true;
					buttons[x].caption.text = buttonData[x+diff].caption.text;
					buttons[x].addEventListener(MouseEvent.CLICK,titsClassPtr.buttonClick);
				}
			}
			//Check back/next buttons
			menuPageChecker();
		}

		public function prepTextField(arg:TextField):void 
		{
			arg.border = false;
			arg.text = "Placeholder";
			arg.background = false;
			arg.multiline = true;
			arg.wordWrap = true;
			arg.border = false;
			arg.x = 211;
			arg.y = 5;
			arg.height = 630;
			arg.width = 760;
			arg.setTextFormat(format1);
			arg.defaultTextFormat = format1;
			this.titsClassPtr.addChild(arg);
			arg.visible = false;
		}

		public function addButton(slot:int,cap:String = "",func = undefined,arg = undefined):void {
			if(slot <= 14) {
				buttons[slot].alpha = 1;
				buttons[slot].caption.text = cap;
				buttons[slot].addEventListener(MouseEvent.CLICK,titsClassPtr.buttonClick);
				buttons[slot].func = func;
			
				buttons[slot].arg = arg;
			
				buttons[slot].buttonMode = true;
			}	
			buttonData[slot].func = func;
			buttonData[slot].arg = arg;
			buttonData[slot].caption.text = cap;
			menuPageChecker();
		}
		//Returns the position of the last used buttonData spot.
		function lastButton():int 
		{
			for(var x:int = buttonData.length; x >= 0; x--) {
				if(buttonData[x].caption.text != "") break;
			}
			if(buttonData[x].caption.text == "" && x == 0) x = -1;
			return x;
		}
		public function addDisabledButton(slot:int,cap:String = ""):void {
			if(slot <= 14) {
				buttons[slot].alpha = .3;
				buttons[slot].caption.text = cap;
				//buttons[slot].addEventListener(MouseEvent.CLICK,titsClassPtr.buttonClick);
				buttons[slot].func = undefined;
				buttons[slot].arg = undefined;
				buttons[slot].buttonMode = false;
			}	
			buttonData[slot].func = undefined;
			buttonData[slot].arg = undefined;
			buttonData[slot].caption.text = cap;
			menuPageChecker();
		}
		//Ghost button - used for menu buttons that overlay the normal buttons. 
		public function addGhostButton(slot:int,cap:String = "",func = undefined,arg = undefined):void {
			if(slot > 14) return;
			buttons[slot].alpha = 1;
			buttons[slot].caption.text = cap;
			buttons[slot].addEventListener(MouseEvent.CLICK,titsClassPtr.buttonClick);
			buttons[slot].func = func;
			buttons[slot].arg = arg;
			buttons[slot].buttonMode = true;
		}
		public function addMainMenuButton(slot:int,cap:String = "",func = undefined,arg = undefined):void {
			if(slot <= this.mainMenuButtons.length) {
				this.mainMenuButtons[slot].alpha = 1;
				this.mainMenuButtons[slot].caption.text = cap;
				this.mainMenuButtons[slot].addEventListener(MouseEvent.CLICK,titsClassPtr.buttonClick);
				this.mainMenuButtons[slot].func = func;
			
				this.mainMenuButtons[slot].arg = arg;
			
				this.mainMenuButtons[slot].buttonMode = true;
				this.mainMenuButtons[slot].visible = true;
			}	
			menuPageChecker();
		}


		public function pushToBuffer():void {
			if(tempText != "") {
				textBuffer[textBuffer.length] = tempText;
				authorBuffer[authorBuffer.length] = tempAuthor;
				tempText = "";
				tempAuthor = "";
			}
			else {
				textBuffer[textBuffer.length] = mainTextField.htmlText;
				authorBuffer[authorBuffer.length] = this.leftSideBar.sceneBy.htmlText;
			}
			if(textBuffer.length > 4) {
				textBuffer.splice(0,1);
				authorBuffer.splice(0,1);
			}
		}

		public function forwardBuffer(e:MouseEvent):void {
			if(textPage < 4) {
				textPage++;
			}
			else return;
			mainTextField.text = "";
			updateScroll(e);
			trace("TextPage: " + textPage);
			if(textPage == 4) {
				mainTextField.htmlText = tempText;
				this.leftSideBar.sceneBy.htmlText = tempAuthor;
			}
			else {
				mainTextField.htmlText = textBuffer[textPage];
				this.leftSideBar.sceneBy.htmlText = authorBuffer[textPage];
			}
			updateScroll(e);
			titsClassPtr.bufferButtonUpdater();
		}
		public function backBuffer(e:MouseEvent):void {
			if(textPage == 4) {
				tempText = mainTextField.htmlText;
				tempAuthor = this.leftSideBar.sceneBy.text;
			}
			if(textPage > 0) {
				textPage--;
			}
			else return;
			mainTextField.text = "";
			updateScroll(e);
			trace("TextPage: " + textPage);
			mainTextField.htmlText = textBuffer[textPage];
			this.leftSideBar.sceneBy.htmlText = authorBuffer[textPage];
			updateScroll(e);
			titsClassPtr.bufferButtonUpdater();
		}

		public function displayInput():void {
			if(!this.stagePtr.contains(textInput)) this.titsClassPtr.addChild(textInput);
			textInput.text = "";
			textInput.visible = true;
			textInput.width = 160;
			textInput.x = mainTextField.x + 2;
			textInput.y = mainTextField.y + 8 + mainTextField.textHeight;
			textInput.visible = true;
			menuButtonsOff();
			appearanceOff();
			for (var x:int = 0; x < 15; x++) {
				buttons[x].hotkey.text = "-";
			}
			this.stagePtr.focus = textInput;
			textInput.text = "";
			textInput.maxChars = 0;
		}
		public function removeInput():void {
			this.titsClassPtr.removeChild(textInput);
			menuButtonsOn();
			buttons[0].hotkey.text = "SPACEPORT ELEVATOR";
			buttons[1].hotkey.text = "CUSTOMS OFFICE";
			buttons[2].hotkey.text = "ESBETH'S NORTH PATH";
			buttons[3].hotkey.text = "NORTHWEST ESBETH";
			buttons[4].hotkey.text = "WEST ESBETH 1";
			buttons[5].hotkey.text = "Q";
			buttons[6].hotkey.text = "W";
			buttons[7].hotkey.text = "E";
			buttons[8].hotkey.text = "R";
			buttons[9].hotkey.text = "T";
			buttons[10].hotkey.text = "A";
			buttons[11].hotkey.text = "S";
			buttons[12].hotkey.text = "D";
			buttons[13].hotkey.text = "F";
			buttons[14].hotkey.text = "G";
		}


		//Used to adjust position of scroll bar!
		public function updateScroll(e:MouseEvent):void {
			var target = mainTextField;
			if(!target.visible) target = mainTextField2;
			//Set the size of the bar!
			//Number of lines on screen
			var pageSize:int = target.bottomScrollV - target.scrollV + 1;
				//trace("Bottom Scroll V: " + target.bottomScrollV);
				//trace("Page Size: " + pageSize);
			//Fix pagesize for super tiny
			if(pageSize <= 0) pageSize = 1;
			//Number of pages
			var pages:Number = target.numLines / pageSize;
				//trace("Pages: " + pages);
			scrollBar.height = pageSize / target.numLines * (target.height - upScrollButton.height - downScrollButton.height);
			if(scrollBar.height < scrollBG.height) scrollBar.buttonMode = true;
			else scrollBar.buttonMode = false;
			
			//Set the position of the bar
			//the size of the scroll field
			var field:Number = target.height - upScrollButton.height - scrollBar.height - downScrollButton.height;
				//trace("Field: " + field);
			var progress:Number = 0;
			var min = target.scrollV;
			var max = target.maxScrollV;
				//trace("Min: " + min);
			//Don't divide by zero - cheese it to work.
			if(max == 1) {
				max = 2;
				min = 2;
			}
			progress = (min-1) / (max-1);
				//trace("Progress: " + progress);
				//trace("Progress x Field: " + progress * field);
			scrollBar.y = target.y + progress * field + upScrollButton.height;
			titsClassPtr.scrollChecker();
		}


		//4. MIAN MENU STUFF
		public function mainMenuButtonOn():void {
			if(this.leftSideBar.currentFrame >= 11) {
				//Set transparency to zero to show it's active.
				this.leftSideBar.mainMenuButton.alpha = 1;
				//Engage buttonmode.
				this.leftSideBar.mainMenuButton.buttonMode = true;
			}
		}
		public function mainMenuButtonOff():void {
			if(this.leftSideBar.currentFrame >= 11) {
				//Set transparency to zero to show it's active.
				this.leftSideBar.mainMenuButton.alpha = .3;
				//Engage buttonmode.
				this.leftSideBar.mainMenuButton.buttonMode = false;
				this.leftSideBar.mainMenuButton.filters = [];
			}
		}
		public function appearanceOn():void {
			if(this.leftSideBar.currentFrame >= 11) {
				//Set transparency to zero to show it's active.
				this.leftSideBar.appearanceButton.alpha = 1;
				//Engage buttonmode.
				this.leftSideBar.appearanceButton.buttonMode = true;
			}
		}
		public function appearanceOff():void {
			if(this.leftSideBar.currentFrame >= 11) {
				//Set transparency to zero to show it's active.
				this.leftSideBar.appearanceButton.alpha = .3;
				//Engage buttonmode.
				this.leftSideBar.appearanceButton.buttonMode = false;
				this.leftSideBar.appearanceButton.filters = [];
			}
		}
		public function dataOn():void {
			if(this.leftSideBar.currentFrame >= 11) {
				//Set transparency to zero to show it's active.
				this.leftSideBar.dataButton.alpha = 1;
				//Engage buttonmode.
				this.leftSideBar.dataButton.buttonMode = true;
			}
		}
		public function dataOff():void {
			if(this.leftSideBar.currentFrame >= 11) {
				//Set transparency to zero to show it's active.
				this.leftSideBar.dataButton.alpha = .3;
				//Engage buttonmode.
				this.leftSideBar.dataButton.buttonMode = false;
				this.leftSideBar.dataButton.filters = [];
			}
		}

		public function hideNormalDisplayShit():void {
			//Hide all current buttons
			for(var x:int = 0; x < buttons.length ;x++) {
				buttons[x].func = undefined;
				buttons[x].alpha = .3;
				buttons[x].caption.text = "";
				while(buttons[x].hasEventListener(MouseEvent.CLICK)) buttons[x].removeEventListener(MouseEvent.CLICK,titsClassPtr.buttonClick);
				buttons[x].buttonMode = false;
			}
			//Hide scrollbar & main text!
			upScrollButton.visible = false;
			downScrollButton.visible = false;
			scrollBar.visible = false;
			scrollBG.visible = false;
			mainTextField.visible = false;
			mainTextField2.visible = false;
			//Page buttons invisible!
			buttonPageNext.visible = false;
			buttonPagePrev.visible = false;
			pageNext.visible = false;
			pagePrev.visible = false;
		}

		public function menuButtonsOn():void 
		{
			trace("this.stagePtr = ", this.stagePtr);
			if(!titsClassPtr.pc.hasStatusEffect("In Creation") && titsClassPtr.pc.short != "uncreated") {
				appearanceOn();
			}
			if(!this.stagePtr.contains(this.textInput)) {
				mainMenuButtonOn();
				this.dataOn();
			}
		}
		public function menuButtonsOff():void {
			appearanceOff();
			this.dataOff();
			mainMenuButtonOff();
		}
		public function hideMenus():void {
			hideMainMenu();
			hideAppearance();
			hideData();
		}


		public function hideData():void {
			this.leftSideBar.dataButton.filters = [];
		}

		public function hideAppearance():void {
			//Not showing appearance anymore!
			showingPCAppearance = false;
			//Hide scrollbar & main text!
			upScrollButton.visible = true;
			downScrollButton.visible = true;
			scrollBar.visible = true;
			scrollBG.visible = true;
			mainTextField.visible = true;
			mainTextField2.visible = false;
			
			//Show menu shits
			creditText.visible = false;
			warningText.visible = false;
			titleDisplay.visible = false;
			warningBackground.visible = false;
			websiteDisplay.visible = false;
			
			//Turn off main menu buttons
			for(var x:int = 0; x < this.mainMenuButtons.length ;x++) {
				this.mainMenuButtons[x].func = undefined;
				this.mainMenuButtons[x].alpha = .3;
				this.mainMenuButtons[x].caption.text = "";
				while(this.mainMenuButtons[x].hasEventListener(MouseEvent.CLICK)) this.mainMenuButtons[x].removeEventListener(MouseEvent.CLICK,titsClassPtr.buttonClick);
				this.mainMenuButtons[x].buttonMode = false;
				this.mainMenuButtons[x].visible = false;
			}
			
			//Turn buttons back on
			var diff:int = (buttonPage-1) * 15;
			for(x = 0; x < buttons.length ;x++) {
				buttons[x].func = buttonData[x+diff].func;
				//Inactive button gets put transparent and listeners removed.
				if(buttonData[x+diff].func != undefined) {
					buttons[x].arg = buttonData[x+diff].arg;
					buttons[x].alpha = 1;
					buttons[x].buttonMode = true;
					buttons[x].caption.text = buttonData[x+diff].caption.text;
					buttons[x].addEventListener(MouseEvent.CLICK,titsClassPtr.buttonClick);
				}
				else {
					buttons[x].arg = undefined;
					buttons[x].alpha = .3;
					buttons[x].buttonMode = false;
					buttons[x].caption.text = "";
					buttons[x].removeEventListener(MouseEvent.CLICK,titsClassPtr.buttonClick);
				}
			}
			//Page buttons visible and updated!
			buttonPageNext.visible = true;
			buttonPagePrev.visible = true;
			menuPageChecker();
			pageNext.visible = true;
			pagePrev.visible = true;
			menuButtonsOn();
			this.leftSideBar.appearanceButton.filters = [];
			titsClassPtr.bufferButtonUpdater();
		}


		public function hideMainMenu():void {
			//Hide scrollbar & main text!
			upScrollButton.visible = true;
			downScrollButton.visible = true;
			scrollBar.visible = true;
			scrollBG.visible = true;
			mainTextField.visible = true;
			mainTextField2.visible = false;
			
			//Show menu shits
			creditText.visible = false;
			warningText.visible = false;
			titleDisplay.visible = false;
			warningBackground.visible = false;
			websiteDisplay.visible = false;
			
			//Turn off main menu buttons
			for(var x:int = 0; x < this.mainMenuButtons.length ;x++) {
				this.mainMenuButtons[x].func = undefined;
				this.mainMenuButtons[x].alpha = .3;
				this.mainMenuButtons[x].caption.text = "";
				while(this.mainMenuButtons[x].hasEventListener(MouseEvent.CLICK)) this.mainMenuButtons[x].removeEventListener(MouseEvent.CLICK,titsClassPtr.buttonClick);
				this.mainMenuButtons[x].buttonMode = false;
				this.mainMenuButtons[x].visible = false;
			}
			
			//Turn buttons back on
			var diff:int = (buttonPage-1) * 15;
			for(x = 0; x < buttons.length ;x++) {
				buttons[x].func = buttonData[x+diff].func;
				//Inactive button gets put transparent and listeners removed.
				if(buttonData[x+diff].func != undefined) {
					buttons[x].arg = buttonData[x+diff].arg;
					buttons[x].alpha = 1;
					buttons[x].buttonMode = true;
					buttons[x].caption.text = buttonData[x+diff].caption.text;
					buttons[x].addEventListener(MouseEvent.CLICK,titsClassPtr.buttonClick);
				}
			}
			//Page buttons visible and updated!
			buttonPageNext.visible = true;
			buttonPagePrev.visible = true;
			menuPageChecker();
			pageNext.visible = true;
			pagePrev.visible = true;
			menuButtonsOn();
			this.leftSideBar.mainMenuButton.filters = [];
			titsClassPtr.bufferButtonUpdater();
		}


		public function initializeMainMenu():void 
		{
			trace("Initializing main menu")
			//Initialize main menu buttons
			var ex:int = 210;
			var why:int = 518;
			for(x = 0; x < 6; x++) {
				if(x <= 2) this.mainMenuButtons[x] = new blueMainButton;
				else this.mainMenuButtons[x] = new blueMainButtonBig;
				//Adjust for new rows
				if(x == 3) {
					ex -= 474;
					why += 50;
				}
				//Add on from previous button value.
				ex += 158;
				this.titsClassPtr.addChild(this.mainMenuButtons[x]);
				
				this.mainMenuButtons[x].caption.htmlText = String(x);
				
				this.mainMenuButtons[x].x = ex;
				
				this.mainMenuButtons[x].y = why;
				
				this.mainMenuButtons[x].mouseChildren = false;
				this.mainMenuButtons[x].visible = false;
			}
		}


		public function leftBarClear():void {
			this.leftSideBar.sceneByTag.visible = false;
			this.leftSideBar.sceneBy.visible = false;
			this.leftSideBar.sceneTitle.visible = false;
			this.leftSideBar.planet.visible = false;
			this.leftSideBar.system.visible = false;
			this.leftSideBar.time.visible = false;
			this.leftSideBar.days.visible = false;
			this.leftSideBar.quicksaveButton.visible = false;
			this.leftSideBar.dataButton.visible = false;
			this.leftSideBar.statsButton.visible = false;
			this.leftSideBar.perksButton.visible = false;
			this.leftSideBar.levelUpButton.visible = false;
		}
		public function hidePCStats():void {
			this.playerShields.visible = false;
			this.playerHP.visible = false;
			this.playerLust.visible = false;
			this.playerEnergy.visible = false;
			this.playerLevel.visible = false;
			this.playerXP.visible = false;
			this.playerCredits.visible = false;
			this.playerPhysique.visible = false;
			this.playerReflexes.visible = false;
			this.playerAim.visible = false;
			this.playerIntelligence.visible = false;
			this.playerWillpower.visible = false;
			this.playerLibido.visible = false;
		}
		public function showPCStats():void {
			this.playerShields.visible = true;
			this.playerHP.visible = true;
			this.playerLust.visible = true;
			this.playerEnergy.visible = true;
			this.playerLevel.visible = true;
			this.playerXP.visible = true;
			this.playerCredits.visible = true;
			this.playerPhysique.visible = true;
			this.playerReflexes.visible = true;
			this.playerAim.visible = true;
			this.playerIntelligence.visible = true;
			this.playerWillpower.visible = true;
			this.playerLibido.visible = true;
		}
		public function showNPCStats():void {
			this.monsterHP.visible = true;
			this.monsterLust.visible = true;
			this.monsterEnergy.visible = true;
			this.monsterLevel.visible = true;
			this.monsterRace.visible = true;
			this.monsterSex.visible = true;
		}
		public function hideNPCStats():void {
			this.monsterHP.visible = false;
			this.monsterLust.visible = false;
			this.monsterEnergy.visible = false;
			this.monsterLevel.visible = false;
			this.monsterRace.visible = false;
			this.monsterSex.visible = false;
		}
		public function deglow():void 
		{
			trace("playerShields = ", playerShields);
			this.playerShields.clearGlo();
			this.playerHP.clearGlo();
			this.playerLust.clearGlo();
			this.playerEnergy.clearGlo();
			this.playerXP.clearGlo();
			this.playerLevel.clearGlo();
			this.playerCredits.clearGlo();
			this.playerPhysique.clearGlo();
			this.playerReflexes.clearGlo();
			this.playerAim.clearGlo();
			this.playerIntelligence.clearGlo();
			this.playerWillpower.clearGlo();
			this.playerLibido.clearGlo();
			this.monsterHP.clearGlo();
			this.monsterLust.clearGlo();
			this.monsterEnergy.clearGlo();
		}	

		function showBust(arg:int):void {
			//this.leftSideBar.sceneTitle.filters = [glow];
			if(arg == 0) this.leftSideBar.npcBusts.visible = false;
			else {
				this.leftSideBar.sceneTitle.text = this.titsClassPtr.characters[arg].short;
				this.leftSideBar.npcBusts.visible = true;
				if(arg == GLOBAL.RIVAL)
				{
					if(this.titsClassPtr.characters[arg].short == "Jill") 
						this.leftSideBar.npcBusts.gotoAndStop(100);
					else 
						this.leftSideBar.npcBusts.gotoAndStop(arg);
				}
				else 
					this.leftSideBar.npcBusts.gotoAndStop(arg);
				
			}
		}

		//2. DISPLAY STUFF
		//EXAMPLE: setupStatBar(monsterSex,"SEX","Genderless");
		function setupStatBar(arg:MovieClip,title:String = "",value = undefined, max = undefined):void {
			if(title != "" && title is String) arg.masks.labels.text = title;
			if(max is Number && value is Number) {
				arg.bar.width = (value / max) * 180;
				arg.background.x = -1 * (1 - value / max) * 180;
			}
			if(max == undefined) {
				arg.bar.visible = false;
				arg.background.x = -180;
			}
			if(value != undefined) arg.values.text = String(value);
		}

	}
}