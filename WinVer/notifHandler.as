var pushNot:XML;
var notLoader:URLLoader = new URLLoader();

var notificacion:Notif = new Notif();

notifBtn.addEventListener(MouseEvent.CLICK, mostrarNot);
notificacion.cerrar.addEventListener(MouseEvent.CLICK, cerrarNot);

notLoader.load(new URLRequest("https://raw.githubusercontent.com/goncy/AS3-LoLSkill-Game-LookUp/master/WinVer/notification.xml"));
notLoader.addEventListener(Event.COMPLETE, processXML);

function mostrarNot(MouseEvent):void
{
	notificacion.x = 422,25;
	notificacion.y = 14,90;
	addChild(notificacion);
}

function cerrarNot(MouseEvent):void
{
	removeChild(notificacion);
	notifBtn.gotoAndStop(0);
}

function processXML(e:Event):void {
pushNot = new XML(e.target.data);

if(pushNot.ID[0] == "1")
{
	notifBtn.gotoAndStop("activa");
	notificacion.titulo = pushNot.TITULO[0];
	notificacion.cuerpo = pushNot.CUERPO[0];
	notifBtn.visible = true;
}
}