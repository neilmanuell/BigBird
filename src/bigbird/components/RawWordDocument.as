package bigbird.components
{
public class RawWordDocument
{

    public var rawData:XML;
    public var name:String;
    public var wNS:Namespace;

    private var _cellData:XMLList;
    private var _length:int = 0;
    private var _count:int = 0;

    public function RawWordDocument( name:String, rawData:XML )
    {
        this.name = name;
        setData( rawData );
    }

    public function setData( rawData:XML ):void
    {
        this.rawData = rawData;
        if ( this.rawData != null )
        {
            this.wNS = rawData.namespace( "w" );
            _cellData = rawData..wNS::tc;
            _length = _cellData.length();
        }
    }

    public function get hasNext():Boolean
    {
        return (_count < _length);
    }

    public function get position():int
    {
        return _count;
    }

    public function get length():int
    {
        return _length;
    }

    public function getNext():XML
    {
        return  _cellData[_count++];
    }

    public function stepback():void
    {
        _count--;
    }


}
}
