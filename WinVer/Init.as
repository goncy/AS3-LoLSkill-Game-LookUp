import flash.events.MouseEvent;
import flash.net.SharedObject;
import flash.events.IOErrorEvent;
import flash.utils.Timer;
import flash.events.TimerEvent;
import flash.display.MovieClip;
import flash.events.UncaughtErrorEvent;
import flash.filters.GlowFilter;
import flash.ui.Mouse;
import flash.events.NativeWindowDisplayStateEvent;
import flash.display.BitmapData;
import flash.display.Loader;
import flash.display.NativeMenu;
import flash.display.NativeMenuItem;
import flash.desktop.NativeApplication;
import flash.desktop.SystemTrayIcon;
import flash.display.NativeWindowDisplayState;

//Stop
stop();

//Texto;
var ubuntu = new Ubuntu();
var helve = new Helve();

//Cargas
var cargas:int = 0;

var formato:TextFormat = new TextFormat();
formato.size = 15;
formato.font = ubuntu.fontName;
formato.color = 0xFFFFFF;
formato.align = TextFormatAlign.CENTER;

var formatoLeft:TextFormat = new TextFormat();
formatoLeft.size = 15;
formatoLeft.font = ubuntu.fontName;
formatoLeft.color = 0xFFFFFF;
formatoLeft.align = TextFormatAlign.LEFT;

var formatoChico:TextFormat = new TextFormat();
formatoChico.size = 14;
formatoChico.font = ubuntu.fontName;
formatoChico.color = 0xFFFFFF;
formatoChico.align = TextFormatAlign.LEFT;

var formatoItem:TextFormat = new TextFormat();
formatoItem.size = 14;
formatoItem.color = 0xFFFFFF;
formatoItem.font = helve.fontName;

//Mensajes
var carga:Cargador = new Cargador();
var errorGame:ErrorGame = new ErrorGame();
var errorConexion:errorApi = new errorApi();
var mapaBarra:Mapa = new Mapa();

//Containers
var containerCounter:containerCounterMc = new containerCounterMc();
var containerBuild:buildContainer = new buildContainer();
var tipContainer:MovieClip = new MovieClip();
tipContainer.veces = 0;

//SharedObject
var suminfoShared:SharedObject = SharedObject.getLocal("summoner");
if (!suminfoShared.data.sumname) {
buscador.sumname.text = "";}else{
buscador.sumname.text = suminfoShared.data.sumname;
buscador.region_mc.combo.selectedIndex = suminfoShared.data.sumreg;
}

//SharedObject Options
if(optionsShared.data.ping_opt)ping_opt = optionsShared.data.ping_opt;
if(optionsShared.data.ini_win_opt)ini_win_opt = optionsShared.data.ini_win_opt;
if(optionsShared.data.notif_opt)notif_opt = optionsShared.data.notif_opt;
if(optionsShared.data.item_opt)item_opt = optionsShared.data.item_opt;
if(optionsShared.data.min_win_opt)min_win_opt = optionsShared.data.min_win_opt;
if(optionsShared.data.tips_opt)tips_opt = optionsShared.data.tips_opt;

//Declaraciones
carga.x = stage.stageWidth /2;
carga.y = stage.stageHeight / 2;

errorGame.x = stage.stageWidth /2;
errorGame.y = stage.stageHeight / 2;

errorConexion.x = stage.stageWidth /2;
errorConexion.y = stage.stageHeight / 2;

mapaBarra.y = 349.85;
mapaBarra.x = 12.60;

//Initers
checkInStage(container_mc);
notifBtn.buttonMode = true;

//Listeners
notifBtn.addEventListener(MouseEvent.CLICK, notifframe);
busqueda.addEventListener(MouseEvent.CLICK, busquedaframe);
buildsBtn.addEventListener(MouseEvent.CLICK, buildsframe);
notifBtn.addEventListener(MouseEvent.MOUSE_MOVE, brightOn);
notifBtn.addEventListener(MouseEvent.MOUSE_OUT, brightOff);
busqueda.addEventListener(MouseEvent.MOUSE_MOVE, toolTip("Busqueda de partidas e informacion de invocador"));
buildsBtn.addEventListener(MouseEvent.MOUSE_MOVE, toolTip("Busqueda de builds y Counters"));

addEventListener("Notif", hayNotif);

//Funcion Notificacion
function notifframe(MouseEvent):void
{
	checkInStage(errorGame);
	checkInStage(carga);
	checkInStage(errorConexion);
	checkInStage(container_mc);
	checkInStage(containerCounter);
	checkInStage(containerBuild);
	checkInStage(containersum);
	vaciarClip(tipContainer);
	this.gotoAndStop(2);
}

