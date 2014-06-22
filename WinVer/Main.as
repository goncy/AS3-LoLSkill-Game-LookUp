package 
{
	import flash.display.MovieClip;
	import flash.events.Event;
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
		
		//Booleans
		var hayNot:Boolean = false;
		
		//Strings
		var tituloNot:String = "Bienvenidos";
		var cuerpoNot:String = "No hay nuevas notificaciones";
		
		//Mapa
		public var MapString:String;
		
		//Variables Arrays
		public var arrayNombre:Array = new Array();
		public var suma:Array = [0,0];
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
			TweenPlugin.activate([AutoAlphaPlugin]); //activation is permanent in the SWF, so this line only needs to be run once.
			notLoader.load(new URLRequest("https://raw.githubusercontent.com/goncy/AS3-LoLSkill-Game-LookUp/master/WinVer/notification.xml"));
			notLoader.addEventListener(Event.COMPLETE, processXML);
		}

		function parseAll(texto:String):void
		{
			arrayChamp = texto.split(parserChamp);
			arrayNombre = texto.split(parserNombre);
			arrayDiv = texto.split(parserDiv);
			arrayWins = texto.split(parserWins);
			arrayPm = texto.split(parserPm);
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
			for (var i:int=0; i<5; i++)
			{
				var sumaA:String = arraySkill[i * 2 + 1];
				var sumaB:String = arraySkill[i * 2 + 11];
				sumaA = sumaA.replace(",","");
				sumaB = sumaB.replace(",","");
				suma[0] = suma[0] + parseInt(sumaA);
				suma[1] = suma[1] + parseInt(sumaB);
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
			var animacion:Tween = new Tween(this,"alpha",Regular.easeOut,0,1,1,true);
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
				hayNot = true;
				tituloNot = pushNot.TITULO[0];
				cuerpoNot = pushNot.CUERPO[0];
			}
		}
	}
}