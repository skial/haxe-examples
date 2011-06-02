/**
 * ...
 * @author Cref
 */

package hxtc.orm;

enum Filter<T> {
	group(value:Array<Filter<Dynamic>>,and:Bool);
	not(value:Filter<Dynamic>);
	isInQuery(s1:Selectable<T>, s2:Selectable<T>, filter:Filter<Dynamic>, order:Array<Order>, limit:Int, distinct:Bool,tmpForceWhere:Bool);
	isIn(s:Selectable<T>, arr:Iterable<T>);
	compare(s1:Selectable<T>, operator:String, s2:Selectable<T>);
}