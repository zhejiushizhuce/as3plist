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
import flash.utils.Dictionary;
import flash.utils.flash_proxy;
use namespace flash_proxy;
/**
 * Property List Dictionary 
 * @author dai
 * @author zrong(zengrong.net) 2013-09-14
 */	
dynamic public class PDict extends PlistElement
{
	public static function parse($x:XML):PDict
	{
		var __element:PDict = new PDict();
		__element.xml = $x;
		return __element;
	}
	
	public function PDict($value:Dictionary=null)
	{
		init(PlistTags.DICT);
	}
	
	override flash_proxy function setProperty($name:*, $value:*):void
	{
		addValue($name, $value);
	}
	
	override public function get object():*
	{
		if(isDirty || !data)
		{
			this.data = new Dictionary();
			var __key:XML;
			var __node:XML;
			for each(__node in x.*)
			{
				if(__node.name()==PlistTags.KEY)
				{
					__key=__node;
				}
				else
				{
					if(__key)
					{
						this.data[__key]=ParseUtils.valueFromXML(__node);
					}
				}
			}
			isDirty = false;
		}
		return this.data;
	}
	
	public function addValue($key:String, $value:*):PDict
	{
		var __element:PlistElement = ParseUtils.valueToElement($value);
		var __keyxml:XML = new XML("<" + PlistTags.KEY + "/>");
		__keyxml.setChildren($key);
		x.appendChild(__keyxml);
		x.appendChild(__element.xml);
		isDirty = true;
		return this;
	}
	
	override public function set object($value:*):void
	{
		if($value is Dictionary)
		{
			var __dict:Dictionary = $value as Dictionary;
			for(var __key:String in __dict)
			{
				addValue(__key, __dict[__key]);
			}
		}
		else
		{
			throw new TypeError("The value must be a Dictionary !");
		}
		isDirty = true;
	}
}
}