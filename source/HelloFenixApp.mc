using Toybox.Application;

class HelloFenixApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    // Return the initial view of your application here
    function getInitialView() {
        return [ new HelloFenixView() ];
    }

}