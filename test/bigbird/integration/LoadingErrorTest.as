package bigbird.integration
{
import bigbird.core.vos.DataLoaderVO;
import bigbird.core.vos.ProgressVO;

import flash.events.Event;
import flash.net.URLRequest;

import org.flexunit.async.Async;
import org.hamcrest.assertThat;
import org.hamcrest.object.equalTo;

import supporting.MockBigBird;

public class LoadingErrorTest
{
    private var _classUnderTest:MockBigBird;
    private const _recievedData:Vector.<DataLoaderVO> = new Vector.<DataLoaderVO>();
    private const _recievedProgress:Array = [];


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
        _classUnderTest.onLoaded.add( onLoaded );
        _classUnderTest.onProgress.add( onProgress );
        _classUnderTest.load( new URLRequest( "hello.xml" ) );
        _classUnderTest.load( new URLRequest( "goodbye.docx" ) );
        _classUnderTest.load( new URLRequest( "goodbye.text" ) );
        var asyncHandler:Function = Async.asyncHandler( this, handleComplete, 500, null );
        _classUnderTest.addEventListener( Event.COMPLETE, asyncHandler );
    }

    private function onLoaded( wordData:DataLoaderVO ):void
    {
        _recievedData.push( wordData );
    }

    private function onProgress( progress:ProgressVO ):void
    {
        _recievedProgress.push( {workDone:progress.workDone, totalWork:progress.totalWork } );
    }

    private function handleComplete( event:Event, data:* ):void
    {

        //todo:  order of load depends on OS,
        assertThat( _recievedData.length, equalTo( 3 ) )

        assertThat( _recievedData[0].url, equalTo( "hello.xml" ) );
        assertThat( _recievedData[0].data.type.text(), equalTo( "ioError" ) )

        assertThat( _recievedData[1].url, equalTo( "goodbye.docx" ) );
        assertThat( _recievedData[1].data.type.text(), equalTo( "ioError" ) );

        assertThat( _recievedData[2].url, equalTo( "goodbye.text" ) );
        assertThat( _recievedData[2].data.type.text(), equalTo( "nullErrorEvent" ) );

        // assertThat( _recievedProgress.length, greaterThan( 0 ) )
    }
}
}
