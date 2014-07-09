import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.ui.Mouse;

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
		arrayName[i] = arrayName[i].replace(". ","-");
		arrayName[i] = arrayName[i].replace("'","");
		arrayName[i] = arrayName[i].replace(" ","-");
		arrayName[i] = arrayName[i].replace(".","-");

		var itemContainer:MovieClip = new MovieClip();
		itemContainer.buttonMode = true;
		itemContainer.mouseChildren = false;
		itemContainer.champ = arrayName[i];
		itemContainer.filters = [new DropShadowFilter(1)];
		var item:TextField = new TextField();
		item.selectable = false;
		item.defaultTextFormat = formatoCounter;
		item.autoSize = TextFieldAutoSize.LEFT;
		item.text = arrayName[i]+" - "+arrayLane[i];
		item.embedFonts = true;
		item.antiAliasType = AntiAliasType.ADVANCED;
		item.y = 30*i;
		item.x = 100;
		containerCounter.containerInfo.addChild(itemContainer);
		itemContainer.addChild(item);
		
		var imagenItem:UILoader = new UILoader();
		imagenItem.scaleContent = true;
		imagenItem.height = 50;
		imagenItem.source = "http://www.mobafire.com/images/champion/icon/"+arrayName[i].toLowerCase()+".png";
		imagenItem.x = 20;
		imagenItem.y = -15+30*i;
		itemContainer.addChild(imagenItem);
		itemContainer.addEventListener(MouseEvent.CLICK, buscarCounter(itemContainer.champ));
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

		var itemContainer:MovieClip = new MovieClip();
		itemContainer.buttonMode = true;
		itemContainer.mouseChildren = false;
		itemContainer.champ = arrayName[i];
		itemContainer.filters = [new DropShadowFilter(1)];
		var item:TextField = new TextField();
		item.defaultTextFormat = formatoCounter;
		item.selectable = false;
		item.autoSize = TextFieldAutoSize.LEFT;
		item.text = arrayName[i]+" - "+arrayLane[i];
		item.embedFonts = true;
		item.antiAliasType = AntiAliasType.ADVANCED;
		item.y = 30*i;
		item.x = 400;
		containerCounter.containerInfo.addChild(itemContainer);
		itemContainer.addChild(item);
		
		var imagenItem:UILoader = new UILoader();
		imagenItem.scaleContent = true;
		imagenItem.height = 50;
		imagenItem.source = "http://www.mobafire.com/images/champion/icon/"+arrayName[i].toLowerCase()+".png";
		imagenItem.x = 320;
		imagenItem.y = -15+30*i;
		itemContainer.addChild(imagenItem);
		itemContainer.addEventListener(MouseEvent.CLICK, buscarCounter(itemContainer.champ));
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

function buscarCounter(champion:String):Function {
  return function(e:MouseEvent):void {
	champ = champion;
	buscarChamp2(champion);
  };
}

//Agregar carga
function buscarChamp2(champion):void
{
	desMenu();
	cargaAdd();
	
	vaciarClip(containerCounter.containerInfo);
	vaciarClip(containerBuild.champBuild);

	checkInStage(containerBuild);
	checkInStage(containerCounter);
	checkInStage(errorConexion);
	
	containerBuild.mascaraBuild.height = 42;
	containerBuild.abajo_btn.rotation = -90;

	var champLoader:URLLoader = new URLLoader();
	champLoader.load(new URLRequest("http://www.championselect.net/champions/"+champion));
	champLoader.addEventListener(Event.COMPLETE, agregarLoader);
}