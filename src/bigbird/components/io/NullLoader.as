package bigbird.components.io
{
import flash.net.URLRequest;

public class NullLoader implements DataLoader
{
    public function NullLoader( request:URLRequest )
    {
        _url = request.url;
    }

    private var _url:String;

    public function get url():String
    {
        return _url;
    }

    public function get bytesLoaded():uint
    {
        return 0;
    }

    public function get bytesTotal():uint
    {
        return 0;
    }

    public function get isLoadComplete():Boolean
    {
        return true;
    }

    public function get success():Boolean
    {
        return false;
    }

    public function get data():XML
    {
        return new XML();
    }
}
}
