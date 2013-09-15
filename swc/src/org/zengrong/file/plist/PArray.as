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
/**
 *Property List Array 
 * @author dai
 * @author zrong(zengrong.net) 2013-09-14
 * 
 */	
public class PArray extends PlistElement
{
	public static function parse($x:XML):PArray
	{
		var __element:PArray = new PArray();
		__element.xml = $x;
		return __element;
	}
	
	public function PArray($array:Array=null)
	{
		init(PlistTags.ARRAY);
		if($array && $array.length > 0) object = $array;
	}
	
	override public function get object():*
	{
		if(isDirty || !data)
		{
			var i:uint;
			var length:uint=x.*.length();
			this.data = new Array();
			for(i=0;i<length;i++)
			{
				this.data.push(ParseUtils.valueFromXML(x.*[i]));
			}
			isDirty = false;
		}
		return data;
	}
	
	public function addValue(...$values:*):PArray
	{
		for (var i:int = 0; i < $values.length; i++) 
		{
			var __element:PlistElement = ParseUtils.valueToElement($values[i]);
			x.appendChild(__element.xml);
		}
		isDirty = true;
		return this;
	}
	
	override public function set object($value:*):void
	{
		if($value is Array)
		{
			var __arr:Array = $value as Array;
			for (var i:int = 0; i < __arr.length; i++) 
			{
				addValue(__arr[i]);
			}
		}
		else
		{
			throw new TypeError("The value must be a Array !");
		}
		isDirty = true;
	}
}
}