import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.events.Event;
import fl.containers.UILoader;
import com.greensock.TweenLite;
import flash.display.MovieClip;

var urlRequest:URLRequest  = new URLRequest("https://las.api.pvp.net/api/lol/las/v1.2/champion?freeToPlay=true&api_key=79cec077-7792-4ac8-90cc-a43d5cff69a6");
var posicion:int = 1;
var urlLoader:URLLoader = new URLLoader();
var contenedorRotacion:MovieClip = new MovieClip();
urlLoader.addEventListener(Event.COMPLETE, completeLoaderHandler);

try{
	urlLoader.load(urlRequest);
} catch (error:Error) {
	trace("Cannot load : " + error.message);
}

function completeLoaderHandler(event:Event):void {
    var loader:URLLoader = URLLoader(event.target);

    var data:Object = JSON.parse(loader.data);
	for (var i=0;i<data.champions.length;i++){
		champName(data.champions[i].id);
	}
}

function champName(id:String):void
{
	var urlRequest:URLRequest  = new URLRequest("https://las.api.pvp.net/api/lol/static-data/las/v1.2/champion/"+id+"?api_key=79cec077-7792-4ac8-90cc-a43d5cff69a6");
	
	var urlLoader:URLLoader = new URLLoader();
	urlLoader.addEventListener(Event.COMPLETE, completeFreeChampHandler);
	
	try{
		urlLoader.load(urlRequest);
	} catch (error:Error) {
		trace("Cannot load : " + error.message);
	}
	
	function completeFreeChampHandler(event:Event):void {
		var loader:URLLoader = URLLoader(event.target);
	
		var data:Object = JSON.parse(loader.data);
		
		var contenedorUI:MovieClip = new MovieClip();
		var imagenItem:UILoader = new UILoader();
		imagenItem.height = 200;
		
		if(posicion < 7)
		{
			contenedorUI.x = (posicion*100)-95;
			contenedorUI.y = -3;
		}else{
			contenedorUI.x = (posicion*100)-(695);
			contenedorUI.y = 177;
		}
		posicion++;
		imagenItem.scaleContent = true;
		imagenItem.source = "http://ddragon.leagueoflegends.com/cdn/img/champion/loading/"+firstToUpper(data.name)+"_0.jpg";
		contenedorUI.buttonMode = true;
		contenedorUI.mouseChildren = false;
		contenedorUI.addChild(imagenItem);
		animar(contenedorUI);
		contenedorRotacion.addChild(contenedorUI);
		addChild(contenedorRotacion);
	}
}

function firstToUpper(word):String {
	word = word.replace("'","");
	word = word.replace("’","");
	word = word.replace(". ","");
	word = word.replace(" ","");
	word = word.replace("ChoGath","Chogath");
	word = word.replace("KhaZix","Khazix");
	word = word.replace("LeBlanc","Leblanc");
	word = word.replace("Miss Fortune","MissFortune");
//	var firstLetter:String = word.substring(1, 0);
//	var restOfWord:String = word.substring(1);
//	return (firstLetter.toUpperCase()+restOfWord.toLowerCase());
	return word;
}

function animar(elemento:MovieClip):void
{
	elemento.alpha = 0;
	TweenLite.to(elemento, 1, {autoAlpha:1});
}