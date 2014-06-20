﻿//Masteries
container_mc.smaso1b.addEventListener(MouseEvent.ROLL_OVER, handleMasteriesIn);
container_mc.smaso2b.addEventListener(MouseEvent.ROLL_OVER, handleMasteriesIn);
container_mc.smaso3b.addEventListener(MouseEvent.ROLL_OVER, handleMasteriesIn);
container_mc.smaso4b.addEventListener(MouseEvent.ROLL_OVER, handleMasteriesIn);
container_mc.smaso5b.addEventListener(MouseEvent.ROLL_OVER, handleMasteriesIn);
container_mc.smaso6b.addEventListener(MouseEvent.ROLL_OVER, handleMasteriesIn);
container_mc.smaso7b.addEventListener(MouseEvent.ROLL_OVER, handleMasteriesIn);
container_mc.smaso8b.addEventListener(MouseEvent.ROLL_OVER, handleMasteriesIn);
container_mc.smaso9b.addEventListener(MouseEvent.ROLL_OVER, handleMasteriesIn);
container_mc.smaso10b.addEventListener(MouseEvent.ROLL_OVER, handleMasteriesIn);

container_mc.smaso1b.addEventListener(MouseEvent.ROLL_OUT, handleMasteriesOut);
container_mc.smaso2b.addEventListener(MouseEvent.ROLL_OUT, handleMasteriesOut);
container_mc.smaso3b.addEventListener(MouseEvent.ROLL_OUT, handleMasteriesOut);
container_mc.smaso4b.addEventListener(MouseEvent.ROLL_OUT, handleMasteriesOut);
container_mc.smaso5b.addEventListener(MouseEvent.ROLL_OUT, handleMasteriesOut);
container_mc.smaso6b.addEventListener(MouseEvent.ROLL_OUT, handleMasteriesOut);
container_mc.smaso7b.addEventListener(MouseEvent.ROLL_OUT, handleMasteriesOut);
container_mc.smaso8b.addEventListener(MouseEvent.ROLL_OUT, handleMasteriesOut);
container_mc.smaso9b.addEventListener(MouseEvent.ROLL_OUT, handleMasteriesOut);
container_mc.smaso10b.addEventListener(MouseEvent.ROLL_OUT, handleMasteriesOut);

function handleMasteriesIn(e:MouseEvent):void
{
	switch (e.target.name){

	case "smaso1b":
		TweenLite.to(container_mc.smaso1, 0.3, {autoAlpha:1});
	break; 
	case "smaso2b":
		TweenLite.to(container_mc.smaso2, 0.3, {autoAlpha:1});
	break;
	case "smaso3b":
		TweenLite.to(container_mc.smaso3, 0.3, {autoAlpha:1});
	break;
	case "smaso4b":
		TweenLite.to(container_mc.smaso4, 0.3, {autoAlpha:1});
	break;
	case "smaso5b":
		TweenLite.to(container_mc.smaso5, 0.3, {autoAlpha:1});
	break;
	case "smaso6b":
		TweenLite.to(container_mc.smaso6, 0.3, {autoAlpha:1});
	break; 
	case "smaso7b":
		TweenLite.to(container_mc.smaso7, 0.3, {autoAlpha:1});
	break; 
	case "smaso8b":
		TweenLite.to(container_mc.smaso8, 0.3, {autoAlpha:1});
	break; 
	case "smaso9b":
		TweenLite.to(container_mc.smaso9, 0.3, {autoAlpha:1});
	break; 
	case "smaso10b":
		TweenLite.to(container_mc.smaso10, 0.3, {autoAlpha:1});
	break; 
	}
}

function handleMasteriesOut(e:MouseEvent):void
{
	switch (e.target.name){
		
	case "smaso1b":
		TweenLite.to(container_mc.smaso1, 0.3, {autoAlpha:0});
	break; 
	case "smaso2b":
		TweenLite.to(container_mc.smaso2, 0.3, {autoAlpha:0});
	break;
	case "smaso3b":
		TweenLite.to(container_mc.smaso3, 0.3, {autoAlpha:0});
	break;
	case "smaso4b":
		TweenLite.to(container_mc.smaso4, 0.3, {autoAlpha:0});
	break;
	case "smaso5b":
		TweenLite.to(container_mc.smaso5, 0.3, {autoAlpha:0});
	break;
	case "smaso6b":
		TweenLite.to(container_mc.smaso6, 0.3, {autoAlpha:0});
	break; 
	case "smaso7b":
		TweenLite.to(container_mc.smaso7, 0.3, {autoAlpha:0});
	break; 
	case "smaso8b":
		TweenLite.to(container_mc.smaso8, 0.3, {autoAlpha:0});
	break; 
	case "smaso9b":
		TweenLite.to(container_mc.smaso9, 0.3, {autoAlpha:0});
	break; 
	case "smaso10b":
		TweenLite.to(container_mc.smaso10, 0.3, {autoAlpha:0});
	break; 
	}
}

//Effects
function glowin(FocusEvent):void
{
	//Glow in effect
	TweenMax.to(buscador.bgtext, 0.5, {glowFilter:{color:0x1E7FD9, alpha:1, blurX:5, blurY:5, strength:2}});
	//Agregar listener una ves que se toca el campo
	buscador.bus_btn.addEventListener(MouseEvent.CLICK, animarBoton);
}

function glowout(FocusEvent):void
{
	//Glow out effect
	TweenMax.to(buscador.bgtext, 0.5, {glowFilter:{color:0x1E7FD9, alpha:0, blurX:4, blurY:4}});
}

function deshabilitarBoton(ProgressEvent):void
{
	buscador.bus_btn.removeEventListener(MouseEvent.CLICK, animarBoton);
}

function animarBoton(MouseEvent):void
{
	TweenLite.to(buscador, 0.7, {x:14, y:17, onComplete:agregarCarga});
}
