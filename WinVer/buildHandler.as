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

var container:buildContainer = new buildContainer();
container.y = 60;
container.x = stage.stageWidth / 2;

function divideBuild(e:Event):void
{
	//Divide Build
	var arrayBuild:Array = new Array();
	var parserBuild:RegExp = new RegExp("<div class='items'>(.*?)<div class='summoners'>","sg");
	arrayBuild = e.target.data.split(parserBuild);
	parseItems(arrayBuild[3]);

	//Champ Stats
	var arrayChampStat:Array = new Array();
	var parserChampStat:RegExp = new RegExp("<div class='name'>(.*?)<\/div>","sg");
	arrayChampStat = e.target.data.split(parserChampStat);
	//Image
	container.champImg.source = "http://www.mobafire.com/images/champion/icon/"+champ.toLowerCase()+".png";
	//Name
	container.champName.text = arrayChampStat[1];
	
	animar(container);
	addChild(container);
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
		container.champBuild.addChild(item);
	}
}