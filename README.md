# Original project

* In Google Code: <http://code.google.com/p/as3plist/>
* In Github: <https://github.com/f60k/as3plist>

# Build the swc file

1. open this file: `swc/build.properties`, and modify FLEX_HOME ;
2. `ant` 
   
# Introduction
This is a small library to use plist files for flash contents.

Details
Features list

XML based property list support
plist 1.0 support
access properties directly using dot syntax
Binary based property list support (tentative)

# Getting Started
1. load plist file with URLLoader and prepare to capture event from URLLoader.

```actionscript
public function init():void
{
        var loader:URLLoader=new URLLoader(new URLRequest("sample.plist"));
        loader.addEventListener(Event.COMPLETE, onComplete);
}
```

2. create an instace and use parse() method with loaded data. That's all.

```actionscript
private function onComplete(e:Event):void
{
        var plist:Plist10=new Plist10();
        plist.parse(e.target.data);
        
}
```

# For Binary Format

Invoke getXML method before parse loaded data within onComplete method.

```actionscript
public function init():void
{
        var loader:URLLoader=new URLLoader(new URLRequest("sample_bin.plist"));
        loader.dataFormat = URLLoaderDataFormat.BINARY;
        loader.addEventListener(Event.COMPLETE, onComplete);
}
private function onComplete(e:Event):void
{
        var plist:Plist10=new Plist10();
        plist.parse(Bin2Xml.getXML(e.target.data));
        
}
```

# Access Plist Node Value #

## Get value

Use 'parent dot child' to reach parent's child element.

	trace(plist.root.false_key); //false

## You want XMLList?

Use reserved keyword named 'xml' to get its own XMLList object.

	trace(plist.root.arr_key[0].arr_child_dic); // null
	trace(plist.root.arr_key[0].xml); //<dict><key>arr_child_dic</key><string>null</string></dict>

You should use toXMLString() for no collective types because they will be converted to string automatically.

	trace(plist.root.false_key.xml); //false_key (toString() works silently)
	trace(plist.root.false_key.xml.toXMLString()); //<key>false_key</key>

## Use .object property

Reserved word 'object' is useful to view whole object created from XML.

## parsed from XML below.

```xml
<key>arr_key</key>
<array>
        <string>111111</string>
        <string>222222</string>
</array>
```

## sample using .object property

```actionscript
trace(plist.root.arr_key); //11111,22222
trace(plist.root.arr_key[0]); //11111
trace(plist.root.arr_key.object); //11111,22222
```

## Node Exists or not?

All elements are derived from PlistElement class and you can check if they exists or not using 'is'.

```actionscript
trace(plist.root.dic_key);
trace(plist.root.dic_key is PlistElement);//true
trace(plist.root.dic_key2);
trace(plist.root.dic_key2 is PlistElement);//false
```

## Type of nodes

You should check the type of object property of node when you want to know the type of node.

```actionscript
trace(plist.root.arr_key is Array); //false
trace(plist.root.arr_key.object is Array); //true
```

sample.plst

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
        <key>New item</key>
        <data>
        </data>
        <key>arr_key</key>
        <array>
                <dict>
                        <key>arr_child_dic</key>
                        <string>null</string>
                </dict>
                <string>str_data</string>
                <true/>
                <integer>0</integer>
                <array>
                        <string>111111</string>
                        <string>222222</string>
                </array>
        </array>
        <key>date_key</key>
        <date>2008-07-18T13:35:27Z</date>
        <key>dic_key</key>
        <dict>
                <key>child_key</key>
                <string>dic_child_data</string>
        </dict>
        <key>false_key</key>
        <false/>
        <key>num_key</key>
        <integer>0</integer>
        <key>num_key_2</key>
        <real>0.23011999999999999</real>
        <key>str_key</key>
        <string>Hello</string>
        <key>true_key</key>
        <true/>
</dict>
</plist>
```
# CDATA

CDATA directive is useful to write html tags in xml. You do not have to care about escape strings.

	<string>&lt;a href=&quot;http://www.google.com&quot;&gt;hello&lt;/a&gt;</string>
	<string><![CDATA[<a href="http://www.google.com">hello</a>]]></string>
