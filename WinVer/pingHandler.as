import flash.utils.getTimer;
import flash.events.HTTPStatusEvent;

var ldr:URLLoader = new URLLoader();
ldr.addEventListener(HTTPStatusEvent.HTTP_STATUS, ldrStatus);

var url:String = "http://las.leagueoflegends.com";
var limit:int = 1;

var time_start:Number;
var time_stop:Number;
var times:int;

ping();

function ping():void
{
    times = 0;
    doThePing();
}

function doThePing():void
{
    time_start = getTimer();
    ldr.load(new URLRequest(url));
}

function ldrStatus(evt:*):void
{
    if(evt.status == 200)
    {
        time_stop = getTimer();
        pings.text = String(time_stop - time_start)+"ms";
    }

    times++;
    if(times < limit) doThePing();
}

var pingTimer:Timer = new Timer(2000);
pingTimer.addEventListener(TimerEvent.TIMER, timerListener);
function timerListener (e:TimerEvent):void{
ping();
}
pingTimer.start();