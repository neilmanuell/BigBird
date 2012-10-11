package bigbird.core
{
import bigbird.components.KeyCell;
import bigbird.components.ValueCell;

public class KeyValuePair
{
    private var _key:KeyCell;
    private var _value:ValueCell;

    public function KeyValuePair( key:KeyCell, value:ValueCell )
    {
        _key = key;
        _value = value;
    }

    public function get colour():uint
    {
        return _key.colour;
    }

    public function get label():String
    {
        return _key.label;
    }

    public function get content():String
    {
        return _value.content;
    }

    public function getPrecis( len:int = 20 ):String
    {
        return (_value.content.length <= len ) ? _value.content.slice( 0, len ) + "..." : _value.content;
    }

    public function toString():String
    {
        return "[KeyValuePair(colour:" + colour + ",label:" + label + ",content:" + getPrecis() + ")]";
    }
}
}
