package bigbird.core.vos
{
import bigbird.components.KeyCell;
import bigbird.components.ValueCell;

public class KeyValuePairVO
{
    private var _key:KeyCell;
    private var _value:ValueCell;

    public function KeyValuePairVO( key:KeyCell, value:ValueCell )
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
        return (_value.content.length <= len ) ? _value.content : _value.content.slice( 0, len ) + "...";
    }

    public function toString():String
    {
        return "[KeyValuePair(colour:" + colour + ",label:" + label + ",content:" + getPrecis() + ")]";
    }
}
}
