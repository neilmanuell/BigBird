package bigbird.integration
{
import bigbird.api.vos.KeyValuePairVO;
import bigbird.api.vos.ProgressVO;

import flash.events.Event;
import flash.events.TimerEvent;
import flash.net.URLRequest;
import flash.utils.Dictionary;
import flash.utils.Timer;

import org.flexunit.async.Async;
import org.hamcrest.assertThat;
import org.hamcrest.object.equalTo;

import supporting.MockBigBird;
import supporting.values.requests.URL_MISSING_KEY_DOCUMENT_DOCX;
import supporting.values.requests.URL_MISSING_KEY_DOCUMENT_XML;
import supporting.values.requests.URL_MISSING_VALUE_DOCUMENT_DOCX;
import supporting.values.requests.URL_MISSING_VALUE_DOCUMENT_XML;
import supporting.values.requests.URL_WELL_FORMED_DOCUMENT_DOCX;
import supporting.values.requests.URL_WELL_FORMED_DOCUMENT_XML;
import supporting.values.requests.URL_WELL_FORMED_LARGE_DOCUMENT_DOCX;
import supporting.values.requests.URL_WELL_FORMED_LARGE_DOCUMENT_XML;
import supporting.values.results.expectedKeyValuePairs;

public class BigBirdFiftyMillSecStressTest
{
    private var _classUnderTest:MockBigBird;
    private const _urls:Array = [
        URL_MISSING_KEY_DOCUMENT_DOCX,
        URL_MISSING_VALUE_DOCUMENT_XML,
        URL_WELL_FORMED_LARGE_DOCUMENT_XML,
        URL_MISSING_KEY_DOCUMENT_XML,
        URL_WELL_FORMED_DOCUMENT_DOCX,
        URL_MISSING_VALUE_DOCUMENT_DOCX,
        URL_WELL_FORMED_LARGE_DOCUMENT_DOCX,
        URL_WELL_FORMED_DOCUMENT_XML
    ];
    private const _received:Dictionary = new Dictionary( false );
    private const _expected:Dictionary = expectedKeyValuePairs();
    private const _receivedProgress:Array = [];
    private var _timer:Timer;
    private var _count:int;

    [Before]
    public function before():void
    {
        _classUnderTest = new MockBigBird();
    }


    [Test(async)]
    public function test():void
    {
        _classUnderTest.onDecoded.add( onDecoded );
        _classUnderTest.onProgress.add( onProgress );
        var asyncHandler:Function = Async.asyncHandler( this, handleComplete, 1000, null );
        _classUnderTest.addEventListener( Event.COMPLETE, asyncHandler );
        _timer = new Timer( 50, _urls.length );
        _timer.addEventListener( TimerEvent.TIMER, onTick );
        _timer.start();
    }

    private function onProgress( vo:ProgressVO ):void
    {
        _receivedProgress.push( vo);
    }

    private function onTick( event:TimerEvent ):void
    {
        _classUnderTest.load( _urls[_count++] );

    }

    private function onDecoded( request:URLRequest, index:int, data:KeyValuePairVO ):void
    {
        if ( _received[request] == null )
            _received[request] = [data.toString()];

        else
            _received[request].push( data.toString() );
    }

    private function handleComplete( event:Event, data:* ):void
    {
        for each (var url:URLRequest in _urls){

            assertThat( _received[url].join( "," ), equalTo( _expected[url].join( "," ) ) );
        }
    }
}
}
