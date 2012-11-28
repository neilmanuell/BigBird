package bigbird.systems.utils.decoding
{
public class KeyValuePairResultVO
{
    private var _key:XML;
    private var _value:XML;
    private var _stepback:Boolean;
    private var _isNull:Boolean;

    public function KeyValuePairResultVO( key:XML, value:XML, stepback:Boolean, isNull:Boolean = false )
    {
        _key = key;
        _value = value;
        _stepback = stepback;
        _isNull = isNull;
    }

    public function get stepback():Boolean
    {
        return _stepback;
    }

    public function get value():XML
    {
        return _value;
    }

    public function get key():XML
    {
        return _key;
    }

    public function get isNull():Boolean
    {
        return _isNull;
    }
}
}
