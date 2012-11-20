package bigbird.components.io
{
import flash.net.URLRequest;

public class DOCXLoader implements DataLoader
{

    public function DOCXLoader( request:URLRequest )
    {

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
        return false;
    }

    public function get success():Boolean
    {
        return false;
    }

    public function get data():XML
    {
        return null;
    }
}
}
