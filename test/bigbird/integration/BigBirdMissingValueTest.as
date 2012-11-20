package bigbird.integration
{
import bigbird.core.vos.KeyValuePairVO;

import flash.events.Event;

import org.flexunit.async.Async;
import org.hamcrest.assertThat;

import supporting.MockBigBird;

public class BigBirdMissingValueTest
{
    private var _classUnderTest:MockBigBird;
    private const _recieved:Array = [];
    private const _expected:Array = [
        "[KeyValuePair(colour:9621584,label:Text 1,content:A)]" ,
        "[KeyValuePair(colour:9621584,label:Text 2,content:B)]" ,
        "[KeyValuePair(colour:5541332,label:Text 3,content:C)]" ,
        "[KeyValuePair(colour:14904330,label:Text 4,content:D)]" ,
        "[KeyValuePair(colour:14904330,label:Text 5,content:E)]" ,
        "[KeyValuePair(colour:14904330,label:Text 6,content:F)]" ,
        "[KeyValuePair(colour:14904330,label:Text 7,content:G)]" ,
        "[KeyValuePair(colour:5541332,label:Text 8,content:H)]" ,
        "[KeyValuePair(colour:14904330,label:Text 9,content:*MISSING*)]" ,
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


    //[Test(async)]
    public function adding_document_sets_isActive_true():void
    {
        _classUnderTest.onDecoded.add( onDecoded );
        //   _classUnderTest.addRawDocumentXML( null, DOCUMENT_FULL_MISSING_VALUE_XML );
        var asyncHandler:Function = Async.asyncHandler( this, handleComplete, 500, null );
        _classUnderTest.addEventListener( Event.COMPLETE, asyncHandler );
    }

    private function onDecoded( name:String, data:KeyValuePairVO ):void
    {
        _recieved.push( data.toString() );
    }

    private function handleComplete( event:Event, data:* ):void
    {
        assertThat( _expected.join( "," ), _recieved.join( "," ) );
    }
}
}
