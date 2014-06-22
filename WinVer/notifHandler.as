var pushNot:XML;
var notLoader:URLLoader = new URLLoader();

notLoader.load(new URLRequest("https://raw.githubusercontent.com/goncy/AS3-LoLSkill-Game-LookUp/master/WinVer/notification.xml"));
notLoader.addEventListener(Event.COMPLETE, processXML);

function mostrarNot(MouseEvent):void
{
	gotoAndStop(2);
	notifBtn.gotoAndStop(1);
}

function processXML(e:Event):void
{
	pushNot = new XML(e.target.data);

	if (pushNot.ID[0] == "1")
	{
		notifBtn.gotoAndStop(3);
		titulo.text = pushNot.TITULO[0];
		cuerpo.text = pushNot.CUERPO[0];
	}
}