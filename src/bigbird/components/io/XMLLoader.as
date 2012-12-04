package bigbird.components.io
{
import flash.events.ErrorEvent;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.SecurityErrorEvent;
import flash.net.URLLoader;
import flash.net.URLRequest;

public class XMLLoader implements DataLoader
{
    private var _url:String;

    public function XMLLoader( request:URLRequest )
    {
        _url = request.url;
        _loader = new URLLoader( request );
        _loader.addEventListener( Event.COMPLETE, onComplete );
        _loader.addEventListener( IOErrorEvent.IO_ERROR, onError );
        _loader.addEventListener( SecurityErrorEvent.SECURITY_ERROR, onError );
    }

    private var _loader:URLLoader;

    public function get success():Boolean
    {
        return (_error == null);
    }

    private var _error:ErrorEvent;

    public function get error():ErrorEvent
    {
        return _error;
    }

    private var _isLoadComplete:Boolean;

    public function get isLoadComplete():Boolean
    {
        return _isLoadComplete;
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
        XML.ignoreWhitespace = false;
        const out:XML = new XML( _loader.data );
        out.normalize();
        XML.ignoreWhitespace = true;
        return out;
    }

    public function get url():String
    {
        return _url;
    }


    private function removeListeners():void
    {
        _loader.removeEventListener( Event.COMPLETE, onComplete );
        _loader.removeEventListener( IOErrorEvent.IO_ERROR, onError );
        _loader.removeEventListener( SecurityErrorEvent.SECURITY_ERROR, onError );
    }

    private function onError( event:ErrorEvent ):void
    {
        _error = event;
        _isLoadComplete = true;
        removeListeners();
    }

    private function onComplete( event:Event ):void
    {
        _isLoadComplete = true;
        removeListeners();
    }

    public function destroy():void
    {
        removeListeners();
        _loader = null;
    }


}
}
