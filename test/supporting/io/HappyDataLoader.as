package supporting.io
{
import bigbird.components.io.DataLoader;

import flash.events.ErrorEvent;
import flash.net.URLRequest;

import supporting.values.DOCUMENT_SINGLE_KEY_VALUE_PAIR_XML;

public class HappyDataLoader implements DataLoader
{
    private var _url:String;

    public function HappyDataLoader( request:URLRequest )
    {
        _url = request.url;
    }

    public function get isLoadComplete():Boolean
    {
        return true;
    }

    public function get data():XML
    {
        return DOCUMENT_SINGLE_KEY_VALUE_PAIR_XML;
    }

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

    public function get success():Boolean
    {
        return true;
    }

    public function destroy():void
    {
    }

    public function get error():ErrorEvent
    {
        return new ErrorEvent( "Null Error Event" );
    }
}
}
