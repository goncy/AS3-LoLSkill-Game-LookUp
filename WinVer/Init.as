//Stop
stop();
animarFrame();

//Summoner
var nombre:String;
var region:String = "LAS";

//Mensajes
var carga:Cargador = new Cargador();
var errorGame:ErrorGame = new ErrorGame();

//Declaraciones
carga.x = stage.stageWidth /2;
carga.y = stage.stageHeight / 2;

errorGame.x = stage.stageWidth /2;
errorGame.y = stage.stageHeight / 2;

//Initers
removeChild(container_mc);
notifBtn.buttonMode = true;

//Listeners
buscador.bus_btn.addEventListener(MouseEvent.CLICK, animarBoton);
textloader.addEventListener(ProgressEvent.PROGRESS, deshabilitarBoton);
textloader.addEventListener(Event.COMPLETE, agregar);
notifBtn.addEventListener(MouseEvent.CLICK, notifframe);
busqueda.addEventListener(MouseEvent.CLICK, busquedaframe);
notifBtn.addEventListener(MouseEvent.MOUSE_OVER, brightOn);
notifBtn.addEventListener(MouseEvent.MOUSE_OUT, brightOff);

//Funcion Notificacion
function notifframe(MouseEvent):void
{
	checkInStage(errorGame);
	checkInStage(carga);
	checkInStage(container_mc);
	gotoAndStop(2);
}

//Funcion Busqueda
function busquedaframe(MouseEvent):void
{
	gotoAndStop(1);
}

//Funcion brillo boton
function brightOn(MouseEvent):void
{
	var color:Color = new Color();
	color.brightness = 0.3;         
	notifBtn.transform.colorTransform = color;
}

//Funcion brillo boton
function brightOff(MouseEvent):void
{
	var color:Color = new Color();
	color.brightness = 0;         
	notifBtn.transform.colorTransform = color;
}