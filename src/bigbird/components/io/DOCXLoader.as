package bigbird.components.io
{
import deng.fzip.FZip;

import flash.events.ErrorEvent;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.net.URLRequest;

public class DOCXLoader implements DataLoader
{
    private static const DOCUMENT_XML_PATH:String = "word/document.xml";

    private var _fzip:FZip;
    private var _error:ErrorEvent;
    private var _isLoadComplete:Boolean;
    private var _bytesTotal:uint;
    private var _bytesLoaded:uint;
    private var _url:String;

    public function DOCXLoader( request:URLRequest )
    {
        _url = request.url;
        _fzip = new FZip();
        _fzip.addEventListener( Event.COMPLETE, onComplete );
        _fzip.addEventListener( IOErrorEvent.IO_ERROR, onError );
        _fzip.addEventListener( ProgressEvent.PROGRESS, onProgress );
        _fzip.load( request );
    }

    private function onProgress( event:ProgressEvent ):void
    {
        _bytesTotal = event.bytesTotal;
        _bytesLoaded = event.bytesLoaded;
    }

    public function get bytesLoaded():uint
    {
        return _bytesLoaded;
    }

    public function get error():ErrorEvent
    {
        return _error;
    }

    public function get bytesTotal():uint
    {
        return _bytesTotal
    }

    public function get isLoadComplete():Boolean
    {
        return _isLoadComplete;
    }

    public function get success():Boolean
    {
        return (_error == null);
    }

    public function get data():XML
    {
        const d:String = _fzip.getFileByName( DOCUMENT_XML_PATH ).getContentAsString();
        return new XML( d );
    }

    public function get url():String
    {
        return _url;
    }

    private function onError( event:ErrorEvent ):void
    {
        _error = event;
        _isLoadComplete = true;
        removeListeners();
    }

    private function removeListeners():void
    {
        _fzip.removeEventListener( Event.COMPLETE, onComplete );
        _fzip.removeEventListener( IOErrorEvent.IO_ERROR, onError );
        _fzip.removeEventListener( ProgressEvent.PROGRESS, onProgress );
    }

    private function onComplete( event:Event ):void
    {
        _isLoadComplete = true;
        removeListeners();
    }

    public function destroy():void
    {
        removeListeners();
        _fzip = null;
    }
}
}
