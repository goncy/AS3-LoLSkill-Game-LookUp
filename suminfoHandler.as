import flash.events.Event;
import flash.display.MovieClip;
import flash.events.IOErrorEvent;
import flash.events.MouseEvent;
import flash.text.TextFormatAlign;
import flash.media.StageWebView;
import flash.geom.Rectangle;

//Config
var summonerLoader:URLLoader = new URLLoader();

var containersum:containerSum = new containerSum();
containersum.x = stage.stageWidth / 2;
containersum.y = stage.stageHeight / 2;

summonerLoader.addEventListener(Event.COMPLETE, agregarLoaderSum);
summonerLoader.addEventListener(IOErrorEvent.IO_ERROR, errorConex);
buscador.bus_in_btn.addEventListener(MouseEvent.CLICK, animarBotonSum);
summonerLoader.addEventListener(ProgressEvent.PROGRESS, deshabilitarBoton);

//Animar boton
function animarBotonSum(MouseEvent):void
{
	desMenu();
	TweenLite.to(buscador, 0.7, {x:14, y:17, onComplete:agregarCargaSum});
}

//Cargas
function agregarCargaSum():void
{
	cargaAdd();
	try{
	buscarSum();
	}catch(e:Error){
	trace(e.getStackTrace());
	errorConex(IOErrorEvent);
	}
}

function buscarSum():void
{
	buscarConfig();
	
	containersum = new containerSum();
	containersum.x = stage.stageWidth / 2;
	containersum.y = stage.stageHeight / 2;

	nombre = buscador.sumname.text;
	region = buscador.region_mc.combo.selectedItem.data;

	//SO
	suminfoShared.data.sumname = nombre;
	suminfoShared.data.sumreg = buscador.region_mc.combo.selectedIndex;
	suminfoShared.flush();

	summonerLoader.load(new URLRequest("http://www.lolskill.net/summoner/"+region+"/"+nombre));
}

function agregarLoaderSum(e:Event):void
{
	//Event boton
	buscador.bus_in_btn.addEventListener(MouseEvent.CLICK, animarBotonSum);
	buscador.bus_btn.addEventListener(MouseEvent.CLICK, animarBoton);
	habMenu();

	panelIzquierda(e);

	var arrayChampInfo:Array = new Array();
	var parserChampInfo:RegExp = new RegExp('<table class="skinned" id="championsTable">(.*?)<\/table>',"s");
	var parserChamps:RegExp = new RegExp('<tr>(.*?)<\/tr>',"s");
	
	var parserSumName:RegExp = new RegExp('<div class="name">(.*?)<\/div>',"g");
	var parserSumRealm:RegExp = new RegExp('<div class="realm">(.*?)<\/div>',"g");
	containersum.sumName.text = e.target.data.split(parserSumName)[1];
	containersum.sumRealm.htmlText = e.target.data.split(parserSumRealm)[1];
		
	try{
	arrayChampInfo = e.target.data.split(parserChampInfo);
	arrayChampInfo = arrayChampInfo[1].split(parserChamps);

	champHistory(arrayChampInfo);
	}catch(error:Error){
		textoNuevo("No hay partidas en ranked", -40, -20, containersum, formato, 400);
		textoNuevo("No hay información disponible", -440, 50, containersum, formato, 400);
	}
	animar(containersum);
	addChild(containersum);
	checkInStage(carga);
	checkInStage(errorConexion);
}

function champHistory(arrayChampInfo:Array):void
{
	var cabecera:Cabecera = new Cabecera();
	cabecera.x = -75;
	cabecera.y = -145;
	containersum.addChild(cabecera);

	for (var i:int = 3; i<arrayChampInfo.length && i<28; i+=2)
	{
		var parserChamps2:RegExp = new RegExp('<b>(.*?)<\/b>',"s");
		var arrayChampion:Array = new Array();
		arrayChampion = arrayChampInfo[i].split(parserChamps2);
		arrayChampion[9] = arrayChampion[9].replace(" better"," +");
		arrayChampion[9] = arrayChampion[9].replace(" worse"," -");

		arrayChampion[2] = arrayChampion[2].replace(" with ","");
		arrayChampion[2] = arrayChampion[2].replace("<br><br>Performance: ","");

		crearChampStat(arrayChampion, i);
	}
}

//Panel izquierdo
function panelIzquierda(e:Event):void
{
	var arraySumInfo:Array = new Array();
	var parserSumInfo:RegExp = new RegExp('<div class="body">(.*?)<\/div>',"s");
	arraySumInfo = e.target.data.split(parserSumInfo);

	//Split info
	var arrayInfoSplit:Array = new Array();
	var parserInfoSplit:RegExp = new RegExp('<p.*?>(.*?)<\/p>',"s");

	arraySumInfo[1] = arraySumInfo[1].replace("&ndash;","-");
	arrayInfoSplit = arraySumInfo[1].split(parserInfoSplit);

	containersum.division.text = arrayInfoSplit[1];

	for (var i:int = 3; i < arrayInfoSplit.length; i+=2)
	{
		textoNuevo(arrayInfoSplit[i], -440, (10*i)-35, containersum, formato, 400);
	}
}

function crearChampStat(arrayChampion:Array, i:int):void
{
	var champStat:ChampStat = new ChampStat();
	champStat.x = -75;
	champStat.y = (10 * i) - 150;
	champStat.champ.text = arrayChampion[2];
	champStat.ss.text = arrayChampion[1];
	champStat.perf.text = arrayChampion[9];
	champStat.games.text = arrayChampion[11];
	champStat.ktext.text = arrayChampion[13];
	champStat.dtext.text = arrayChampion[17];
	champStat.atext.text = arrayChampion[21];
	champStat.cs.text = arrayChampion[25];
	champStat.gold.text = arrayChampion[29];
	containersum.addChild(champStat);
}