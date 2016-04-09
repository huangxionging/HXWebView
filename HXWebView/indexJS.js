
var httpString="open://drawCicle";

// var message = document.createElement('message');
// message.style.display = 'none';
// document.documentElement.appendChild(message)

function myFuction() {
	// alert("dddd")
	 window.location.href = httpString;
}


function openCamera() {
//	window.location.href = "open://openCamera";
    var message = { 'message' : 'Hello, World!', 'numbers' : [ 1, 2, 3 ] };
    
    window.webkit.messageHandlers.javascript.postMessage(message);
}