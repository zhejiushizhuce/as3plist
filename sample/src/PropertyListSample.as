package 
{
import flash.display.BitmapEncodingColorSpace;
import flash.display.Sprite;
import flash.events.Event;
import mx.graphics.shaderClasses.LuminosityMaskShader_ShaderClass;
import net.tautausan.plist.PArray;
import net.tautausan.plist.PBoolean;
import net.tautausan.plist.PDict;
import net.tautausan.plist.Plist;
import net.tautausan.plist.Plist10;
import net.tautausan.plist.PlistElement;
import net.tautausan.plist.PNumber;
import net.tautausan.plist.PString;
//import org.zengrong.file.PropertyList;

/**
 * 
 * @author zrong
 */
public class PropertyListSample extends Sprite 
{
	[Embed(source="ali.plist",mimeType="application/octet-stream")] 
	public static const ABOUT_TEXT:Class;

	[Embed(source="Flower.plist",mimeType="application/octet-stream")] 
	public static const FLOWER_TEXT:Class;
	
	public function PropertyListSample():void 
	{
		if (stage) init();
		else addEventListener(Event.ADDED_TO_STAGE, init);
	}
	
	private function init(e:Event = null):void 
	{
		removeEventListener(Event.ADDED_TO_STAGE, init);
		//var __xml:XML = new XML(new ABOUT_TEXT().toString());
		
		//var __obj:Object = PropertyList.parse(__xml);
		
		//var __xml2:XML = new XML(new FLOWER_TEXT().toString());
		
		//trace(__xml2.toXMLString());
		//var __obj2:Object = PropertyList.parse(__xml2);
		
		//trace("obj:", __obj);
		
		var __plist:Plist10 = new Plist10();
		__plist.parse(new ABOUT_TEXT().toString());
		//trace(__plist.toString());
		
		//for( var __key:String in __plist.root.frames.object)
		//{
			//trace("key:", __key);
			//trace("value:", __plist.root.frames[__key].xml);
		//}
		
		var __olist:Plist10  = new Plist10();

		var __parr:PArray = new PArray();
		var __pnum:PNumber = new PNumber();
		__pnum.object = 3;
		var __pstring:PString = new PString();
		__pstring.object = "hello";
		var __pbool:PBoolean = new PBoolean();
		__pbool.object = true;
		
		__parr.addValue(__pnum, __pbool, __pstring);
		__parr.addValue(new PArray().addValue(3, 4, 5, 7));
		__parr.addValue(new PDict().addValue("name", new PNumber()));
		//trace(__parr.toXMLString());
		__olist.root = __parr;
		trace(__olist.toString());
		
		var __alist:Plist10 = new Plist10();
		__alist.parse(__olist.toString());
		trace("-----");
		trace(__alist.toString());
		
		//var __obj:Object = __plist.root.frames["parts-ali_bianzi.png"]
		//trace(__plist.root.frames["parts-ali_bianzi.png"].object);

	}
}
}