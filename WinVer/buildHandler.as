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
	containerBuild.champImg.source = "http://www.mobafire.com/images/champion/icon/" + champ.toLowerCase() + ".png";
	//Name
	containerBuild.champName.text = arrayChampStat[1];

	animar(containerBuild);
	addChild(containerBuild);
}

//Parse items
function parseItems(texto:String, dist:Number):void
{
	var arrayItems:Array = new Array();
	var parserItems:RegExp = new RegExp('<img src="(.*?)" \/>',"s");
	arrayItems = texto.split(parserItems);
	
	for (var i:int = 1; i < arrayItems.length-1; i+=2)
	{
		uiNuevo(28, arrayItems[i], (20*i)-36, dist, containerBuild.champBuild);
	}
}

function parseBuildName(arrayNameBuild:Array):void
{
	for (var i:int = 1; i < arrayNameBuild.length; i+=2)
	{
		textoNuevo(arrayNameBuild[i], -123, 20*i, containerBuild.champBuild, formatoChico);
	}
}
