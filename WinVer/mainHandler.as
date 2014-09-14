//Summoner
var nombre:String;
var region:String = "LAS";

textloader.addEventListener(ProgressEvent.PROGRESS, deshabilitarBoton);
textloader.addEventListener(Event.COMPLETE, agregar);
textloader.addEventListener(IOErrorEvent.IO_ERROR, errorConex);
buscador.bus_btn.addEventListener(MouseEvent.CLICK, animarBoton);
buscador.sumname.addEventListener(FocusEvent.FOCUS_IN, glowin);

if(currentFrame == 1)
{
	buscador.sumname.addEventListener(KeyboardEvent.KEY_DOWN, pressEnter);
}
//Animar boton
function animarBoton(MouseEvent):void
{
	desMenu();
	TweenLite.to(buscador, 0.7, {x:14, y:17, onComplete:agregarCarga});
}

//Cargas
function agregarCarga():void
{
	cargaAdd();
	buscar();
}

//Buscar
function buscar():void
{
buscarConfig();

nombre = buscador.sumname.text;
region = buscador.region_mc.combo.selectedItem.data;

//SO
suminfoShared.data.sumname = nombre;
suminfoShared.data.sumreg = buscador.region_mc.combo.selectedIndex;
suminfoShared.flush ();

externalfile.url = "http://www.lolskill.net/game/"+region+"/"+nombre;
textloader.load(externalfile);

errorGame.errorLink.text = externalfile.url;
}

//Config buscar
function buscarConfig():void
{
	vaciarClip(container_mc);
	checkInStage(container_mc);
	checkInStage(errorGame);
	checkInStage(errorConexion);
	checkInStage(containersum);
}

//Deshabilitar boton
function deshabilitarBoton(ProgressEvent):void
{
	buscador.bus_btn.removeEventListener(MouseEvent.CLICK, animarBoton);
	buscador.bus_in_btn.removeEventListener(MouseEvent.CLICK, animarBotonSum);
}

function agregar(event:Event):void
{	
	//URL a String
    var textoCargado:String = textloader.data;
	//Event boton
	buscador.bus_btn.addEventListener(MouseEvent.CLICK, animarBoton);
	buscador.bus_in_btn.addEventListener(MouseEvent.CLICK, animarBotonSum);
	habMenu();
	
	//Agregar
	//Parsear secundario
	parseSecond(textoCargado);
	try {
		//Parse URL
		parseAll(textoCargado);
		//Popular contenedor
		populate();
		//Animar boton
		animar(container_mc);
		//Borrar Excedentes
		checkInStage(carga);
		//Agregar Container
		addChild(container_mc);
	}catch(error:Error){
		//Animar Error
		animar(errorGame);
		//Borrar Carga
		checkInStage(carga);
		//Agregar Error
		addChild(errorGame);
		//Trace Error
		trace(error.getStackTrace());
	}
}

function populate():void
{
	for (var i:int=1; i < arrayChamp.length; i+=2)
	{
		var plaza:plazaContainer = new plazaContainer();
		plaza.filters = [getFilter(arrayColor[i])];
		plaza.simg.source = arrayChamp[i];
		plaza.sum.filters = [getFilter(arrayColor[i])];
		plaza.sum.text = arrayNombre[i];
		plaza.sskill.text = arraySkill[i];
		plaza.sdiv.htmlText = arrayDiv[i];
		plaza.swin.htmlText = arrayWins[i];
		plaza.spm.source = arrayPm[i];
		plaza.sstats.text = arrayGames[i]+"\n"+arrayKills[i]+"\n"+arrayDeaths[i]+"\n"+arrayAssists[i]+"\n"+arrayCs[i]+"\n"+arrayGold[i];
		plaza.smaso.masteries.htmlText = arrayMasteries[i];
		plaza.smasob.addEventListener(MouseEvent.ROLL_OVER, handleMasteriesIn);
		plaza.smasob.addEventListener(MouseEvent.ROLL_OUT, handleMasteriesOut);
		plaza.bs.addEventListener(MouseEvent.CLICK, bssumoner);
		plaza.bs.addEventListener(MouseEvent.MOUSE_MOVE, toolTip("Buscar infromacion del invocador"));
		var parserChampName:RegExp = new RegExp('.*?img/skins/175/x(.*?)_.*?',"s");
		var champName:String = arrayChamp[i].split(parserChampName)[1];
		plaza.smaso.addEventListener(MouseEvent.MOUSE_MOVE, toolTip(upperCase(champName)));

		if(i < arrayChamp.length/2)
		{
			plaza.x = (77.9*i)-65;
			plaza.y = 65;
		}else{
			plaza.x = (155.8*i/2)-(container_mc.width+72);
			plaza.y = 405;
		}
		container_mc.addChild(plaza);
	}
	//Mapa
	mapaBarra.game_map.htmlText = MapString;
	//Porcentajes
	coloresPerc();
	mapaBarra.t1per.text = String(Math.round((arrayPerc[0]/(arrayPerc[0]+arrayPerc[1]))*10000)/100)+"%";
	mapaBarra.t2per.text = String(Math.round((arrayPerc[1]/(arrayPerc[0]+arrayPerc[1]))*10000)/100)+"%";
	container_mc.addChild(mapaBarra);
}


//Extras
function coloresPerc():void
{
	if(ultimoColor == "purple")
	{
		mapaBarra.t2per.textColor = 0x9900CC;
		mapaBarra.t1per.textColor = 0x3399FF;
	}if(ultimoColor == "blue"){
		mapaBarra.t1per.textColor = 0x9900CC;
		mapaBarra.t2per.textColor = 0x3399FF;
	}
}

function glowin(FocusEvent):void
{
	//Glow in effect
	buscador.sumname.text = "";
	TweenMax.to(buscador.bgtext, 0.5, {glowFilter:{color:0x1E7FD9, alpha:1, blurX:5, blurY:5, strength:2}});
}

//Enter handler
function pressEnter(evt:KeyboardEvent):void 
{
   //I also shortened down this code
	if (evt.keyCode == Keyboard.ENTER)
	{
	   animarBoton(MouseEvent.CLICK);
	}
}

//First to capital
function upperCase(str:String) : String {
 var firstChar:String = str.substr(0, 1); 
 var restOfString:String = str.substr(1, str.length); 
    
 return firstChar.toUpperCase()+restOfString.toLowerCase(); 
}