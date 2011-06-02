/**
 * http://www.w3.org/TR/DOM-Level-3-Core/core.html#ID-1950641247
 * 
 * @author Cref
 */

package org.w3c.dom;

class DocumentPosition {
	
  public static inline var      DOCUMENT_POSITION_DISCONNECTED :DocumentPosition = cast 0x01;
  public static inline var      DOCUMENT_POSITION_PRECEDING    :DocumentPosition = cast 0x02;
  public static inline var      DOCUMENT_POSITION_FOLLOWING    :DocumentPosition = cast 0x04;
  public static inline var      DOCUMENT_POSITION_CONTAINS     :DocumentPosition = cast 0x08;
  public static inline var      DOCUMENT_POSITION_CONTAINED_BY :DocumentPosition = cast 0x10;
  public static inline var      DOCUMENT_POSITION_IMPLEMENTATION_SPECIFIC :DocumentPosition = cast 0x20;
	
}