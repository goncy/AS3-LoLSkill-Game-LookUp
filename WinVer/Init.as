//Stop
stop();
animarFrame();

//Mensajes
var carga:Cargador = new Cargador();
var errorGame:ErrorGame = new ErrorGame();

//Containers
var containerCounter:containerCounterMc = new containerCounterMc();
var containerBuild:buildContainer = new buildContainer();

//Declaraciones
carga.x = stage.stageWidth /2;
carga.y = stage.stageHeight / 2;

errorGame.x = stage.stageWidth /2;
errorGame.y = stage.stageHeight / 2;

//Initers
removeChild(container_mc);
notifBtn.buttonMode = true;

//Listeners
notifBtn.addEventListener(MouseEvent.CLICK, notifframe);
busqueda.addEventListener(MouseEvent.CLICK, busquedaframe);
buildsBtn.addEventListener(MouseEvent.CLICK, buildsframe);
notifBtn.addEventListener(MouseEvent.MOUSE_OVER, brightOn);
notifBtn.addEventListener(MouseEvent.MOUSE_OUT, brightOff);

addEventListener("Notif", hayNotif)

//Funcion Notificacion
function notifframe(MouseEvent):void
{
	checkInStage(errorGame);
	checkInStage(carga);
	checkInStage(container_mc);
	checkInStage(containerCounter);
	checkInStage(containerBuild);
	this.gotoAndStop(2);
}

//Funcion Builds
function buildsframe(MouseEvent):void
{
	checkInStage(errorGame);
	checkInStage(carga);
	checkInStage(container_mc);
	this.gotoAndStop(3);
}

//Funcion Busqueda
function busquedaframe(MouseEvent):void
{	
	checkInStage(containerCounter);
	checkInStage(containerBuild);
	checkInStage(carga);
	checkInStage(errorGame);
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