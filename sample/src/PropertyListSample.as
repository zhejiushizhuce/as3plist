package 
{
import flash.display.Sprite;
import flash.events.Event;
import org.zengrong.file.plist.*;
import org.zengrong.file.zwoptex.ZwoptexFormat2File;
import org.zengrong.file.zwoptex.ZwoptexFormat2Frame;
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
		trace("-----zwoptex");
		
		//var __obj:Object = __plist.root.frames["parts-ali_bianzi.png"]
		//trace(__plist.root.frames["parts-ali_bianzi.png"].object);
		
		var __zwoptex2:ZwoptexFormat2File = new ZwoptexFormat2File();
		var __frame:ZwoptexFormat2Frame = new ZwoptexFormat2Frame();
		__frame.setOffset(0, 0).setRotated(false).setSourceColorRect(0, 0, 100, 100).setSourceSize(100, 100).setFrame(50, 50, 100, 100);
		__zwoptex2.setSize(100, 100).setRealTextureFileName("abc.png").setTextureFileName("abc.png").addFrame("test01", __frame);
		trace(__zwoptex2.toString());

	}
}
}