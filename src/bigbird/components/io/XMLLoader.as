package bigbird.components.io {
import flash.events.ErrorEvent;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.SecurityErrorEvent;
import flash.net.URLLoader;
import flash.net.URLRequest;

public class XMLLoader implements DataLoader {

    private const _wordXMLParser:WordXMLParser = new WordXMLParser();

    public function XMLLoader(request:URLRequest) {
        _url = request.url;
        _loader = new URLLoader(request);
        _loader.addEventListener(Event.COMPLETE, onComplete);
        _loader.addEventListener(IOErrorEvent.IO_ERROR, onError);
        _loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onError);
    }

    private var _loader:URLLoader;

    private var _url:String;

    public function get url():String {
        return _url;
    }

    public function get success():Boolean {
        return (_error == null);
    }

    private var _error:*;

    public function get error():* {
        return _error;
    }

    private var _isLoadComplete:Boolean;

    public function get isLoadComplete():Boolean {
        return _isLoadComplete;
    }

    public function get bytesLoaded():uint {
        return _loader.bytesLoaded;
    }

    public function get bytesTotal():uint {
        return _loader.bytesTotal;
    }

    public function get data():XML {
        return _wordXMLParser.data
    }

    public function destroy():void {
        removeListeners();
        _loader = null;
    }

    private function removeListeners():void {
        _loader.removeEventListener(Event.COMPLETE, onComplete);
        _loader.removeEventListener(IOErrorEvent.IO_ERROR, onError);
        _loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onError);
    }

    private function onError(event:ErrorEvent):void {
        _error = event;
        _isLoadComplete = true;
        removeListeners();
    }

    private function onComplete(event:Event):void {
        _isLoadComplete = true;

        try {
            _wordXMLParser.convert(_loader.data);
        }
        catch (error:WordNamespaceError) {
            _error = error;
        }
        finally {
            removeListeners();
        }


    }


}
}
