/**
 * http://www.w3.org/TR/selectors-api/#nodeselector
 * @author Cref
 */

package org.w3c.dom;

interface NodeSelector<TNodeList,TNode> {
    //Element   querySelector(in DOMString selectors);
    //NodeList  querySelectorAll(in DOMString selectors);
	function querySelector(query:String):TNode;
	function querySelectorAll(query:String):TNodeList;
}