package bigbird.components.io {
import deng.fzip.FZip;

import flash.events.ErrorEvent;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.net.URLRequest;

public class DOCXLoader implements DataLoader {
    private static const DOCUMENT_XML_PATH:String = "word/document.xml";
    private const _wordXMLParser:WordXMLParser = new WordXMLParser();

    public function DOCXLoader(request:URLRequest) {
        _url = request.url;
        _fzip = new FZip();
        _fzip.addEventListener(Event.COMPLETE, onComplete);
        _fzip.addEventListener(IOErrorEvent.IO_ERROR, onError);
        _fzip.addEventListener(ProgressEvent.PROGRESS, onProgress);
        _fzip.load(request);
    }

    private var _fzip:FZip;

    private var _error:*;

    public function get error():* {
        return _error;
    }

    private var _isLoadComplete:Boolean;

    public function get isLoadComplete():Boolean {
        return _isLoadComplete;
    }

    private var _bytesTotal:uint;

    public function get bytesTotal():uint {
        return _bytesTotal
    }

    private var _bytesLoaded:uint;

    public function get bytesLoaded():uint {
        return _bytesLoaded;
    }

    private var _url:String;

    public function get url():String {
        return _url;
    }

    public function get success():Boolean {
        return (_error == null);
    }

    public function get data():XML {
        return _wordXMLParser.data
    }

    public function destroy():void {
        removeListeners();
        _fzip = null;
    }

    private function removeListeners():void {
        _fzip.removeEventListener(Event.COMPLETE, onComplete);
        _fzip.removeEventListener(IOErrorEvent.IO_ERROR, onError);
        _fzip.removeEventListener(ProgressEvent.PROGRESS, onProgress);
    }

    private function onProgress(event:ProgressEvent):void {
        _bytesTotal = event.bytesTotal;
        _bytesLoaded = event.bytesLoaded;
    }

    private function onError(event:ErrorEvent):void {
        _error = event;
        _isLoadComplete = true;
        removeListeners();
    }

    private function onComplete(event:Event):void {
        _isLoadComplete = true;
        try {
            _wordXMLParser.convert(_fzip.getFileByName(DOCUMENT_XML_PATH).getContentAsString());
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
