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
 package net.tautausan.plist
{
/**
 *	Property List ver 1.0 
 * @author dai
 * @author zrong(zengrong.net) 2013-09-14
 */	
public class Plist10 extends Plist
{
	protected var data:PlistElement;
	protected static const XML_HEADER:String = '<?xml version="1.0" encoding="UTF-8"?>\n<!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">\n';
	
	public function Plist10()
	{
		super();
	}
	
	private var isDirty:Boolean = true;
	
	public function get root():PlistElement
	{
		return data;
	}
	
	public function set root($value:PlistElement):void
	{
		data = $value;
		x = <plist/>;
		x.@version = "1.0";
		x.appendChild(data.xml);
		//if($value is PDict || $value is PArray)
		//{
			//data = $value;
		//}
		//else
		//{
			//throw TypeError("You must provide a PDict or PArray !");
		//}
	}
	
	override public function toXMLString():String
	{
		if(this.x) return this.x.toXMLString();
		return "";
	}
	
	override public function toString():String
	{
		var __xmlstr:String = toXMLString();
		if(__xmlstr) return XML_HEADER + __xmlstr;
		return "";
	}
	
	override public function parse(xmlStr:String):void
	{
		x = new XML(xmlStr);
		parseXML();
	}
	
	override public function set xml($x:XML):void
	{
		super.xml = $x;
		parseXML();
		
	}
	
	private function parseXML():void
	{
		if(x.localName() != PlistTags.PLIST)
		{
			throw TypeError("You must provide a plist file!");
		}
		if(x[PlistTags.DICT])
		{
			var __x:* = x.child(0);
			data = PDict.parse(x.child(0)[0]);
		}
		else if(x[PlistTags.ARRAY])
		{
			data = PArray.parse(x.child(0)[0]);
		}
		else
		{
			data = ParseUtils.valueFromXML(x.child(0));
		}
	}
}
}