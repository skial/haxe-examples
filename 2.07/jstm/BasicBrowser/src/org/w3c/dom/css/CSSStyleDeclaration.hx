/**
 * http://dev.w3.org/csswg/cssom/#the-cssstyledeclaration-interface
 * 
 * TODO:
 * - apply vendor prefixes when necessary
 * - fix returntypes for certain css properties
 * - support transitions on IE
 * - support transparent png's, rounded corners, drop-shadow etc. on IE
 * - borderRadius and boxShadow for IE: http://code.google.com/p/box-shadow/
 * - borderRadius and IE6 PNG fix: http://www.dillerdesign.com/experiment/DD_roundies/
 * - boxShadow via Blut filter: http://placenamehere.com/article/384/CSS3BoxShadowinInternetExplorerBlurShadow
 * - add more IE style fixes! http://css3please.com/ and http://www.useragentman.com/blog/2010/03/09/cross-browser-css-transforms-even-in-ie/
 * - resets per browser, this might be helpful: http://blueprintcss.org/
 * @author Cref
 */

package org.w3c.dom.css;

interface CSSStyleDeclaration {
	
	public var cssText:String;
	
	public var width:String;
	public var height:String;
	public var minWidth:String;
	public var minHeight:String;
	public var maxWidth:String;
	public var maxHeight:String;
	public var lineHeight:String;
	
	public var top:String;
	public var left:String;
	public var bottom:String;
	public var right:String;
	
	public var margin:String;
	public var marginTop:String;
	public var marginBottom:String;
	public var marginLeft:String;
	public var marginRight:String;
	
	public var padding:String;
	public var paddingTop:String;
	public var paddingBottom:String;
	public var paddingLeft:String;
	public var paddingRight:String;
	
	public var border:String;
	public var borderTop:String;
	public var borderLeft:String;
	public var borderBottom:String;
	public var borderRight:String;
	public var borderWidth:String;
	public var borderTopWidth:String;
	public var borderLeftWidth:String;
	public var borderBottomWidth:String;
	public var borderRightWidth:String;
	public var borderColor:String;
	public var borderTopColor:String;
	public var borderLeftColor:String;
	public var borderBottomColor:String;
	public var borderRightColor:String;
	public var borderStyle:String;
	
	public var fontFamily:String;
	public var fontSize:String;
	
	public var clear:String;
	
	public var color:String;
	public var backgroundColor:String;
	public var backgroundImage:String;
	public var backgroundPosition:String;
	public var backgroundRepeat:String;
	
	public var tableLayout:String;
	public var textOverflow:String;
	public var textDecoration:String;
	public var textTransform:String;
	public var overflow:String;
	public var overflowX:String;
	public var overflowY:String;
	public var whiteSpace:String;
	public var cursor:String;
	public var fontWeight:String;
	public var borderCollapse:String;
	public var textAlign:String;
	public var verticalAlign:String;
	public var display:String;
	public var visibility:String;
	public var position:String;
	public var zIndex:String;
	
	public var userSelect:String;
	
	public var userModify:String;

	public var zoom:String;
	
	public var boxSizing:String;
	
	public var textShadow:String;
	
	public var outline:String;
	public var outlineOffset:String;
	public var resize:String;//TODO: emulate for browsers without native support

	public var opacity:String;

	public var cssFloat:String;

	//CSS3 features requiring vendor prefix http://www.css3.info/preview/

	public var transform:String;
	
	public var transition:String;
	
	public var boxShadow:String;
	
	public var borderRadius:String;
	
	public var borderImage:String;

	public var columnWidth:String;

	public var columnGap:String;

	public var columnCount:String;

	public var columnRule:String;

	public var columnSpaceDistribution:String;

}