//Funcion Builds
function buildsframe(MouseEvent):void
{
	checkInStage(errorGame);
	checkInStage(carga);
	checkInStage(errorConexion);
	checkInStage(container_mc);
	checkInStage(containersum);
	vaciarClip(tipContainer);
	this.gotoAndStop(3);
}

//Funcion Busqueda
function busquedaframe(MouseEvent):void
{	
	checkInStage(containerCounter);
	checkInStage(containerBuild);
	checkInStage(carga);
	checkInStage(errorConexion);
	checkInStage(errorGame);
	checkInStage(containersum);
	vaciarClip(tipContainer);
	this.gotoAndStop(1);
}

//Funcion brillo boton
function brightOn(e:MouseEvent):void
{
	var color:Color = new Color();
	color.brightness = 0.3;         
	notifBtn.transform.colorTransform = color;
	if(optionsShared.data.tips_opt)placaToolTip("Notificaciones de la aplicación", e.target);
}

function brightOff(e:MouseEvent):void
{
	var color:Color = new Color();
	color.brightness = 0;         
	notifBtn.transform.colorTransform = color;
}

//Check Not
function hayNotif(MouseEvent):void
{
	notifBtn.gotoAndStop(2);
}

//Deshabilitar botones
function desMenu():void
{
	buildsBtn.removeEventListener(MouseEvent.CLICK, buildsframe)
	busqueda.removeEventListener(MouseEvent.CLICK, busquedaframe)
	notifBtn.removeEventListener(MouseEvent.CLICK, notifframe)
}

//Habilitar menu
function habMenu():void
{
	buildsBtn.addEventListener(MouseEvent.CLICK, buildsframe)
	busqueda.addEventListener(MouseEvent.CLICK, busquedaframe)
	notifBtn.addEventListener(MouseEvent.CLICK, notifframe)
}

//Error de conexion
function errorConex(IOErrorEvent):void
{
	habMenu();
	checkInStage(containerCounter);
	checkInStage(containerBuild);
	checkInStage(carga);
	checkInStage(container_mc);
	checkInStage(errorGame);
	animar(errorConexion);
	addChild(errorConexion);
}

//Carga trabada
function cargaAdd():void
{
	animar(carga);
	addChild(carga);
	cargas++;
	var tiempoCarga:Timer = new Timer(15000,1);
	tiempoCarga.start();

	tiempoCarga.addEventListener(TimerEvent.TIMER_COMPLETE, timerDone);
	function timerDone(e:TimerEvent):void
	{
		if (stage.contains(carga)&&(cargas==1||cargas==0))
		{
			checkInStage(carga);
			errorConex(IOErrorEvent);
		}
		cargas--;
	}
}

//Crear tfield
function textoNuevo(texto:String, posX:int, posY:int, contenedor:MovieClip, formatoTexto:TextFormat, largo:int):void
{
	var tfield:TextField = new TextField();
	tfield.defaultTextFormat = formatoTexto;
	tfield.selectable = false;
	tfield.width = largo;
	tfield.antiAliasType = AntiAliasType.ADVANCED;
	tfield.sharpness = 1;
    tfield.thickness = 100;
	tfield.htmlText = texto;
	tfield.x = posX;
	tfield.y = posY;
	tfield.filters = [new DropShadowFilter(1)];
	tfield.embedFonts = true;
	contenedor.addChild(tfield);
}

function uiNuevo(tamaño:int, link:String, posX:int, posY:int, contenedor:MovieClip, idItem:String):void
{
		var contenedorUI:MovieClip = new MovieClip();
		contenedorUI.idItem = idItem;
		var imagenItem:UILoader = new UILoader();
		imagenItem.scaleContent = true;
		imagenItem.height = tamaño;
		imagenItem.source = link;
		imagenItem.x = posX;
		imagenItem.y = posY;
		contenedorUI.buttonMode = true;
		if(optionsShared.data.item_opt)contenedorUI.addEventListener(MouseEvent.MOUSE_OVER, itemInfo);
		contenedorUI.mouseChildren = false;
		contenedorUI.addChild(imagenItem);
		contenedor.addChild(contenedorUI);
}

function uiNuevoCounter(tamaño:int, link:String, posX:int, posY:int, contenedor:MovieClip):void
{
		var imagenItem:UILoader = new UILoader();
		imagenItem.scaleContent = true;
		imagenItem.height = tamaño;
		imagenItem.source = link;
		imagenItem.x = posX;
		imagenItem.y = posY;
		contenedor.addChild(imagenItem);
}

