package bigbird.integration
{
import bigbird.asserts.assertReceivedDataLoaderVOsContain;
import bigbird.core.vos.DataLoaderVO;
import bigbird.core.vos.ProgressVO;

import flash.events.Event;

import org.flexunit.async.Async;
import org.hamcrest.assertThat;
import org.hamcrest.object.equalTo;

import supporting.MockBigBird;
import supporting.values.DATA_WELL_FORMED_DOCUMENT;
import supporting.values.URL_WELL_FORMED_DOCUMENT_DOCX;
import supporting.values.URL_WELL_FORMED_DOCUMENT_XML;

public class SingleWellFormattedXMLTest
{
    private var _classUnderTest:MockBigBird;
    private const _recievedData:Vector.<DataLoaderVO> = new Vector.<DataLoaderVO>();
    private const _recievedProgress:Vector.<ProgressVO> = new Vector.<ProgressVO>();


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
        _classUnderTest.load( URL_WELL_FORMED_DOCUMENT_XML );
        _classUnderTest.load( URL_WELL_FORMED_DOCUMENT_DOCX );
        var asyncHandler:Function = Async.asyncHandler( this, handleComplete, 500, null );
        _classUnderTest.addEventListener( Event.COMPLETE, asyncHandler );
    }

    private function onLoaded( wordData:DataLoaderVO ):void
    {
        _recievedData.push( wordData );
    }

    private function onProgress( progress:ProgressVO ):void
    {
        _recievedProgress.push( progress );
    }

    private function handleComplete( event:Event, data:* ):void
    {
        //todo:  add comments to test,
        assertReceivedDataLoaderVOsContain( URL_WELL_FORMED_DOCUMENT_XML.url, DATA_WELL_FORMED_DOCUMENT.toString(), _recievedData );
        assertReceivedDataLoaderVOsContain( URL_WELL_FORMED_DOCUMENT_DOCX.url, DATA_WELL_FORMED_DOCUMENT.toString(), _recievedData );

        const lastProgressVO:ProgressVO = _recievedProgress[length - 1];

        assertThat( lastProgressVO.workDone / lastProgressVO.totalWork, equalTo( 1 ) );
    }

}
}
