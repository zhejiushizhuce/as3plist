/*
 * Licensed under the MIT License
 * 
 * Copyright (c) 2013 zrong
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
import flash.utils.ByteArray;
import mx.utils.Base64Encoder;
import mx.utils.Base64Decoder;
/**
 * Property List Data
 * @author zrong (zengrong.net) 2013-09-14
 */	
public class PData extends PlistElement implements ISimplePlistElement
{
	public static function parse($x:XML):PData
	{
		var __element:PData = new PData();
		__element.xml = $x;
		return __element;
	}
	
	public function PData($value:ByteArray=null)
	{
		init(PlistTags.DATA);
		if($value) object = $value;
	}
	
	override public function get object():*
	{
		if(isDirty || !data)
		{
			var __decoder:Base64Decoder = new Base64Decoder();
			__decoder.decode(x.toString());
			this.data = __decoder.toByteArray();
			isDirty = false;
		}
		return data;
	}
	
	override public function set object($value:*):void
	{
		if($value is ByteArray)
		{
			var __encoder:Base64Encoder = new Base64Encoder();
			__encoder.encodeBytes($value as ByteArray);
			__encoder.flush();
			x.setChildren(__encoder.toString());
		}
		else
		{
			throw new TypeError("The value must be a ByteArray !");
		}
		isDirty = true;
	}
}
}