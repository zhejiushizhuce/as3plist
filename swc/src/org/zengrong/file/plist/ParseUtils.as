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
/**
 *	Useful Utility for parsing data 
 * @author dai
 * @author zrong(zengrong.net) 2013-09-14
 */	
public class ParseUtils
{
	static public function valueToElement($value:*):PlistElement
	{
		if($value is PlistElement) return $value as PlistElement;
		var __element:PlistElement; 
		if($value is int || $value is Number)
		{
			__element = new PNumber($value as Number);
		}
		else if($value is String)
		{
			__element = new PString($value as String);
		}
		else if($value is Boolean)
		{
			__element = new PBoolean($value as Boolean);
		}
		else if($value is Date)
		{
			__element = new PDate($value as Date);
		}
		else if($value is Array)
		{
			__element = new PArray($value as Array);
		}
		else if($value is Dictionary)
		{
			__element = new PDict($value as Dictionary);
		}
		return __element;
	}
	
	static public function valueFromXML(node:XML):PlistElement
	{
		var val:PlistElement;

		switch(node.name().toString())
		{
			case PlistTags.ARRAY:
				val=PArray.parse(node);
				break;
			case PlistTags.DICT:
				val=PDict.parse(node);
				break;
			case PlistTags.DATE:
				val=PDate.parse(node);
				break;
			case PlistTags.DATA:
				val = PData.parse(node);
				break;
			case PlistTags.STRING:
				val=PString.parse(node);
				break;
			case PlistTags.TRUE: 
			case PlistTags.FALSE:
				val=PBoolean.parse(node);
				break;
			case PlistTags.REAL:
			case PlistTags.INTEGER:
				val=PNumber.parse(node);
		}
		return val;
	}
}
}