/**
 * http://www.w3.org/TR/DOM-Level-3-Events/#events-Events-DocumentEvent-createEvent
 * @author Cref
 */

package org.w3c.dom.events;

interface DocumentEvent {
	public function createEvent(eventModule:String):Dynamic;
	// Introduced in DOM Level 3:
	//public function canDispatch(namespaceURI:String, type:String):Bool;
}