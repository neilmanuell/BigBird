package bigbird.components.io
{
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.SecurityErrorEvent;
import flash.net.URLLoader;
import flash.net.URLRequest;

public class XMLLoader implements DataLoader
{
    public function XMLLoader( request:URLRequest )
    {
        _loader = new URLLoader( request );
        _loader.addEventListener( Event.COMPLETE, onComplete );
        _loader.addEventListener( IOErrorEvent.IO_ERROR, onError );
        _loader.addEventListener( SecurityErrorEvent.SECURITY_ERROR, onError );
    }

    private var _loader:URLLoader;

    public function get success():Boolean
    {
        return (_errorMsg == null);
    }

    private var _errorMsg:String;

    public function get errorMsg():String
    {
        return _errorMsg;
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
        return new XML( _loader.data );
    }

    private function destroyLoader():void
    {
        _loader.removeEventListener( Event.COMPLETE, onComplete );
        _loader.removeEventListener( IOErrorEvent.IO_ERROR, onError );
        _loader.removeEventListener( SecurityErrorEvent.SECURITY_ERROR, onError );
        _loader = null;
    }

    private function onError( event:Event ):void
    {
        _errorMsg = event.toString();
        _isLoadComplete = true;
        destroyLoader();
    }

    private function onComplete( event:Event ):void
    {
        _isLoadComplete = true;
        destroyLoader();
    }

}
}
