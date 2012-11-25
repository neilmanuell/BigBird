package supporting.io
{
import bigbird.components.io.Loader;

import flash.events.ErrorEvent;
import flash.net.URLRequest;

public class AngryDataLoader extends Loader
{
    private var _url:String;

    public function AngryDataLoader( request:URLRequest )
    {
        super( request );
        _url = request.url;
    }


    public override function get isLoadComplete():Boolean
    {
        return true;
    }


    public override function get success():Boolean
    {
        return false;
    }

    public override function get url():String
    {
        return _url;
    }

    public override function get error():ErrorEvent
    {
        return new ErrorEvent( "TEST", false, false, "Test ErrorEvent" );
    }


}
}
