/**
 * quickly create a layout
 * 
 * Why is this better than using divs for layout?
 * Because you can not mix divs with fixed dimensions with divs that have percentual dimensions.
 * For instance: a page that shows a fixed height header at the top, a fixed height footer at
 * the bottom and in the center a space that takes up the rest up the height and scales and scrolls.
 * Probably like the code editor you're reading this comment in right now.
 * 
 * When you don't need to mix fixed with percentual, divs will do just fine.
 * 
 * TODO: fix dimensions for IE<8 which, for some reason, breaks correct table scaling behavior
 * when not in Quirks mode.
 * 
 * TODO: in debug-mode, use cellIndex as title attribute and generate altering backgroundColors.
 * 
 * @author Cref
 */
package hxtc.dom.controls;

import hxtc.dom.style.Selector;
import js.browser.BrowserEngine;
import jstm.Host;

class Layout extends hxtc.dom.controls.Box {

	private var cells:Array<HTMLElement>;
	public function new(?d:HTMLDocument, colWidths:Array<Int>, rowHeights:Array<Int>, colSpans:Array<Int>, rowSpans:Array<Int>) {
		var usedSpace = 0;
		cells = [];
		nCells = colSpans.length;
		var nCols = colWidths.length;
		var nRows = rowHeights.length;
		super(d,'table');
		untyped element.cellSpacing = '0';
		var tbody = element.appendChild(doc.createElement('tbody')), row:HTMLElement = null, currentCol = 0, currentRow = 0, usedRowCols = [];
		for (n in rowHeights) usedRowCols.push(0);
		for (i in 0...nCells) {
			if (row == null) {
				row = tbody.appendChild(doc.createElement('tr'));
				//row.style.height = '1px';
			}
			var cs = colSpans[i], rs = rowSpans[i];
			for (j in currentRow...currentRow+rs) usedRowCols[j] += cs;
			cells.push(row.appendChild(createCell(cs, rs, cs==1?colWidths[currentCol]:null, rs==1?rowHeights[currentRow]:null)));
			usedSpace += cs * rs;
			if (usedRowCols[currentRow] == nCols) {
				row = null;
				currentRow++;
				currentCol = 0;
			}
			else currentCol++;
		}
		if (usedSpace != nCols * nRows) throw 'invalid layout';
	}
	
	public var nCells(default,null):Int;
	
	private function createCell(colSpan:Int, rowSpan:Int, width:Int, height:Int):HTMLElement {
		var td:HTMLElement = doc.createElement('td');
		untyped td.colSpan=colSpan;
		untyped td.rowSpan=rowSpan;
		untyped td.vAlign = 'top';
		td.style.width = width == null?null:width + 'px';
		td.style.height = height == null?null:height + 'px';
		if (height == null) td.className = 'noheight';
		return td;
	}
	
	static function __init__():Void {
		var s = Selector.getControlSelector();
		s.writeStyles({
		//tableLayout:fixed prevents widths being ignored when scaling
		tableLayout:'fixed',
		borderCollapse:'collapse'
		});
		s.children(new Selector('tbody')).children(new Selector('tr')).children(new Selector('td')).writeStyles( {
			border:'1px solid #CCC'
		});
		//fix heights. WebKit browsers do not need this
		if (Host.engine != BrowserEngine.WebKit) heightsPatch(s);
	}
	
	static function heightsPatch(s:Selector) {
		_fixHeights = Host.ieVersion > 0 && Host.ieVersion < 8
			?function(doc:HTMLDocument) {
				var tdNoHeight = 'td.noheight';
				var tdNoHeightSel = s.descendants(new Selector(tdNoHeight));
				//first hide all so the tables get their minimum height
				tdNoHeightSel.writeStyle('display','none');
				var tds = doc.querySelectorAll(tdNoHeight);
				if (tds.length == 0) return;
				for (td in tds) {
					var table:HTMLTableElement = cast td.offsetParent;
					var row = td.parentNode;
					var h = table.offsetHeight,sh=table.style.height;
					table.style.height = '0px';
					var rn = 0,r=null;
					for (r in table.rows) {
						if (r == row) break;
						h -= r.offsetHeight;
						rn++;
					}
					untyped rn += td.rowSpan;
					for (i in rn...table.rows.length) h -= table.rows[i].offsetHeight;
					td.style.height = h + 'px';
					var box = td.firstChild;
					if (box != null) {
						var s = box.style;
						s.position = 'absolute';
						untyped s.width = td.clientWidth;
						untyped s.height = td.clientHeight;
						s.height = td.style.height;
					}
					table.style.height=sh;
				}
				tdNoHeightSel.writeStyle('display','');
			}
			:function(doc:HTMLDocument) {
				var boxes = doc.querySelectorAll('td.noheight>*');
				if (boxes.length == 0) return;
				//first hide all so all td's get the correct height
				for (box in boxes) box.style.display = 'none';
				//then, store all the heights
				var heights = [];
				for (box in boxes) heights.push(box.parentNode.offsetHeight);
				//and finally, apply the heights in a seperate loop so changing one height doesn't change another height
				for (box in boxes) {
					box.style.height = heights.shift() + 'px';
					box.style.display = 'block';
				}
			}
		;
		var w = Host.window;
		w.addEventListener('resize', function(e) fixHeights(w.document),false);
		w.addEventListener('load', function(e) fixHeights(w.document), false); return;
	}
	
	public function set(index:Int, b:hxtc.dom.controls.Box):Layout {// return this;
		var e = cells[index];
		e.innerHTML = '';
		e.appendChild(b.element);
		if (e.className == 'noheight') fixHeights(doc);
		return this;
	}
	
	private static var t;
	//delayed to prevent hogging the CPU
	private static function fixHeights(d) {
		var w = Host.window;
		w.clearTimeout(t);
		t=w.setTimeout(function()_fixHeights(d),20);
	}
	private static dynamic function _fixHeights(d);
	
}