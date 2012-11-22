package bigbird.integration
{
import bigbird.core.vos.DataLoaderVO;
import bigbird.core.vos.ProgressVO;

import flash.events.Event;
import flash.net.URLRequest;

import org.flexunit.async.Async;
import org.hamcrest.assertThat;
import org.hamcrest.number.greaterThan;
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
        _classUnderTest.load( new URLRequest( "hello" ) );
        _classUnderTest.load( new URLRequest( "goodbye" ) );
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
        assertThat( _recievedData[0].url, equalTo( "hello" ) );
        assertThat( _recievedData[0].data.message.text(), equalTo( "AngryDataLoader" ) )

        assertThat( _recievedData[1].url, equalTo( "goodbye" ) );
        assertThat( _recievedData[1].data.toString(), equalTo( "AngryDataLoader" ) );

        assertThat( _recievedProgress.length, greaterThan( 0 ) )
    }
}
}
