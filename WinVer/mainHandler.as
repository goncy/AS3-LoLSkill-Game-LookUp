//Summoner
var nombre:String;
var region:String = "LAS";

textloader.addEventListener(ProgressEvent.PROGRESS, deshabilitarBoton);
textloader.addEventListener(Event.COMPLETE, agregar);
textloader.addEventListener(IOErrorEvent.IO_ERROR, errorConex);
buscador.bus_btn.addEventListener(MouseEvent.CLICK, animarBoton);
buscador.sumname.addEventListener(FocusEvent.FOCUS_IN, glowin);
buscador.sumname.addEventListener(FocusEvent.FOCUS_OUT, glowout);

if(currentFrame == 1)
{
	buscador.sumname.addEventListener(KeyboardEvent.KEY_DOWN, pressEnter);
}

//Cargas
function agregarCarga():void
{
	animar(carga);
	addChild(carga);
	
	buscar();
}

//Deshabilitar boton
function deshabilitarBoton(ProgressEvent):void
{
	buscador.bus_btn.removeEventListener(MouseEvent.CLICK, animarBoton);
}

//Animar boton
function animarBoton(MouseEvent):void
{
	desMenu();
	TweenLite.to(buscador, 0.7, {x:14, y:17, onComplete:agregarCarga});
}

//Buscar
function buscar():void
{
buscarConfig();

nombre = buscador.sumname.text;
region = buscador.region_mc.combo.selectedItem.data;

//SO
suminfoShared.data.sumname = nombre;
suminfoShared.data.sumreg = buscador.region_mc.combo.selectedIndex;
suminfoShared.flush ();

externalfile.url = "http://www.lolskill.net/game/"+region+"/"+nombre;
textloader.load(externalfile);

errorGame.errorLink.text = externalfile.url;
}

function agregar(event:Event):void
{	
	//URL a String
    var textoCargado:String = textloader.data;
	//Event boton
	buscador.bus_btn.addEventListener(MouseEvent.CLICK, animarBoton);
	habMenu();
	
	//Agregar
	try {
		//Parse URL
		parseAll(textoCargado);
		//Popular contenedor
		populate();
		//Animar boton
		animar(container_mc);
		//Borrar Excedentes
		removeChild(carga);
		//Agregar Container
		addChild(container_mc);
	}catch(error:Error){
		//Animar Error
		animar(errorGame);
		//Borrar Carga
		removeChild(carga);
		//Agregar Error
		addChild(errorGame);
		//Trace Error
		trace(error.getStackTrace());
	}
}

