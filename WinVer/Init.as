﻿import flash.events.MouseEvent;
import flash.net.SharedObject;
import flash.events.IOErrorEvent;
import flash.utils.Timer;
import flash.events.TimerEvent;
import flash.display.MovieClip;
import flash.events.UncaughtErrorEvent;
import flash.filters.GlowFilter;
import flash.ui.Mouse;

//Stop
stop();
animarFrame();

//Texto;
var ubuntu = new Ubuntu();

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
formatoItem.font = ubuntu.fontName;

//Mensajes
var carga:Cargador = new Cargador();
var errorGame:ErrorGame = new ErrorGame();
var errorConexion:errorApi = new errorApi();

//Containers
var containerCounter:containerCounterMc = new containerCounterMc();
var containerBuild:buildContainer = new buildContainer();

//SharedObject
var suminfoShared:SharedObject = SharedObject.getLocal("summoner");
if (!suminfoShared.data.sumname) {
buscador.sumname.text = "";}else{
buscador.sumname.text = suminfoShared.data.sumname;
buscador.region_mc.combo.selectedIndex = suminfoShared.data.sumreg;
}

//Declaraciones
carga.x = stage.stageWidth /2;
carga.y = stage.stageHeight / 2;

errorGame.x = stage.stageWidth /2;
errorGame.y = stage.stageHeight / 2;

errorConexion.x = stage.stageWidth /2;
errorConexion.y = stage.stageHeight / 2;

//Initers
checkInStage(container_mc);
notifBtn.buttonMode = true;

//Listeners
notifBtn.addEventListener(MouseEvent.CLICK, notifframe);
busqueda.addEventListener(MouseEvent.CLICK, busquedaframe);
buildsBtn.addEventListener(MouseEvent.CLICK, buildsframe);
notifBtn.addEventListener(MouseEvent.MOUSE_OVER, brightOn);
notifBtn.addEventListener(MouseEvent.MOUSE_OUT, brightOff);

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
	this.gotoAndStop(1);
}

//Funcion brillo boton
function brightOn(MouseEvent):void
{
	var color:Color = new Color();
	color.brightness = 0.3;         
	notifBtn.transform.colorTransform = color;
}

function brightOff(MouseEvent):void
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
		contenedorUI.addEventListener(MouseEvent.MOUSE_DOWN, itemInfo);
		contenedorUI.mouseChildren = false;
		contenedorUI.addChild(imagenItem);
		contenedor.addChild(contenedorUI);
		trace(idItem);
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
	break;
	
	case "self":
	glow.color = (0xD9CE33);
	break;
	
	case "purpleteam":
	glow.color = (0x641A95);
	break;
	}
	return glow;
}