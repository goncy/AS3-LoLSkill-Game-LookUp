var trayIcon:BitmapData;

initApp();

function initApp():void{
	if(optionsShared.data.min_win_opt)loadTrayIcon();
	if(optionsShared.data.ini_win_opt)NativeApplication.nativeApplication.startAtLogin = true; 
	this.addEventListener(Event.CLOSING, minToTray);
}

function loadTrayIcon():void{
	var loader:Loader = new Loader();
	loader.contentLoaderInfo.addEventListener(Event.COMPLETE, readyToTray);
	loader.load(new URLRequest("options/icono.png"));
}

function minToTray(event:Event):void{
	event.preventDefault();
	dock();
}

function readyToTray(event:Event):void{
	trayIcon = event.target.content.bitmapData;

	var myMenu:NativeMenu = new NativeMenu();

	var openItem:NativeMenuItem = new NativeMenuItem("Abrir");
	var closeItem:NativeMenuItem = new NativeMenuItem("Cerrar");

	openItem.addEventListener(Event.SELECT, unDock);
	closeItem.addEventListener(Event.SELECT, closeApp);

	myMenu.addItem(openItem);
	myMenu.addItem(new NativeMenuItem("", true));
	myMenu.addItem(closeItem);

	if(NativeApplication.supportsSystemTrayIcon){
		SystemTrayIcon(NativeApplication.nativeApplication.icon).tooltip = "LOLInfo";

		SystemTrayIcon(NativeApplication.nativeApplication.icon).addEventListener(MouseEvent.CLICK, unDock);

		stage.nativeWindow.addEventListener(NativeWindowDisplayStateEvent.DISPLAY_STATE_CHANGING, winMinimized);
		SystemTrayIcon(NativeApplication.nativeApplication.icon).menu = myMenu;
	}
}

function winMinimized(displayStateEvent:NativeWindowDisplayStateEvent):void{
	if(displayStateEvent.afterDisplayState == NativeWindowDisplayState.MINIMIZED){
		displayStateEvent.preventDefault();
		dock();
	}
}

function dock():void{
	stage.nativeWindow.visible = false;
	NativeApplication.nativeApplication.icon.bitmaps = [trayIcon];
}

function unDock(event:Event):void{
	stage.nativeWindow.visible = true;
	stage.nativeWindow.orderToFront();

	NativeApplication.nativeApplication.icon.bitmaps = [];
}

function closeApp(event:Event):void{
	stage.nativeWindow.close();
}