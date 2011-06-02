/**
 * ...
 * @author Cref
 */

package org.w3c.dom.css;

interface ViewCSS<TElm> implements org.w3c.dom.views.AbstractView {
 function getComputedStyle(elt:TElm, ?pseudoElt:String):CSSStyleDeclaration;
}