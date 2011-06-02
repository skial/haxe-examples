/**
 * ...
 * @author Cref
 */

package org.w3c.dom;

interface UserDataHandler<TNode> {
  function handle(operation:OperationType, key:String, data:DOMUserData, src:TNode, dst:TNode):Void;
}