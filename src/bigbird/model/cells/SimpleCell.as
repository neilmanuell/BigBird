package bigbird.model.cells
{
import utils.string.removeExtraWhitespace;

public class SimpleCell implements ICell
{
    private var _colour:uint;
    private var _content:String;
    private var _rawData:XML;

    public function get colour():uint
    {
        return _colour;
    }

    public function get content():String
    {
        return  _content;
    }

    public function get rawData():XML
    {
        return _rawData;
    }

    public function decode( xml:XML, wNS:Namespace ):void
    {
        _colour = extractColour( xml, wNS );
        _content = extractContent( xml, wNS );
        _rawData = xml;
    }

    private function extractColour( xml:XML, wNS:Namespace ):uint
    {
        var c:String;
        c = xml.wNS::tcPr.wNS::shd.@wNS::color;
        if ( c == "auto" )c = xml.wNS::tcPr.wNS::shd.@wNS::fill;
        return uint( "0x" + c );
    }

    private function extractContent( xml:XML, wNS:Namespace ):String
    {
        var s:String = "";
        var content:XMLList = xml.wNS::p.wNS::r.wNS::t;
        for each( var node:XML in content )
            s += node.text();
        return removeExtraWhitespace( s );
    }
}
}