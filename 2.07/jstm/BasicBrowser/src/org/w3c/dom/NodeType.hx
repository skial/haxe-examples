/**
 * http://www.w3.org/TR/DOM-Level-3-Core/core.html#ID-1950641247
 * 
 * @author Cref
 */

package org.w3c.dom;

class NodeType {
	
  public static inline var      ELEMENT_NODE                  :NodeType = cast 1;
  public static inline var      ATTRIBUTE_NODE                :NodeType = cast 2;
  public static inline var      TEXT_NODE                     :NodeType = cast 3;
  public static inline var      CDATA_SECTION_NODE            :NodeType = cast 4;
  public static inline var      ENTITY_REFERENCE_NODE         :NodeType = cast 5;
  public static inline var      ENTITY_NODE                   :NodeType = cast 6;
  public static inline var      PROCESSING_INSTRUCTION_NODE   :NodeType = cast 7;
  public static inline var      COMMENT_NODE                  :NodeType = cast 8;
  public static inline var      DOCUMENT_NODE                 :NodeType = cast 9;
  public static inline var      DOCUMENT_TYPE_NODE            :NodeType = cast 10;
  public static inline var      DOCUMENT_FRAGMENT_NODE        :NodeType = cast 11;
  public static inline var      NOTATION_NODE                 :NodeType = cast 12;
	
}