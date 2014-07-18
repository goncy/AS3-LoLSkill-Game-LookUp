import air.update.ApplicationUpdaterUI;
import flash.filesystem.File;
import air.update.events.StatusUpdateEvent;
import air.update.events.UpdateEvent;
import flash.events.ErrorEvent;

var appUpdater:ApplicationUpdaterUI = new ApplicationUpdaterUI;
appUpdater.updateURL = "https://raw.githubusercontent.com/goncy/AS3-LoLSkill-Game-LookUp/master/WinVer/updater.xml";
appUpdater.delay = 0;
appUpdater.initialize();

appUpdater.isCheckForUpdateVisible = false;
appUpdater.isDownloadUpdateVisible = true;
appUpdater.isDownloadProgressVisible = true;
appUpdater.isInstallUpdateVisible = true;
appUpdater.isFileUpdateVisible = true;
appUpdater.isUnexpectedErrorVisible = true;

trace(appUpdater.currentVersion);

appUpdater.addEventListener(UpdateEvent.INITIALIZED, onUpdate);
appUpdater.addEventListener(ErrorEvent.ERROR, onError);

function onUpdate(event:UpdateEvent):void
{
	appUpdater.checkNow();
}

function onError(event:ErrorEvent):void
{
	trace(event);
}