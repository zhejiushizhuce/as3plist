package org.zengrong.file.zwoptex
{
import mx.utils.object_proxy;

import org.zengrong.file.plist.PDict;
import org.zengrong.file.plist.Plist10;
import org.zengrong.file.plist.PlistTags;

/**
 * Save a Zwoptex file in format 2
 * @author zrong(zengrong.net)
 * Creation: 2013-09-22
 */
public class ZwoptexFormat2File extends Plist10
{
	public static const KEY_FRAMES:String = "frames";
	public static const KEY_METADATA:String = "metadata";
	
	public function ZwoptexFormat2File()
	{
		super();
		init();
	}
	
	private var _frames:PDict;

	public function get frames():PDict
	{
		return _frames;
	}

	private var _metadata:ZwoptexFormat2Metadata;

	public function get metadata():ZwoptexFormat2Metadata
	{
		return _metadata;
	}

	private function init():void
	{
		_frames = new PDict();
		_metadata = new ZwoptexFormat2Metadata();
		var __root:PDict = new PDict();
		__root.addValue(KEY_FRAMES, _frames);
		__root.addValue(KEY_METADATA, _metadata);
		this.root = __root;
	}
	
	public function addFrame($name:String, $frame:ZwoptexFormat2Frame):ZwoptexFormat2File
	{
		_frames.addValue($name, $frame);
		return this;
	}
	
	public function setRealTextureFileName($fileName:String):ZwoptexFormat2File
	{
		_metadata.setRealTextureFileName($fileName);
		return this;
	}
	
	public function setTextureFileName($fileName:String):ZwoptexFormat2File
	{
		_metadata.setTextureFileName($fileName);
		return this;
	}
	
	public function setSize($width:int, $height:int):ZwoptexFormat2File
	{
		_metadata.setSize($width, $height);
		return this;
	}
	
	override protected function parseXML():void
	{
		if(	!x[PlistTags.DICT] ||
			!x[PlistTags.DICT][KEY_FRAMES] ||
			!x[PlistTags.DICT][KEY_METADATA])
		{
			throw TypeError("You must provide a Zwoptex file in format 2!");
		}
		else
		{
			super.parseXML();
			_frames = this.root[KEY_FRAMES];
			_metadata = this.root[KEY_METADATA];
		}
	}
}
}