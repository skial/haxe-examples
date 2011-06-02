/**
 * ...
 * @author Cref
 */

extern class CSSStyleDeclaration implements org.w3c.dom.css.CSSStyleDeclaration {
	
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
	/*
	public var userSelect(zyUserSelect, zzUserSelect):String;
	private inline function zyUserSelect():String return getStyle('userSelect')
	private inline function zzUserSelect(v:String):String return setStyle('userSelect',v)
	
	public var userModify(zyUserModify, zzUserModify):String;
	private inline function zyUserModify():String return getStyle('userModify')
	private inline function zzUserModify(v:String):String return setStyle('userModify',v)

	//although private, FlashDevelop shows the getters and setters in the autocompletion list.
	//getters and setters start with 'zy' and 'zz' so at least they appear at the bottom of this list.
	public var zoom(zyZoom, zzZoom):String;
	private inline function zyZoom():String return getStyle('zoom')
	private inline function zzZoom(v:String):String return setStyle('zoom', v)
	
	public var boxSizing(zyBoxSizing, zzBoxSizing):String;
	private inline function zyBoxSizing():String return getStyle('boxSizing')
	private inline function zzBoxSizing(v:String):String return setStyle('boxSizing',v)
	
	public var textShadow(zyTextShadow, zzTextShadow):String;
	private inline function zyTextShadow():String return getStyle('textShadow')
	private inline function zzTextShadow(v:String):String return setStyle('textShadow',v)
	
	public var outline:String;
	public var outlineOffset:String;
	public var resize:String;//TODO: emulate for browsers without native support

	public var opacity(zyOpacity, zzOpacity):String;
	private inline function zyOpacity():String return getStyle('opacity')
	private inline function zzOpacity(v:String):String return setStyle('opacity', v)

	public var cssFloat(zyFloat, zzFloat):String;
	private inline function zyFloat():String return getStyle('cssFloat')
	private inline function zzFloat(v:String):String return setStyle('cssFloat', v)

	//CSS3 features requiring vendor prefix http://www.css3.info/preview/

	public var transform(zyTransform, zzTransform):String;
	private inline function zyTransform():String return getStyle('transform')
	private inline function zzTransform(v:String):String return setStyle('transform', v)
	
	public var transition(zyTransition, zzTransition):String;
	private inline function zyTransition():String return getStyle('transition')
	private inline function zzTransition(v:String):String return setStyle('transition', v)
	
	public var boxShadow(zyBoxShadow, zzBoxShadow):String;
	private inline function zyBoxShadow():String return getStyle('boxShadow')
	private inline function zzBoxShadow(v:String):String return setStyle('boxShadow',v)
	
	public var borderRadius(zyBorderRadius, zzBorderRadius):String;
	private inline function zyBorderRadius():String return getStyle('borderRadius')
	private inline function zzBorderRadius(v:String):String return setStyle('borderRadius',v)
	
	public var borderImage(zyBorderImage, zzBorderImage):String;
	private inline function zyBorderImage():String return getStyle('borderImage')
	private inline function zzBorderImage(v:String):String return setStyle('borderImage',v)

	public var columnWidth(zyColumnWidth, zzColumnWidth):String;
	private inline function zyColumnWidth():String return getStyle('columnWidth')
	private inline function zzColumnWidth(v:String):String return setStyle('columnWidth', v)

	public var columnGap(zyColumnGap, zzColumnGap):String;
	private inline function zyColumnGap():String return getStyle('columnGap')
	private inline function zzColumnGap(v:String):String return setStyle('columnGap', v)

	public var columnCount(zyColumnCount, zzColumnCount):String;
	private inline function zyColumnCount():String return getStyle('columnCount')
	private inline function zzColumnCount(v:String):String return setStyle('columnCount', v)

	public var columnRule(zyColumnRule, zzColumnRule):String;
	private inline function zyColumnRule():String return getStyle('columnRule')
	private inline function zzColumnRule(v:String):String return setStyle('columnRule', v)

	public var columnSpaceDistribution(zyColumnSpaceDistribution, zzColumnSpaceDistribution):String;
	private inline function zyColumnSpaceDistribution():String return getStyle('columnSpaceDistribution')
	private inline function zzColumnSpaceDistribution(v:String):String return setStyle('columnSpaceDistribution', v)
*/
	
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