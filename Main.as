package 
{

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.ProgressEvent;
	import flash.events.IOErrorEvent;
	import fl.transitions.Tween;
	import flash.display.MovieClip;
	import fl.transitions.easing.*;
	import com.greensock.*;
	import com.greensock.easing.*;
	import fl.transitions.TweenEvent;
	import flash.events.MouseEvent;
	import flash.net.navigateToURL;

	public class Main extends MovieClip
	{
		//Loader
		public var externalfile:URLRequest = new URLRequest();
		public var textloader:URLLoader = new URLLoader();
		
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

		//Variables RegExp
		public var parserNombre:RegExp = new RegExp('<div class="summonername"><a href=".*?">(.*?)<\/a>',"s");
		public var parserSkill:RegExp = new RegExp('<div class="skillscore tiptip" title=".*?<b>(.*?)<\/b>',"s");
		public var parserChamp:RegExp = new RegExp('<a class="tiptip" href="champion.*?url\\((.*?)\\)"',"s");
		public var parserDiv:RegExp = new RegExp('<div class="rankCurrent tiptip" title=".*?<b>(.*?)[">|<\/b]',"s");
		public var parserWins:RegExp = new RegExp('<div class="wins tiptip" title=".*?">(.*?)<\/div>',"s");
		public var parserPm:RegExp = new RegExp('<div class="premade tiptip".*?src="(.*?)"',"s");
		public var parserMap:RegExp = new RegExp('<div class="map">(.*?)</div>',"s");

		public function Main()
		{
			// constructor code
		}

		function parseAll(texto:String):void
		{
			arrayNombre = texto.split(parserNombre);
			arrayChamp = texto.split(parserChamp);
			arrayDiv = texto.split(parserDiv);
			arrayWins = texto.split(parserWins);
			arrayPm = texto.split(parserPm);
//			arrayPerc = parseSkill(texto);
			arrayMap = texto.split(parserMap);

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
			TweenLite.to(elemento, 1, {autoAlpha:1});
		}
	}
}