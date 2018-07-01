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
            var ww = new Worker('ww.js');
            var input:InputElement = cast self.document.querySelectorAll('input')[0];
            var submit:ButtonElement = cast self.document.querySelectorAll('button')[0];
            // assign `onmessage` handler before calling `postMessage`, obviously :|
            ww.onmessage = onmessage;
            submit.addEventListener('click', _ -> ww.postMessage(input.value == '' ? input.placeholder : input.value) );

            for (id in ['entry', 'ww']) {
                self.fetch('$id.js')
                    .then( res -> res.text() )
                    .then( res -> self.document.querySelector('.$id').innerText = res )
                    .catchError( e -> self.console.log(e) );
            }
            'hljs.initHighlightingOnLoad()'.code();
        } else {
            self.console.error( 'Your browser does not support Web Workers.' );
        }
        #else
        self.onmessage = onmessage;
        #end
    }

    #if !ww
    // Tests whether your browser supports webworkers
    public static inline function hasWebWorker():Bool {
        return 'window.Worker'.code();
    }
    #end

    public static function onmessage(e:MessageEvent) {
        self.console.log( e.origin, e.data );
        #if ww 
        var parts = (cast e.data:String).split(' ');
        self.postMessage( parts.map( s -> '$s Haxe').join(' ') );
        #else
        (cast self.document.querySelectorAll('.output')[0]:InputElement).value = e.data;
        #end
    }

}