//Navigaters
function onClickDonar(e:MouseEvent):void{
    navigateToURL(new URLRequest("https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=7BDXWJ7A9BLTQ"), "_blank");
}

function onClickFacebook(e:MouseEvent):void{
    navigateToURL(new URLRequest("https://www.facebook.com/goncy.pozzo"), "_blank");
}

function onClickTwitter(e:MouseEvent):void{
    navigateToURL(new URLRequest("https://twitter.com/goncy"), "_blank");
}