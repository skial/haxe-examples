package jstm;

using ES5;

class Moz__ extends NonIE__ {
	function new(w:Window) untyped {
		//emulate innerText
		var p = HTMLElement.getPrototype();
		if (p.innerText == null) {
			p.__defineSetter__('innerText',function (sText) {
				return this.textContent=sText;
			});
			p.__defineGetter__('innerText',function () {
				return this.textContent;
			});
		}
		super(w);
	}
}