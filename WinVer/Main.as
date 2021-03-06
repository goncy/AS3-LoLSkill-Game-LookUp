﻿package 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.events.FocusEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.ProgressEvent;
	import flash.events.IOErrorEvent;
	import fl.transitions.Tween;
	import flash.display.MovieClip;
	import fl.transitions.easing.*;
	import fl.transitions.TweenEvent;
	import flash.events.MouseEvent;
	import flash.net.navigateToURL;
	import flash.geom.Transform;
	import flash.geom.ColorTransform;
	import fl.motion.Color;
	import air.update.ApplicationUpdaterUI;
	import flash.filesystem.File;
	import air.update.events.StatusUpdateEvent;
	import air.update.events.UpdateEvent;
	import flash.events.ErrorEvent;
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.greensock.TweenLite; 
	import com.greensock.plugins.TweenPlugin; 
	import com.greensock.plugins.AutoAlphaPlugin; 

	public class Main extends MovieClip
	{
		//Loader
		public var externalfile:URLRequest = new URLRequest();
		public var textloader:URLLoader = new URLLoader();
		public var pushNot:XML;
		public var notLoader:URLLoader = new URLLoader();
		
		//Shared options
		public var optionsShared:SharedObject = SharedObject.getLocal("Opciones");
		
		public var ping_opt:Boolean = true;
		public var ini_win_opt:Boolean = true;
		public var notif_opt:Boolean = true;
		public var item_opt:Boolean = true;
		public var min_win_opt:Boolean = true;
		public var tips_opt:Boolean = true;
		
		//Strings
		var tituloNot:String = "Bienvenidos";
		var cuerpoNot:String = "No hay nuevas notificaciones";
		var linkNot:String = "";
		var ultimoColor:String;
		
		//Actualizacion
		public var appUpdater:ApplicationUpdaterUI = new ApplicationUpdaterUI;
				
		//Mapa
		public var MapString:String;
		
		//Variables Arrays
		public var arrayChampsFull:Array = new Array();
		public var arrayNombre:Array = new Array();
		public var arrayColor:Array = new Array();
		public var suma:Array = [50,50];
		public var arraySkill:Array = new Array();
		public var arrayChamp:Array = new Array();
		public var arrayDiv:Array = new Array();
		public var arrayWins:Array = new Array();
		public var arrayPm:Array = new Array();
		public var arrayPerc:Array = new Array();
		public var arrayMap:Array = new Array();
		public var arrayMasteries:Array = new Array();
		//Array Stats
		public var arrayGames:Array = new Array();
		public var arrayKills:Array = new Array();
		public var arrayDeaths:Array = new Array();
		public var arrayAssists:Array = new Array();
		public var arrayCs:Array = new Array();
		public var arrayGold:Array = new Array();
		//Variables RegExp
		public var parserColor:RegExp = new RegExp('<div class="gamecard (.*?)">',"s");
		public var parserNombre:RegExp = new RegExp('<div class="summonername"><a href=".*?">(.*?)<\/a>',"s");
		public var parserSkill:RegExp = new RegExp('<div class="skillscore tooltip" title=".*?<b>(.*?)<\/b>',"s");
		public var parserChamp:RegExp = new RegExp('<div class="img" style="background:url\\((.*?)\\)"><\/div>',"s");
		public var parserDiv:RegExp = new RegExp('<div class="rankCurrent tooltip" title=".*?<b>(.*?)[">|<\/b]',"s");
		public var parserWins:RegExp = new RegExp('<div class="wins tooltip" title=".*?">(.*?)<\/div>',"s");
		public var parserPm:RegExp = new RegExp('<div class="premade tooltip".*?src="(.*?)"',"s");
		public var parserMap:RegExp = new RegExp('<div class="map">(.*?)</div>',"s");
		public var parserMasteries:RegExp = new RegExp('"runes tooltip" title="(.*?)"',"s");
		public var parseBreakLine:RegExp = new RegExp('(<br \/>)|(\(click for a detailed breakdown\))|[\(\)]',"g");
		//RegExp Stats
		public var parserGames:RegExp = new RegExp('<td>Games:<\/td>\n<td>(.*?)[<\/td>|<span]',"s");
		public var parserKills:RegExp = new RegExp('<td>Kills:<\/td>\n<td>(.*?)[<\/td>|<span]',"s");
		public var parserDeaths:RegExp = new RegExp('<td>Deaths:<\/td>\n<td>(.*?)[<\/td>|<span]',"s");
		public var parserAssists:RegExp = new RegExp('<td>Assists:<\/td>\n<td>(.*?)[<\/td>|<span]',"s");
		public var parserCs:RegExp = new RegExp('<td>CS:<\/td>\n<td>(.*?)[<\/td>|<span]',"s");
		public var parserGold:RegExp = new RegExp('<td>Gold:<\/td>\n<td>(.*?)[<\/td>|<span]',"s");

		public function Main()
		{
			initTray();
			TweenPlugin.activate([AutoAlphaPlugin]); //activation is permanent in the SWF, so this line only needs to be run once.
			if(optionsShared.data.notif_opt)notLoader.load(new URLRequest("https://raw.githubusercontent.com/goncy/AS3-LoLSkill-Game-LookUp/master/WinVer/notification.xml"));
			configUpdater();
			notLoader.addEventListener(Event.COMPLETE, processXML);
			getChampArray();
			include "pingHandler.as";
		}

		function configUpdater():void
		{
			appUpdater.addEventListener(UpdateEvent.INITIALIZED, onUpdate);
			appUpdater.addEventListener(ErrorEvent.ERROR, onError);
			appUpdater.updateURL = "https://raw.githubusercontent.com/goncy/AS3-LoLSkill-Game-LookUp/master/WinVer/updater.xml";
			appUpdater.delay = 5;
			appUpdater.isCheckForUpdateVisible = false;
			appUpdater.isDownloadUpdateVisible = true;
			appUpdater.isDownloadProgressVisible = true;
			appUpdater.isInstallUpdateVisible = true;
			appUpdater.isFileUpdateVisible = true;
			appUpdater.isUnexpectedErrorVisible = true;
		}
		
		function parseSecond(texto:String):void
		{
			arrayPm = texto.split(parserPm);
			arrayChamp = texto.split(parserChamp);
		}

		function parseAll(texto:String):void
		{
			arrayColor = texto.split(parserColor);
			arrayNombre = texto.split(parserNombre);
			arrayDiv = texto.split(parserDiv);
			arrayWins = texto.split(parserWins);
			arrayPerc = parseSkill(texto);
			arrayMap = texto.split(parserMap);
			//Parse Stats
			arrayGames = texto.split(parserGames);
			arrayKills = texto.split(parserKills);
			arrayDeaths = texto.split(parserDeaths);
			arrayAssists = texto.split(parserAssists);
			arrayCs = texto.split(parserCs);
			arrayGold = texto.split(parserGold);
			//Masteries
			texto = texto.replace(parseBreakLine,"");
			arrayMasteries = texto.split(parserMasteries);

			MapString = arrayMap[1];
			MapString = MapString.replace("&middot;","-");
			MapString = MapString.replace("&middot;","-");
		}

		function parseSkill(texto:String):Array
		{
			arraySkill = texto.split(parserSkill);
			if(arraySkill.length==21){
				for (var i:int=0; i<5; i++)
				{
					var sumaA:String = arraySkill[i * 2 + 1];
					var sumaB:String = arraySkill[i * 2 + 11];
					sumaA = sumaA.replace(",","");
					sumaB = sumaB.replace(",","");
					suma[0] = suma[0] + parseInt(sumaA);
					suma[1] = suma[1] + parseInt(sumaB);
				}
			}if(arraySkill.length==13){
				for (var k:int=0; k<3; k++)
				{
					var sumaATT:String = arraySkill[k * 2 + 1];
					var sumaBTT:String = arraySkill[k * 2 + 7];
					sumaATT = sumaATT.replace(",","");
					sumaBTT = sumaBTT.replace(",","");
					suma[0] = suma[0] + parseInt(sumaATT);
					suma[1] = suma[1] + parseInt(sumaBTT);
				}
			}
			return suma;
		}

		function checkInStage(elemento:MovieClip):void
		{
			if (stage.contains(elemento))
			{
				removeChild(elemento);
			}
		}
		
		function animarFrame(){
			MovieClip(this).alpha = 0;
			TweenLite.to(MovieClip(this), 0.3, {autoAlpha:1});
			//var animacion:Tween = new Tween(this,"alpha",Regular.easeOut,0,1,1,true);
		}
		
		function animar(elemento:MovieClip):void
		{
			elemento.alpha = 0;
			TweenLite.to(elemento, 1, {autoAlpha:1});
		}
		
		function processXML(e:Event):void {
		pushNot = new XML(e.target.data);
		
			if(pushNot.ID[0] == "1")
			{
				dispatchEvent(new Event("Notif"));
				tituloNot = pushNot.TITULO[0];
				cuerpoNot = pushNot.CUERPO[0];
				linkNot = pushNot.LINK[0];
			}
		}
		
		function vaciarClip(clip:MovieClip):void
		{
			//Handler Counter
			if(clip){
				while (clip.numChildren > 0)
				{
					clip.removeChildAt(0);
				}
			}
		}
		
		function onUpdate(event:UpdateEvent):void
		{
			appUpdater.checkNow();
		}
		
		function onError(event:ErrorEvent):void
		{
			trace(event);
		}
		
		function getChampArray():void
		{
			var urlRequestChamp:URLRequest  = new URLRequest("https://las.api.pvp.net/api/lol/static-data/las/v1.2/champion?api_key=79cec077-7792-4ac8-90cc-a43d5cff69a6");
			var urlLoaderChamp:URLLoader = new URLLoader();

			urlLoaderChamp.addEventListener(Event.COMPLETE, completeLoaderHandlerChamp);
			urlLoaderChamp.load(urlRequestChamp);

			function completeLoaderHandlerChamp(event:Event):void {
				var loader:URLLoader = URLLoader(event.target);
				var datas:Object = JSON.parse(loader.data);
				for (var champ:String in datas.data)
				{
					if(champ=="MonkeyKing")champ="Wukong";
					arrayChampsFull.push(champ);
				} 
				arrayChampsFull.sort();
			}
		}
	}
}