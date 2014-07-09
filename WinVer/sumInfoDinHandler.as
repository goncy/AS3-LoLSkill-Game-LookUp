container_mc.bs1.addEventListener(MouseEvent.CLICK, bssumoner1);
container_mc.bs2.addEventListener(MouseEvent.CLICK, bssumoner2);
container_mc.bs3.addEventListener(MouseEvent.CLICK, bssumoner3);
container_mc.bs4.addEventListener(MouseEvent.CLICK, bssumoner4);
container_mc.bs5.addEventListener(MouseEvent.CLICK, bssumoner5);
container_mc.bs6.addEventListener(MouseEvent.CLICK, bssumoner6);
container_mc.bs7.addEventListener(MouseEvent.CLICK, bssumoner7);
container_mc.bs8.addEventListener(MouseEvent.CLICK, bssumoner8);
container_mc.bs9.addEventListener(MouseEvent.CLICK, bssumoner9);
container_mc.bs10.addEventListener(MouseEvent.CLICK, bssumoner10);

function bssumoner1(e:MouseEvent):void
{
	agregarCargaSumDin(container_mc.s1.text);
}
function bssumoner2(e:MouseEvent):void
{
	agregarCargaSumDin(container_mc.s2.text);
}
function bssumoner3(e:MouseEvent):void
{
	agregarCargaSumDin(container_mc.s3.text);
}
function bssumoner4(e:MouseEvent):void
{
	agregarCargaSumDin(container_mc.s4.text);
}
function bssumoner5(e:MouseEvent):void
{
	agregarCargaSumDin(container_mc.s5.text);
}
function bssumoner6(e:MouseEvent):void
{
	agregarCargaSumDin(container_mc.s6.text);
}
function bssumoner7(e:MouseEvent):void
{
	agregarCargaSumDin(container_mc.s7.text);
}
function bssumoner8(e:MouseEvent):void
{
	agregarCargaSumDin(container_mc.s8.text);
}
function bssumoner9(e:MouseEvent):void
{
	agregarCargaSumDin(container_mc.s9.text);
}
function bssumoner10(e:MouseEvent):void
{
	agregarCargaSumDin(container_mc.s10.text);
}

//Cargas
function agregarCargaSumDin(paramName:String):void
{
	cargaAdd();
	try{
	buscarSumDin(paramName);
	}catch(e:Error){
	removeChild(carga);
	}
}

function buscarSumDin(paramName):void
{
	containersum = new containerSum();
	containersum.x = stage.stageWidth / 2;
	containersum.y = stage.stageHeight / 2;

	nombre = paramName;

	summonerLoader.load(new URLRequest("http://www.lolskill.net/summoner/"+region+"/"+nombre));
}