function populate():void
{
	//Champ
	container_mc.simg1.source = arrayChamp[1];
	container_mc.simg2.source = arrayChamp[3];
	container_mc.simg3.source = arrayChamp[5];
	container_mc.simg4.source = arrayChamp[7];
	container_mc.simg5.source = arrayChamp[9];
	container_mc.simg6.source = arrayChamp[11];
	container_mc.simg7.source = arrayChamp[13];
	container_mc.simg8.source = arrayChamp[15];
	container_mc.simg9.source = arrayChamp[17];
	container_mc.simg10.source = arrayChamp[19];
	//Nombre
	container_mc.s1.text = arrayNombre[1];
	container_mc.s2.text = arrayNombre[3];
	container_mc.s3.text = arrayNombre[5];
	container_mc.s4.text = arrayNombre[7];
	container_mc.s5.text = arrayNombre[9];
	container_mc.s6.text = arrayNombre[11];
	container_mc.s7.text = arrayNombre[13];
	container_mc.s8.text = arrayNombre[15];
	container_mc.s9.text = arrayNombre[17];
	container_mc.s10.text = arrayNombre[19];
	//Skill
	container_mc.sskill1.text = arraySkill[1];
	container_mc.sskill2.text = arraySkill[3];
	container_mc.sskill3.text = arraySkill[5];
	container_mc.sskill4.text = arraySkill[7];
	container_mc.sskill5.text = arraySkill[9];
	container_mc.sskill6.text = arraySkill[11];
	container_mc.sskill7.text = arraySkill[13];
	container_mc.sskill8.text = arraySkill[15];
	container_mc.sskill9.text = arraySkill[17];
	container_mc.sskill10.text = arraySkill[19];
	//Division
	container_mc.sdiv1.htmlText = arrayDiv[1];
	container_mc.sdiv2.htmlText = arrayDiv[3];
	container_mc.sdiv3.htmlText = arrayDiv[5];
	container_mc.sdiv4.htmlText = arrayDiv[7];
	container_mc.sdiv5.htmlText = arrayDiv[9];
	container_mc.sdiv6.htmlText = arrayDiv[11];
	container_mc.sdiv7.htmlText = arrayDiv[13];
	container_mc.sdiv8.htmlText = arrayDiv[15];
	container_mc.sdiv9.htmlText = arrayDiv[17];
	container_mc.sdiv10.htmlText = arrayDiv[19];
	//Wins
	container_mc.swin1.htmlText = arrayWins[1];
	container_mc.swin2.htmlText = arrayWins[3];
	container_mc.swin3.htmlText = arrayWins[5];
	container_mc.swin4.htmlText = arrayWins[7];
	container_mc.swin5.htmlText = arrayWins[9];
	container_mc.swin6.htmlText = arrayWins[11];
	container_mc.swin7.htmlText = arrayWins[13];
	container_mc.swin8.htmlText = arrayWins[15];
	container_mc.swin9.htmlText = arrayWins[17];
	container_mc.swin10.htmlText = arrayWins[19];
	//Premade
	container_mc.spm1.source = arrayPm[1];
	container_mc.spm2.source = arrayPm[3];
	container_mc.spm3.source = arrayPm[5];
	container_mc.spm4.source = arrayPm[7];
	container_mc.spm5.source = arrayPm[9];
	container_mc.spm6.source = arrayPm[11];
	container_mc.spm7.source = arrayPm[13];
	container_mc.spm8.source = arrayPm[15];
	container_mc.spm9.source = arrayPm[17];
	container_mc.spm10.source = arrayPm[19];
	//Mapa
	container_mc.mapa.htmlText = MapString;
	//Stats
	container_mc.sstats1.text = arrayGames[1]+"\n"+arrayKills[1]+"\n"+arrayDeaths[1]+"\n"+arrayAssists[1]+"\n"+arrayCs[1]+"\n"+arrayGold[1];
	container_mc.sstats2.text = arrayGames[3]+"\n"+arrayKills[3]+"\n"+arrayDeaths[3]+"\n"+arrayAssists[3]+"\n"+arrayCs[3]+"\n"+arrayGold[3];
	container_mc.sstats3.text = arrayGames[5]+"\n"+arrayKills[5]+"\n"+arrayDeaths[5]+"\n"+arrayAssists[5]+"\n"+arrayCs[5]+"\n"+arrayGold[5];
	container_mc.sstats4.text = arrayGames[7]+"\n"+arrayKills[7]+"\n"+arrayDeaths[7]+"\n"+arrayAssists[7]+"\n"+arrayCs[7]+"\n"+arrayGold[7];
	container_mc.sstats5.text = arrayGames[9]+"\n"+arrayKills[9]+"\n"+arrayDeaths[9]+"\n"+arrayAssists[9]+"\n"+arrayCs[9]+"\n"+arrayGold[9];
	container_mc.sstats6.text = arrayGames[11]+"\n"+arrayKills[11]+"\n"+arrayDeaths[11]+"\n"+arrayAssists[11]+"\n"+arrayCs[11]+"\n"+arrayGold[11];
	container_mc.sstats7.text = arrayGames[13]+"\n"+arrayKills[13]+"\n"+arrayDeaths[13]+"\n"+arrayAssists[13]+"\n"+arrayCs[13]+"\n"+arrayGold[13];
	container_mc.sstats8.text = arrayGames[15]+"\n"+arrayKills[15]+"\n"+arrayDeaths[15]+"\n"+arrayAssists[15]+"\n"+arrayCs[15]+"\n"+arrayGold[15];
	container_mc.sstats9.text = arrayGames[17]+"\n"+arrayKills[17]+"\n"+arrayDeaths[17]+"\n"+arrayAssists[17]+"\n"+arrayCs[17]+"\n"+arrayGold[17];
	container_mc.sstats10.text = arrayGames[19]+"\n"+arrayKills[19]+"\n"+arrayDeaths[19]+"\n"+arrayAssists[19]+"\n"+arrayCs[19]+"\n"+arrayGold[19];
	//Masteries
	container_mc.smaso1.masteries.htmlText = arrayMasteries[1];
	container_mc.smaso2.masteries.htmlText = arrayMasteries[3];
	container_mc.smaso3.masteries.htmlText = arrayMasteries[5];
	container_mc.smaso4.masteries.htmlText = arrayMasteries[7];
	container_mc.smaso5.masteries.htmlText = arrayMasteries[9];
	container_mc.smaso6.masteries.htmlText = arrayMasteries[11];
	container_mc.smaso7.masteries.htmlText = arrayMasteries[13];
	container_mc.smaso8.masteries.htmlText = arrayMasteries[15];
	container_mc.smaso9.masteries.htmlText = arrayMasteries[17];
	container_mc.smaso10.masteries.htmlText = arrayMasteries[19];
	//Porcentajes
	container_mc.t1per.text = String(Math.round((arrayPerc[0]/(arrayPerc[0]+arrayPerc[1]))*10000)/100)+"%";
	container_mc.t2per.text = String(Math.round((arrayPerc[1]/(arrayPerc[0]+arrayPerc[1]))*10000)/100)+"%";
}

//Config buscar
function buscarConfig():void
{
	checkInStage(container_mc);
	checkInStage(errorGame);
	checkInStage(errorConexion);
}

//Effects
function glowin(FocusEvent):void
{
	//Glow in effect
	TweenMax.to(buscador.bgtext, 0.5, {glowFilter:{color:0x1E7FD9, alpha:1, blurX:5, blurY:5, strength:2}});
}

function glowout(FocusEvent):void
{
	//Glow out effect
	TweenMax.to(buscador.bgtext, 0.5, {glowFilter:{color:0x1E7FD9, alpha:0, blurX:4, blurY:4}});
}

//Enter handler
function pressEnter(evt:KeyboardEvent):void 
{
   //I also shortened down this code
	if (evt.keyCode == Keyboard.ENTER)
	{
	   animarBoton(MouseEvent.CLICK);
	}
}