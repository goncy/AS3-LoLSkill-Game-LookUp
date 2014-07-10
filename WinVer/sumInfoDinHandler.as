function bssumoner(e:MouseEvent):void
{
	agregarCargaSumDin(e.target.parent.sum.text);
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