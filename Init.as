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
container_mc.alpha = 0;
notifBtn.buttonMode = true;

//Listeners
buscador.bus_btn.addEventListener(MouseEvent.CLICK, animarBoton);
textloader.addEventListener(ProgressEvent.PROGRESS, deshabilitarBoton);
textloader.addEventListener(Event.COMPLETE, agregar);
busqueda.addEventListener(MouseEvent.CLICK, notifframe);

//Funcion Donar
function notifframe(MouseEvent):void
{
	checkInStage(errorGame);
	checkInStage(carga);
	checkInStage(container_mc);
	gotoAndStop(1);
}