function getFilter(objeto:String):GlowFilter
{
	var glow:GlowFilter = new GlowFilter();
	
	glow.alpha = 0.7;
	glow.blurX = 12;
	glow.blurY = 12;

	switch (objeto){
	
	case "blueteam":
	glow.color = (0x2045A6);
	ultimoColor = "blue";
	break;
	
	case "self":
	glow.color = (0xD9CE33);
	break;
	
	case "purpleteam":
	glow.color = (0x641A95);
	ultimoColor = "purple";
	break;
	}
	
	return glow;
}

function placaItem(texto:String, target:Object):void
{
	vaciarClip(tipContainer);
	addChild(tipContainer);
	target.addEventListener(MouseEvent.ROLL_OUT, eliminarPlaca);
	var contenedorPlaca:MovieClip = new MovieClip();
	contenedorPlaca.x = stage.mouseX;
	contenedorPlaca.y = stage.mouseY+5;
	contenedorPlaca.filters = [new DropShadowFilter(1)];
	contenedorPlaca.addEventListener(MouseEvent.MOUSE_OVER, eliminarPlaca);
	
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
	tfield.embedFonts = true;
	tfield.filters = [new DropShadowFilter(1),new BevelFilter(1)];

	var rectangle:Shape = new Shape; // initializing the variable named rectangle
	rectangle.graphics.beginFill(0x666666, 0.9); // choosing the colour for the fill, here it is red
	rectangle.graphics.drawRect(0, 0, tfield.width+20,tfield.height+40); // (x spacing, y spacing, width, height)
	rectangle.graphics.endFill(); // not always needed but I like to put it in to end the fill
	contenedorPlaca.addChild(rectangle); // adds the rectangle to the stage
	contenedorPlaca.addChild(tfield);
	if(stage.mouseX+contenedorPlaca.width > stage.width)contenedorPlaca.x=contenedorPlaca.x-contenedorPlaca.width;
	tipContainer.addChild(contenedorPlaca);
	if(stage.mouseY>300||stage.mouseY<135||stage.mouseX<360||stage.mouseX>630)tipContainer.removeChild(contenedorPlaca);tipContainer.veces = 0;
}

function placaToolTip(texto:String, target:Object):void
{
	vaciarClip(tipContainer);
	addChild(tipContainer);
	
	target.addEventListener(MouseEvent.ROLL_OUT, eliminarPlaca);
	var contenedorPlaca:MovieClip = new MovieClip();
	contenedorPlaca.x = stage.mouseX;
	contenedorPlaca.y = stage.mouseY+5;
	contenedorPlaca.filters = [new DropShadowFilter(1)];
	
	var tfield:TextField = new TextField();
	tfield.defaultTextFormat = formatoItem;
	tfield.selectable = false;
	tfield.multiline = true;
	tfield.wordWrap = true;
	tfield.autoSize = TextFieldAutoSize.LEFT;
	tfield.width = 200;
	tfield.height = 210;
	tfield.embedFonts = true;
	tfield.x = 10;
	tfield.y = 10;
	tfield.antiAliasType = AntiAliasType.ADVANCED;
	tfield.sharpness = 1;
    tfield.thickness = 100;
	tfield.htmlText = texto;
	tfield.filters = [new DropShadowFilter(1),new BevelFilter(1)];

	var rectangle:Shape = new Shape; // initializing the variable named rectangle
	rectangle.graphics.beginFill(0x666666, 0.9); // choosing the colour for the fill, here it is red
	rectangle.graphics.drawRect(0, 0, tfield.width+20,tfield.height+20); // (x spacing, y spacing, width, height)
	rectangle.graphics.endFill(); // not always needed but I like to put it in to end the fill
	contenedorPlaca.addChild(rectangle); // adds the rectangle to the stage
	contenedorPlaca.addChild(tfield);
	if(stage.mouseX+contenedorPlaca.width > stage.width)contenedorPlaca.x=contenedorPlaca.x-contenedorPlaca.width;
	tipContainer.addChild(contenedorPlaca);
}

function eliminarPlaca(e:MouseEvent):void
{
	vaciarClip(tipContainer);
	tipContainer.veces = 0;
}

function toolTip(texto:String):Function {
    return function(e:MouseEvent):void
	{
		if(optionsShared.data.tips_opt)placaToolTip(texto, e.target);
	}
}