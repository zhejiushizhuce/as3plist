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
package org.zengrong.file.zwoptex
{
import flash.utils.Dictionary;

import org.zengrong.file.plist.PDict;

/**
 * Save a Zwoptex frame info in format2
 * @author zrong
 * Creation: 2013-09-22
 */ 
public class ZwoptexFormat2Frame extends PDict
{
	public function ZwoptexFormat2Frame($value:Dictionary=null)
	{
		super($value);
	}
	
	public function setFrame($frameX:int, $frameY:int, $frameWidth:int, $frameHeight:int):ZwoptexFormat2Frame
	{
		this.addValue("frame", "{{"+$frameX+","+$frameY+"},{"+$frameWidth+","+$frameHeight+"}}");
		return this;
	}
	
	public function setOffset($offsetX:int, $offsetY:int):ZwoptexFormat2Frame
	{
		this.addValue("offset", "{"+$offsetX+","+$offsetY+"}");
		return this;
	}
	
	public function setRotated($rotated:Boolean):ZwoptexFormat2Frame
	{
		this.addValue("rotated", $rotated);
		return this;
	}
	
	public function setSourceColorRect($sourceX:int, $sourceY:int, $sourceWidth:int, $sourceHeight:int):ZwoptexFormat2Frame
	{
		this.addValue("sourceColorRect", "{{"+$sourceX+","+$sourceY+"},{"+$sourceWidth+","+$sourceHeight+"}}");
		return this;
	}
	
	public function setSourceSize($sizeX:int, $sizeY:int):ZwoptexFormat2Frame
	{
		this.addValue("sourceSize", "{"+$sizeX+","+$sizeY+"}");
		return this;
	}
}
}