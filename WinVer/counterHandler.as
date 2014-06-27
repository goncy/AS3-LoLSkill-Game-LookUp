import flash.display.MovieClip;

containerCounter.x = 115;
containerCounter.y = 180;

//Parse counters
function parseCountersWeak(texto:String):void
{
	var parserName:RegExp = new RegExp("<div class='name'>(.*?)<\/div>", "g");
	var parserLane:RegExp = new RegExp("<div class='lane .*?'>(.*?)<\/div>", "g");

	var arrayName:Array = new Array();
	var arrayLane:Array = new Array();

	arrayName = texto.split(parserName);
	arrayLane = texto.split(parserLane);

	var tipoUbuntu = new Ubuntu();
	var formatoCounter:TextFormat = new TextFormat();
	formatoCounter.size = 15;
	formatoCounter.font = tipoUbuntu.fontName;
	formatoCounter.color = 0xFFFFFF;
	
	for (var i:int = 1; i < 17; i+=2)
	{
		arrayName[i] = arrayName[i].replace("'","");
		arrayName[i] = arrayName[i].replace(" ","-");
		arrayName[i] = arrayName[i].replace(".","-");

		var item:TextField = new TextField();
		item.selectable = false;
		item.defaultTextFormat = formatoCounter;
		item.autoSize = TextFieldAutoSize.LEFT;
		item.text = arrayName[i]+" - "+arrayLane[i];
		item.embedFonts = true;
		item.antiAliasType = AntiAliasType.ADVANCED;
		item.y = 30*i;
		item.x = 100;
		containerCounter.containerInfo.addChild(item);
		
		var imagenItem:UILoader = new UILoader();
		imagenItem.scaleContent = true;
		imagenItem.height = 50;
		imagenItem.source = "http://www.mobafire.com/images/champion/icon/"+arrayName[i].toLowerCase()+".png";
		imagenItem.x = 20;
		imagenItem.y = -15+30*i;
		containerCounter.containerInfo.addChild(imagenItem);
	}
}

//Parse counters
function parseCountersStrong(texto:String):void
{
	var parserName:RegExp = new RegExp("<div class='name'>(.*?)<\/div>", "g");
	var parserLane:RegExp = new RegExp("<div class='lane .*?'>(.*?)<\/div>", "g");

	var arrayName:Array = new Array();
	var arrayLane:Array = new Array();

	arrayName = texto.split(parserName);
	arrayLane = texto.split(parserLane);

	var tipoUbuntu = new Ubuntu();
	var formatoCounter:TextFormat = new TextFormat();
	formatoCounter.size = 15;
	formatoCounter.font = tipoUbuntu.fontName;
	formatoCounter.color = 0xFFFFFF;
	
	for (var i:int = 1; i<17; i+=2)
	{
		arrayName[i] = arrayName[i].replace("'","");
		arrayName[i] = arrayName[i].replace(". ","-");
		arrayName[i] = arrayName[i].replace(" ","-");
		arrayName[i] = arrayName[i].replace(".","-");

		var item:TextField = new TextField();
		item.defaultTextFormat = formatoCounter;
		item.selectable = false;
		item.autoSize = TextFieldAutoSize.LEFT;
		item.text = arrayName[i]+" - "+arrayLane[i];
		item.embedFonts = true;
		item.antiAliasType = AntiAliasType.ADVANCED;
		item.y = 30*i;
		item.x = 400;
		containerCounter.containerInfo.addChild(item);
		
		var imagenItem:UILoader = new UILoader();
		imagenItem.scaleContent = true;
		imagenItem.height = 50;
		imagenItem.source = "http://www.mobafire.com/images/champion/icon/"+arrayName[i].toLowerCase()+".png";
		imagenItem.x = 320;
		imagenItem.y = -15+30*i;
		containerCounter.containerInfo.addChild(imagenItem);
	}
}

function divideCounter(e:Event):void
{
	//Divide Counters
	var arrayCounter:Array = new Array();
	var parserCounter:RegExp = new RegExp("<div class='weak-block'>(.*?)<div class='strong'>","sg");
	arrayCounter = e.target.data.split(parserCounter);

	parseCountersWeak(arrayCounter[1]);
	parseCountersStrong(arrayCounter[2]);
	
	animar(containerCounter);
	addChild(containerCounter);
}