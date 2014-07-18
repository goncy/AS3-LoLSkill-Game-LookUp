import com.greensock.TweenLite;

function handleMasteriesIn(e:MouseEvent):void
{
	TweenLite.to(e.target.parent.smaso, 0.3, {autoAlpha:1});
}

function handleMasteriesOut(e:MouseEvent):void
{
	TweenLite.to(e.target.parent.smaso, 0.3, {autoAlpha:0});
}