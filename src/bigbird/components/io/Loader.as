package bigbird.components.io
{
import bigbird.factories.getDataLoader;

import flash.net.URLRequest;

public class Loader implements DataLoader

{

    private var _client:DataLoader;

    public function Loader( request:URLRequest, factory:Function = null ):void
    {
        const factoryMethod:Function = ( factory == null) ? getDataLoader : factory;
        _client = factoryMethod( request );
    }

    public function get bytesLoaded():uint
    {
        return _client.bytesLoaded;
    }

    public function  get bytesTotal():uint
    {
        return _client.bytesTotal;
    }

    public function get isLoadComplete():Boolean
    {
        return _client.isLoadComplete;
    }

    public function get success():Boolean
    {
        return _client.success;
    }

    public function get data():XML
    {
        return _client.data;
    }


}
}
