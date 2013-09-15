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
 *	Property List Date 
 * @author dai
 * @author zrong(zengrong.net) 2013-09-14
 */	
public class PDate extends PlistElement implements ISimplePlistElement
{
	public static function parse($x:XML):PDate
	{
		var __element:PDate = new PDate();
		__element.xml = $x;
		return __element;
	}
	
	public function PDate($value:Date=null)
	{
		init(PlistTags.DATE);
		this.object = $value ? $value : new Date();
	}

	override public function get object():*
	{
		if(isDirty || !data)
		{
			
			var dateStr:String=x.toString();
			
			var d:Array=dateStr.match(/([\d.,:\-W]+)(?:T([\d.,:\-+WZ]*))?/);
			var dateFormat:String = d[1];
			var timeFormat:String = d[2];
			
			var days:Array = dateFormat.match(/^(\d{2})(?:\-?(\d{2}))?(?:\-?(\d{2}))?(?:\-?(\d{2}))?$/);
			var times:Array = timeFormat.match(/^(\d{2})(?:[,.](\d+)(?=[+\-Z]|$))?(?:\:?(\d{2})(?:[,.](\d+)(?=[+\-Z]|$))?)?(?:\:?(\d{2})(?:[,.](\d+)(?=[+\-Z]|$))?)?(.*)/);
			
			var yyyy:int;
			var mm:int;
			var dd:int;
			var hh:int;
			var nn:int;
			var ss:int;
			
			if (days && days.length > 0) {
				yyyy = days[1] + days[2];
				mm = days[3];
				dd = days[4];
			}
			else
			{
				yyyy = mm = dd = 0;
			}
			
			if (times && times.length > 0) {
				hh = times[1];
				nn = times[3];
				ss = times[5];
			}
			else {
				hh = nn = ss = 0;
			}

			
			var __date:Date=new Date();
			__date.setUTCFullYear(yyyy,mm-1,dd);
			__date.setUTCHours(hh, nn, ss, 0);
			this.data = __date;
			isDirty = false;
		}
		return data;
	}
	
	override public function set object($value:*):void
	{
		if($value is Date)
		{
			x.setChildren(($value as Date).toString());
		}
		else
		{
			throw new TypeError("The value must be a Date !");
		}
		isDirty = true;
	}
}
}