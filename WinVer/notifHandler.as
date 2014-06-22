var pushNot:XML;
var notLoader:URLLoader = new URLLoader();

notifBtn.buttonMode = true;

notLoader.load(new URLRequest("https://raw.githubusercontent.com/goncy/AS3-LoLSkill-Game-LookUp/master/WinVer/notification.xml"));
notLoader.addEventListener(Event.COMPLETE, processXML);

function processXML(e:Event):void {
pushNot = new XML(e.target.data);

if(pushNot.ID[0] == "1")
{
	notifBtn.gotoAndStop(2);
	titulo.text = pushNot.TITULO[0];
	cuerpo.text = pushNot.CUERPO[0];
	notifBtn.visible = true;
}
}