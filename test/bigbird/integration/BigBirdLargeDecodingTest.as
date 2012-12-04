package bigbird.integration
{
import bigbird.api.vos.KeyValuePairVO;

import flash.events.Event;
import flash.net.URLRequest;
import flash.utils.Dictionary;

import org.flexunit.async.Async;
import org.hamcrest.assertThat;
import org.hamcrest.object.equalTo;

import supporting.MockBigBird;
import supporting.values.requests.URL_WELL_FORMED_LARGE_DOCUMENT_DOCX;
import supporting.values.requests.URL_WELL_FORMED_LARGE_DOCUMENT_XML;
import supporting.values.results.expectedKeyValuePairs;

public class BigBirdLargeDecodingTest
{
    private var _classUnderTest:MockBigBird;
    private const _recieved:Dictionary = new Dictionary( false );
    private const _expected:Dictionary = expectedKeyValuePairs();

    [Before]
    public function before():void
    {
        _classUnderTest = new MockBigBird();
    }

    [After]
    public function after():void
    {
        _classUnderTest = null;
    }


    [Test(async)]
    public function test():void
    {
        _classUnderTest.onDecoded.add( onDecoded );
        _classUnderTest.load( URL_WELL_FORMED_LARGE_DOCUMENT_XML );
        _classUnderTest.load( URL_WELL_FORMED_LARGE_DOCUMENT_DOCX );
        var asyncHandler:Function = Async.asyncHandler( this, handleComplete, 500, null );
        _classUnderTest.addEventListener( Event.COMPLETE, asyncHandler );
    }

    private function onDecoded( request:URLRequest, index:int, data:KeyValuePairVO ):void
    {
        if ( _recieved[request] == null )
            _recieved[request] = [data.toString()];

        else
            _recieved[request].push( data.toString() );
    }

    private function handleComplete( event:Event, data:* ):void
    {
        assertThat( _recieved[URL_WELL_FORMED_LARGE_DOCUMENT_XML].join( "," ), equalTo( _expected[URL_WELL_FORMED_LARGE_DOCUMENT_XML].join( "," ) ) );
        assertThat( _recieved[URL_WELL_FORMED_LARGE_DOCUMENT_DOCX].join( "," ), equalTo( _expected[URL_WELL_FORMED_LARGE_DOCUMENT_DOCX].join( "," ) ) );
    }
}
}
