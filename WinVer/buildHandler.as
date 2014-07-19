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
		textoNuevo(arrayNameBuild[i], -123, 20*i, containerBuild.champBuild, formatoChico, 140);
	}
}

function itemInfo(e:MouseEvent):void
{
    var urlRequest:URLRequest  = new URLRequest("https://las.api.pvp.net/api/lol/static-data/las/v1.2/item/"+e.target.idItem+"?locale=es_ES&itemData=all&api_key=79cec077-7792-4ac8-90cc-a43d5cff69a6");

    var urlLoader:URLLoader = new URLLoader();
    urlLoader.addEventListener(Event.COMPLETE, completeHandler);

    try{
        urlLoader.load(urlRequest);
    } catch (error:Error) {
        trace("Cannot load : " + error.message);
    }
}

function completeHandler(event:Event):void {
    var loader:URLLoader = URLLoader(event.target);

    var data:Object = JSON.parse(loader.data);
    trace("The answer is " + data.name+" ; "+data.description);
    //All fields from JSON are accessible by theit property names here/
	placaItem(data.name+"\n"+data.description);
}

function placaItem(texto:String):void
{
	var contenedorPlaca:MovieClip = new MovieClip();
	contenedorPlaca.x = stage.mouseX-10;
	contenedorPlaca.y = stage.mouseY-10;
	contenedorPlaca.filters = [new DropShadowFilter(1)];
	
	var tfield:TextField = new TextField();
	tfield.defaultTextFormat = formatoItem;
	tfield.selectable = false;
	tfield.multiline = true;
	tfield.wordWrap = true;
	tfield.autoSize = TextFieldAutoSize.LEFT;
	tfield.width = 250;
	tfield.height = 210;
	tfield.x = 10;
	tfield.y = 10;
	tfield.antiAliasType = AntiAliasType.ADVANCED;
	tfield.sharpness = 1;
    tfield.thickness = 100;
	tfield.htmlText = texto;
	tfield.filters = [new DropShadowFilter(1),new BevelFilter(1)];

	var rectangle:Shape = new Shape; // initializing the variable named rectangle
	rectangle.graphics.beginFill(0x666666, 0.9); // choosing the colour for the fill, here it is red
	rectangle.graphics.drawRect(0, 0, tfield.width+20,tfield.height+40); // (x spacing, y spacing, width, height)
	rectangle.graphics.endFill(); // not always needed but I like to put it in to end the fill
	contenedorPlaca.addChild(rectangle); // adds the rectangle to the stage
	contenedorPlaca.addChild(tfield);
	if(stage.mouseX+contenedorPlaca.width > stage.width)contenedorPlaca.x=contenedorPlaca.x-contenedorPlaca.width+20;
	contenedorPlaca.addEventListener(MouseEvent.ROLL_OUT, eliminarPlaca);
	animar(contenedorPlaca);
	addChild(contenedorPlaca);
	if(contenedorPlaca.y>330)removeChild(contenedorPlaca);
}

function eliminarPlaca(e:MouseEvent):void
{
	trace(e.target.name);
	e.target.parent.removeChild(e.target);
}