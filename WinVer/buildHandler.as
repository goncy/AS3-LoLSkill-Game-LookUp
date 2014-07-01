import fl.containers.UILoader;
import flash.display.MovieClip;
import fl.data.DataProvider;
import flash.text.TextFormat;
import flash.text.Font;
import flash.text.AntiAliasType;
import flash.text.TextFieldAutoSize;

//Variables
var arrayChampsFull:Array = ["Aatrox","Ahri","Akali","Alistar","Amumu","Anivia","Annie","Ashe","Blitzcrank","Brand","Braum","Caitlyn","Cassiopeia","ChoGath","Corki","Darius","Diana","Dr-Mundo","Draven","Elise","Evelynn","Ezreal","Fiddlesticks","Fiora","Fizz","Galio","Gangplank","Garen","Gragas","Graves","Hecarim","Heimerdinger","Irelia","Janna","Jarvan-IV","Jax","Jayce","Jinx","Karma","Karthus","Kassadin","Katarina","Kayle","Kennen","KhaZix","KogMaw","LeBlanc","Lee-Sin","Leona","Lissandra","Lucian","Lulu","Lux","Malphite","Malzahar","Maokai","Master-Yi","Miss-Fortune","Mordekaiser","Morgana","Nami","Nasus","Nautilus","Nidalee","Nocturne","Nunu","Olaf","Orianna","Pantheon","Poppy","Quinn","Rammus","Renekton","Rengar","Riven","Rumble","Ryze","Sejuani","Shaco","Shen","Shyvana","Singed","Sion","Sivir","Skarner","Sona","Soraka","Swain","Syndra","Talon","Taric","Teemo","Thresh","Tristana","Trundle","Tryndamere","Twisted-Fate","Twitch","Udyr","Urgot","Varus","Vayne","Veigar","VelKoz","Vi","Viktor","Vladimir","Volibear","Warwick","Wukong","Xerath","Xin-Zhao","Yasuo","Yorick","Zac","Zed","Ziggs","Zilean","Zyra"];

containerBuild.y = 60;
containerBuild.x = stage.stageWidth / 2;

var champ:String;

//Listeners
comboBuscador.buscarChampBtn.addEventListener(MouseEvent.CLICK, animarCombo);
comboBuscador.combobox_cb.combo.dataProvider = new DataProvider(arrayChampsFull);

//Animar combo
function animarCombo(MouseEvent):void
{
	TweenLite.to(comboBuscador, 0.7, {x:14, y:17, onComplete:agregarCargaBuild});
}

function agregarLoader(e:Event):void 
{
	divideBuild(e);
	divideCounter(e);
	
	removeChild(carga);
}

function buscarChamp():void
{
	var champLoader:URLLoader = new URLLoader();
	
	champLoader.addEventListener(Event.COMPLETE, agregarLoader);

	vaciarClip(containerCounter.containerInfo);
	vaciarClip(containerBuild.champBuild);
	
	checkInStage(containerBuild);
	checkInStage(containerCounter);
	
	champ = comboBuscador.combobox_cb.combo.selectedItem.data;
	var pedidoReq:URLRequest = new URLRequest("http://www.championselect.net/champions/"+champ);
	champLoader.load(pedidoReq);
}

//Agregar carga
function agregarCargaBuild():void
{
	animar(carga);
	addChild(carga);
	buscarChamp();
}

function divideBuild(e:Event):void
{
	//Listeners
	containerBuild.nextBuildBtn.addEventListener(MouseEvent.CLICK, nextBuild);
	containerBuild.prevBuildBtn.addEventListener(MouseEvent.CLICK, prevBuild);
	
	//Divide Build
	var arrayBuilder:Array = new Array();
	var parserBuild:RegExp = new RegExp("<div class='items'>(.*?)<div class='summoners'>","sg");
	var builds:int = 3;
	
	//Handle
	arrayBuilder = e.target.data.split(parserBuild);
	parseItems(arrayBuilder[builds]);
	
	//Check
	checkExceed();
	checkEmpty();
	
	function checkExceed():void
	{
		if(builds + 2 >= arrayBuilder.length-2)
		{
			containerBuild.nextBuildBtn.visible = false;
		}else{
			containerBuild.nextBuildBtn.visible = true;
		}
	}
	
	function checkEmpty():void
	{
		if(builds - 2 < 5)
		{
			containerBuild.prevBuildBtn.visible = false;
		}else{
			containerBuild.prevBuildBtn.visible = true;
		}
	}
	
	function nextBuild(MouseEvent):void
	{
		containerBuild.prevBuildBtn.visible = true;
		checkExceed();
		if(builds < arrayBuilder.length)
		{
			vaciarClip(containerBuild.champBuild);
			builds += 2;
			parseItems(arrayBuilder[builds]);
		}
	}
	
	function prevBuild(MouseEvent):void
	{
		containerBuild.nextBuildBtn.visible = true;
		checkEmpty();
		if(builds >= 5)
		{
			vaciarClip(containerBuild.champBuild);
			builds -= 2;
			parseItems(arrayBuilder[builds]);
		}
	}
	
	//Champ Stats
	var arrayChampStat:Array = new Array();
	var parserChampStat:RegExp = new RegExp("<div class='name'>(.*?)<\/div>","sg");
	arrayChampStat = e.target.data.split(parserChampStat);
	//Image
	containerBuild.champImg.source = "http://www.mobafire.com/images/champion/icon/"+champ.toLowerCase()+".png";
	//Name
	containerBuild.champName.text = arrayChampStat[1];
	
	animar(containerBuild);
	addChild(containerBuild);
}

//Parse items
function parseItems(texto:String):void
{
	var arrayItems:Array = new Array();
	var parserItems:RegExp = new RegExp('<img src="(.*?)" \/>',"s");
	arrayItems = texto.split(parserItems);
	
	for (var i:int = 1; i < arrayItems.length-1; i+=2)
	{
		var item:UILoader = new UILoader();
		item.scaleContent = false; 
		item.source = arrayItems[i];
		item.x = 20*i;
		containerBuild.champBuild.addChild(item);
	}
}