import fl.containers.UILoader;
import flash.display.MovieClip;
import fl.data.DataProvider;
import flash.text.TextFormat;
import flash.text.Font;
import flash.text.AntiAliasType;
import flash.text.TextFieldAutoSize;

//Variables
var arrayChampsFull:Array = ["Aatrox","Ahri","Akali","Alistar","Amumu","Anivia","Annie","Ashe","Blitzcrank","Brand","Braum","Caitlyn","Cassiopeia","ChoGath","Corki","Darius","Diana","Dr-Mundo","Draven","Elise","Evelynn","Ezreal","Fiddlesticks","Fiora","Fizz","Galio","Gangplank","Garen","Gragas","Graves","Hecarim","Heimerdinger","Irelia","Janna","Jarvan-IV","Jax","Jayce","Jinx","Karma","Karthus","Kassadin","Katarina","Kayle","Kennen","KhaZix","KogMaw","LeBlanc","Lee-Sin","Leona","Lissandra","Lucian","Lulu","Lux","Malphite","Malzahar","Maokai","Master-Yi","Miss-Fortune","Mordekaiser","Morgana","Nami","Nasus","Nautilus","Nidalee","Nocturne","Nunu","Olaf","Orianna","Pantheon","Poppy","Quinn","Rammus","Renekton","Rengar","Riven","Rumble","Ryze","Sejuani","Shaco","Shen","Shyvana","Singed","Sion","Sivir","Skarner","Sona","Soraka","Swain","Syndra","Talon","Taric","Teemo","Thresh","Tristana","Trundle","Tryndamere","Twisted-Fate","Twitch","Udyr","Urgot","Varus","Vayne","Veigar","VelKoz","Vi","Viktor","Vladimir","Volibear","Warwick","Wukong","Xerath","Xin-Zhao","Yasuo","Yorick","Zac","Zed","Ziggs","Zilean","Zyra"];
var champ:String;
var champLoader:URLLoader = new URLLoader();

containerBuild.y = 60;
containerBuild.x = stage.stageWidth / 2;

function divideBuild(e:Event):void
{
	//Divide Build
	var arrayBuild:Array = new Array();
	var parserBuild:RegExp = new RegExp("<div class='items'>(.*?)<div class='summoners'>","sg");
	arrayBuild = e.target.data.split(parserBuild);
	trace(arrayBuild.length);
	parseItems(arrayBuild[3]);
	
	var availableBuilds:Array = new Array();
	var builds:int = 3;
	
	checkExceed();
	checkEmpty();
	
	containerBuild.nextBuildBtn.addEventListener(MouseEvent.CLICK, nextBuild);
	containerBuild.prevBuildBtn.addEventListener(MouseEvent.CLICK, prevBuild);

	function checkExceed():void
	{
		trace(builds);
		if(builds + 2 >= arrayBuild.length-2)
		{
			containerBuild.nextBuildBtn.visible = false;
		}
	}
	
	function checkEmpty():void
	{
		trace(builds);
		if(builds - 2 < 5)
		{
			containerBuild.prevBuildBtn.visible = false;
		}
	}
	
	function nextBuild(MouseEvent):void
	{
		containerBuild.prevBuildBtn.visible = true;
		checkExceed();
		if(builds < arrayBuild.length)
		{
			vaciarClip(containerBuild.champBuild);
			builds += 2;
			parseItems(arrayBuild[builds]);
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
			parseItems(arrayBuild[builds]);
		}
	}
	
/*	for (var i:int = 3; i < arrayBuild.length; i+=2)
	{
		parseItems(arrayBuild[i]);
	}
*/
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