package bigbird.components.io
{
import bigbird.factories.getDataLoader;
import bigbird.values.ERROR_XML;

import flash.events.ErrorEvent;
import flash.net.URLRequest;

public class Loader implements DataLoader

{

    private var _client:DataLoader;

    public function Loader( request:URLRequest, factory:Function = null ):void
    {
        const factoryMethod:Function = ( factory == null) ? getDataLoader : factory;
        _client = factoryMethod( request );
    }

    public function get url():String
    {
        return _client.url;
    }

    public function get error():ErrorEvent
    {
        return _client.error;
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
        if ( success )
            return _client.data;

        else
        {
            const error:XML = ERROR_XML.copy();
            error.type = _client.error.type;
            error.message = _client.error.toString();
            return error;
        }

    }


    public function destroy():void
    {
        _client.destroy();
    }


}
}
