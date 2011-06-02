package jstm;

using ES5;

class NonIE__ {
	
	function new(w:Window) untyped {
		ieMouseEvents(w.document);
	}
	
	//emulate IE mouseover and mouseout events, since they're very useful!
	//not perfect yet.
	static function ieMouseEvents(d:HTMLDocument):Void {
		var enterLeave = function(e:MouseEvent) {
			var pos=e.relatedTarget == null?-1:e.target.compareDocumentPosition(e.relatedTarget);
			if (pos != 20 && pos != 0) {
				var evt:MouseEvent = d.createEvent('MouseEvent');
				evt.initMouseEvent('mouse' + (e.type == 'mouseover'?'enter':'leave'), false, false, null, null, e.screenX, e.screenY, e.clientX, e.clientY, e.ctrlKey, e.altKey, e.shiftKey, e.metaKey, e.button, e.relatedTarget);
				var t:HTMLElement = e.target;
				while (t != null && t.__state!=e.type) {
					t.dispatchEvent(evt);
					t.__state=e.type;
					t = t.parentNode;
				}
			}
		};
		d.addEventListener('mouseover',enterLeave,false);
		d.addEventListener('mouseout',enterLeave,false);
	}
	
}