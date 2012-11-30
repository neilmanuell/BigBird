package bigbird.integration
{
import bigbird.core.vos.KeyValuePairVO;

import flash.events.Event;
import flash.net.URLRequest;
import flash.utils.Dictionary;

import org.flexunit.async.Async;
import org.hamcrest.assertThat;

import supporting.MockBigBird;
import supporting.values.URL_WELL_FORMED_DOCUMENT_DOCX;
import supporting.values.URL_WELL_FORMED_DOCUMENT_XML;

public class BigBirdWellFormattedDecodingTest
{
    private var _classUnderTest:MockBigBird;
    private const _recieved:Dictionary = new Dictionary( false );
    private const _expected:Array = [
        "[KeyValuePair(colour:9621584,label:Text 1,content:A)]" ,
        "[KeyValuePair(colour:9621584,label:Text 2,content:B)]" ,
        "[KeyValuePair(colour:5541332,label:Text 3,content:C)]" ,
        "[KeyValuePair(colour:14904330,label:Text 4,content:D)]" ,
        "[KeyValuePair(colour:14904330,label:Text 5,content:E)]" ,
        "[KeyValuePair(colour:14904330,label:Text 6,content:F)]" ,
        "[KeyValuePair(colour:14904330,label:Text 7,content:G)]" ,
        "[KeyValuePair(colour:5541332,label:Text 8,content:H)]" ,
        "[KeyValuePair(colour:14904330,label:Text 9,content:I)]" ,
        "[KeyValuePair(colour:14904330,label:Text 10,content:J)]" ,
        "[KeyValuePair(colour:14904330,label:Text 11,content:K)]" ,
        "[KeyValuePair(colour:14904330,label:Text 12,content:L)]"
    ];

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
        _classUnderTest.load( URL_WELL_FORMED_DOCUMENT_XML );
        _classUnderTest.load( URL_WELL_FORMED_DOCUMENT_DOCX );
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
        assertThat( _expected.join( "," ), _recieved[URL_WELL_FORMED_DOCUMENT_XML].join( "," ) );
        assertThat( _expected.join( "," ), _recieved[URL_WELL_FORMED_DOCUMENT_DOCX].join( "," ) );
    }
}
}
