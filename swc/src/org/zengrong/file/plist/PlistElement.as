/*
 * Licensed under the MIT License
 * 
 * Copyright (c) 2008 Daisuke Yanagi
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
 package org.zengrong.file.plist
{
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	
	/**
	 *	Foundation of all Property List Elements 
	 * @author dai
	 * @author zrong(zengrong.net)
	 */		
	public class PlistElement extends Proxy
	{
		protected var x:XML;
		protected var data:*;
		
		protected var isDirty:Boolean = true;
		
		//public function PlistElement($x:XML)
		//{
			//this.xml = $x;
		//}
		public function PlistElement()
		{
		}
		
		protected function init($plistTag:String):void
		{
			this.x = new XML("<" + $plistTag + "/>");
		}
		
		override flash_proxy function getProperty(name:*):* 
		{
			var __data:* = object;
			if(__data && __data[name])
			{
				return __data[name];
			}
			return null;
		}
		
		override flash_proxy function callProperty(name:*, ... rest):*
		{
			var __data:* = object;
			if(!__data ) return "";
			
			if(rest.length<1)
			{
				return __data[name]();
			}
			return __data[name](rest);
		}
		
		public function toXMLString():String
		{
			return x.toXMLString();
		}
		
		public function toString():String
		{
			return x.toString();
		}
		
		public function set xml(x:XML):void
		{
			this.x = x;
			isDirty = true;
		}
		
		public function get xml():XML
		{
			return this.x;
		}
		
		public function get object():*
		{
			return this.data;
		}
		
		public function set object($value:*):void
		{
			this.data = $value;
		}
		
		public function get isSimple():Boolean
		{
			return this is ISimplePlistElement;
		}
	}
}