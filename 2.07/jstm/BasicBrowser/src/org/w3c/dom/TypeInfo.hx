/**
 * ...
 * @author Cref
 */

package org.w3c.dom;

interface TypeInfo {
  var typeName(default,never):String;
  var typeNamespace(default,never):String;
  function isDerivedFrom(typeNamespaceArg:String, typeNameArg:String, derivationMethod:DerivationMethod):Bool;
}