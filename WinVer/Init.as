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

//Listeners
textloader.addEventListener(ProgressEvent.PROGRESS, deshabilitarBoton);
textloader.addEventListener(Event.COMPLETE, agregar);
donar.addEventListener(MouseEvent.CLICK, donarframe);
buscador.sumname.addEventListener(FocusEvent.FOCUS_IN, glowin);
buscador.sumname.addEventListener(FocusEvent.FOCUS_OUT, glowout);

//Funcion Donar
function donarframe(MouseEvent):void
{
	checkInStage(errorGame);
	checkInStage(carga);
	checkInStage(container_mc);
	nextFrame();
}