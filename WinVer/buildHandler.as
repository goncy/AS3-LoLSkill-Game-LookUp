import fl.containers.UILoader;
import flash.display.MovieClip;
import fl.data.DataProvider;
import flash.text.TextFormat;
import flash.text.Font;
import flash.text.AntiAliasType;
import flash.text.TextFieldAutoSize;
import flash.events.Event;
import flash.display.Shape;
import flash.filters.*;

function divideBuild(e:Event):void
{
	//Vars;
	var arrayBuilder:Array = new Array();
	var parserBuild:RegExp = new RegExp("<div class='items'>(.*?)<div class='summoners'>","sg");
	
	//Var name
	var arrayNameBuild:Array = new Array();
	var parserNameBuild:RegExp = new RegExp("<div class='player'>(.*?)<\/div>","s");
	
	arrayNameBuild = e.target.data.split(parserNameBuild);
	
	//Handle
	arrayBuilder = e.target.data.split(parserBuild);
	
	var rectangle:Shape = new Shape; // initializing the variable named rectangle
	rectangle.graphics.beginFill(0x4f4f4f); // choosing the colour for the fill, here it is red
	rectangle.graphics.drawRect(-125, 57, 420,(arrayBuilder.length*20)-60); // (x spacing, y spacing, width, height)
	rectangle.graphics.endFill(); // not always needed but I like to put it in to end the fill
	
	var rectangleIn:Shape = new Shape; // initializing the variable named rectangle
	rectangleIn.graphics.beginFill(0x666666); // choosing the colour for the fill, here it is red
	rectangleIn.graphics.drawRect(-125, 57, 137,(arrayBuilder.length*20)-60); // (x spacing, y spacing, width, height)
	rectangleIn.graphics.endFill(); // not always needed but I like to put it in to end the fill

	containerBuild.champBuild.addChild(rectangle);
	containerBuild.champBuild.addChild(rectangleIn);
	
	//Parse
	for (var i:int = 1; i < arrayBuilder.length; i+=2)
	{
		parseItems(arrayBuilder[i], 20*i);
	}
	
	parseBuildName(arrayNameBuild);
		
	//Champ Stats
	var arrayChampStat:Array = new Array();
	var parserChampStat:RegExp = new RegExp("<div class='name'>(.*?)<\/div>","sg");
	arrayChampStat = e.target.data.split(parserChampStat);
	
	//Image
	if(champ=="Wukong")containerBuild.champImg.source = "http://ddragon.leagueoflegends.com/cdn/4.15.1/img/champion/MonkeyKing.png";
	else containerBuild.champImg.source = "http://ddragon.leagueoflegends.com/cdn/4.15.1/img/champion/"+champ+".png";
	//Name
	containerBuild.champName.text = arrayChampStat[1];

	animar(containerBuild);
	addChild(containerBuild);
}

//Parse items
function parseItems(texto:String, dist:Number):void
{
	var arrayItems:Array = new Array();
	var arrayItemsId:Array = new Array();
	var parserItems:RegExp = new RegExp('<img src="(.*?)" \/>',"s");
	var parserItemsId:RegExp = new RegExp('http://www.probuilds.net/resources/img/items/28/(.*?).png',"s");
	
	arrayItemsId = texto.split(parserItemsId);
	arrayItems = texto.split(parserItems);
	
	for (var i:int = 1; i < arrayItems.length-1; i+=2)
	{
		arrayItemsId[i] = arrayItemsId[i].replace("/EmptyIcon","0000");
		arrayItemsId[i] = arrayItemsId[i].replace("3350","3340");
		uiNuevo(28, arrayItems[i], (20*i)-36, dist, containerBuild.champBuild, arrayItemsId[i]);
	}
}

function parseBuildName(arrayNameBuild:Array):void
{
	for (var i:int = 1; i < arrayNameBuild.length; i+=2)
	{
		textoNuevo(arrayNameBuild[i], -123, (20*i)+5, containerBuild.champBuild, formatoChico, 140);
	}
}

function itemInfo(e:MouseEvent):void
{
    if(tipContainer.veces==0){
		var urlRequest:URLRequest  = new URLRequest("https://las.api.pvp.net/api/lol/static-data/las/v1.2/item/"+e.target.idItem+"?locale=es_ES&itemData=all&api_key=79cec077-7792-4ac8-90cc-a43d5cff69a6");
		tipContainer.veces = 1;
		var urlLoader:URLLoader = new URLLoader();
		urlLoader.addEventListener(Event.COMPLETE, completeHandler(e.target));
	
		try{
			urlLoader.load(urlRequest);
		} catch (error:Error) {
			trace("Cannot load : " + error.message);
		}
	}
}

function completeHandler(target:Object):Function {
    return function(event:Event):void
	{
		var loader:URLLoader = URLLoader(event.target);
	
		var data:Object = JSON.parse(loader.data);
		trace("The answer is " + data.name+" ; "+data.description);
		//All fields from JSON are accessible by theit property names here/
		tipContainer.tip = "";
		tipContainer.tip = data.name+"\n"+data.description;
		placaItem(tipContainer.tip, target);
	}
}