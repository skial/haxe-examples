package ;

import js.html.*;

using js.Syntax;

class Main {

    // `entry.js` has `js.Browser.window` global scope.
    // whereas a WebWorker, in this case, has a decidated, _restricted_ api, global scope.
    public static var self = 
    #if !ww 
        js.Browser.window;
    #else
        ('self'.code():js.html.DedicatedWorkerGlobalScope);
    #end

    public static function main() {
        #if !ww
        if (hasWebWorker()) {
            var mm = new Main();
            var ww = new Worker('ww.js');
            // assign `onmessage` handler before calling `postMessage`, obviously :|
            ww.onmessage = mm.onmessage;
            ww.postMessage(['hello', 'world']);
        } else {
            self.console.error( 'Your browser does not support Web Workers.' );
        }
        #else
        var mm = new Main();
        self.onmessage = mm.onmessage;
        #end
    }

    #if !ww
    // Tests whether your browser supports webworkers
    public static inline function hasWebWorker():Bool {
        return 'window.Worker'.code();
    }
    #end
    public function new() {
        trace(#if !ww 'entry.js' #else 'ww.js' #end + ' created');
    }

    public function onmessage(e:MessageEvent) {
        self.console.log( e.origin, e.data );
        #if ww 
        self.postMessage( '${e.data[0]} Haxe ${e.data[1]}!!!' );
        #end
    }

}