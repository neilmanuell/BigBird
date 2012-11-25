package bigbird.core.vos
{
import bigbird.components.io.DataLoader;

public class DataLoaderVO
{
    private var _data:DataLoader;

    public function DataLoaderVO( data:DataLoader )
    {
        _data = data;
    }

    public function get url():String
    {
        return _data.url;
    }

    public function get success():Boolean
    {
        return _data.success;
    }

    public function get data():XML
    {
        return _data.data;
    }


}
}
