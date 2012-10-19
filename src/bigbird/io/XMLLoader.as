package bigbird.io
{
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.SecurityErrorEvent;
import flash.net.URLLoader;
import flash.net.URLRequest;

public class XMLLoader implements Loader
{
    private var _loader:URLLoader;
    private var _errorMsg:String;

    public function XMLLoader( request:URLRequest )
    {
        _loader = new URLLoader( request );
        _loader.addEventListener( IOErrorEvent.IO_ERROR, onError );
        _loader.addEventListener( SecurityErrorEvent.SECURITY_ERROR, onError );
    }

    private function onError( event:Event ):void
    {
        _errorMsg = event.toString();
        destroy();
    }

    public function get bytesLoaded():uint
    {
        return _loader.bytesLoaded;
    }

    public function get bytesTotal():uint
    {
        return _loader.bytesTotal;
    }

    public function get data():XML
    {
        destroy();
        return new XML( _loader.data );
    }

    private function destroy():void
    {
        _loader.removeEventListener( IOErrorEvent.IO_ERROR, onError );
        _loader.removeEventListener( SecurityErrorEvent.SECURITY_ERROR, onError );
        _loader = null;
    }

    public function get errorMsg():String
    {
        return _errorMsg;
    }

    public function get success():Boolean
    {
        return (_errorMsg == null);
    }
}
}
