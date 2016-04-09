
function openCameraMore() {
    window.location.href = "bleto://openCameraMore";
}

function openAndOpen() {
   window.location.href = "bleto://openCameraMore/actions"
}
function openCameraMoreAndMore() {
    window.webkit.messageHandlers.openCameraMoreAndMore.postMessage("bleto://more");
}

function openChange() {
    var array = ["900", "800"];
        window.webkit.messageHandlers.openCameraMoreAndMore.postMessage(array);
}