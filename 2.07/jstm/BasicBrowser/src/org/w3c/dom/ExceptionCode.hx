/**
 * http://www.w3.org/TR/DOM-Level-3-Core/core.html#ID-17189187
 * 
 * @author Cref
 */

package org.w3c.dom;

//virtual enum
class ExceptionCode {

	public static inline var      INDEX_SIZE_ERR                :ExceptionCode = cast 1;
	public static inline var      DOMSTRING_SIZE_ERR            :ExceptionCode = cast 2;
	public static inline var      HIERARCHY_REQUEST_ERR         :ExceptionCode = cast 3;
	public static inline var      WRONG_DOCUMENT_ERR            :ExceptionCode = cast 4;
	public static inline var      INVALID_CHARACTER_ERR         :ExceptionCode = cast 5;
	public static inline var      NO_DATA_ALLOWED_ERR           :ExceptionCode = cast 6;
	public static inline var      NO_MODIFICATION_ALLOWED_ERR   :ExceptionCode = cast 7;
	public static inline var      NOT_FOUND_ERR                 :ExceptionCode = cast 8;
	public static inline var      NOT_SUPPORTED_ERR             :ExceptionCode = cast 9;
	public static inline var      INUSE_ATTRIBUTE_ERR           :ExceptionCode = cast 10;
	// Introduced in DOM Level 2:
	public static inline var      INVALID_STATE_ERR             :ExceptionCode = cast 11;
	// Introduced in DOM Level 2:
	public static inline var      SYNTAX_ERR                    :ExceptionCode = cast 12;
	// Introduced in DOM Level 2:
	public static inline var      INVALID_MODIFICATION_ERR      :ExceptionCode = cast 13;
	// Introduced in DOM Level 2:
	public static inline var      NAMESPACE_ERR                 :ExceptionCode = cast 14;
	// Introduced in DOM Level 2:
	public static inline var      INVALID_ACCESS_ERR            :ExceptionCode = cast 15;
	// Introduced in DOM Level 3:
	public static inline var      VALIDATION_ERR                :ExceptionCode = cast 16;
	// Introduced in DOM Level 3:
	public static inline var      TYPE_MISMATCH_ERR             :ExceptionCode = cast 17;
	
}