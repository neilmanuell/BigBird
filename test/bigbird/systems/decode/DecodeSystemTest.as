package bigbird.systems.decode
{
import bigbird.components.Chunker;
import bigbird.components.WordData;
import bigbird.controller.Removals;
import bigbird.nodes.DecodeNode;
import bigbird.systems.utils.removal.ActivityMonitor;

import flash.events.Event;
import flash.utils.getTimer;

import mockolate.nice;
import mockolate.prepare;
import mockolate.received;
import mockolate.stub;

import org.flexunit.async.Async;
import org.hamcrest.assertThat;
import org.hamcrest.number.between;

import supporting.values.requests.URL_WELL_FORMED_DOCUMENT_DOCX;

public class DecodeSystemTest
{
    private const CHUNKING_SIZE:int = 500;
    private var _classUnderTest:DecodeSystem;
    private var _decoder:DecodeFromWordFile;
    private var _removals:Removals;
    private var _activityMonitor:ActivityMonitor;

    [Before(order=1, async, timeout=5000)]
    public function prepareMockolates():void
    {
        Async.proceedOnEvent( this,
                prepare( DecodeFromWordFile, Removals, ActivityMonitor, WordData ),
                Event.COMPLETE );
    }

    [Before(order=2)]
    public function before():void
    {
        _decoder = nice( DecodeFromWordFile );
        _removals = nice( Removals );
        _activityMonitor = nice( ActivityMonitor );
        _classUnderTest = new DecodeSystem( _decoder );
        _classUnderTest.removals = _removals;
        _classUnderTest.activityMonitor = _activityMonitor;
    }


    [Test]
    public function updateNode_confirms_activity():void
    {
        const node:DecodeNode = createNode( true );
        _classUnderTest.updateNode( node, 0 );
        assertThat( _activityMonitor, received().method( "confirmActivity" ).once() );
    }

    [Test]
    public function hasNext_false_decode_not_called():void
    {
        const node:DecodeNode = createNode( false );
        _classUnderTest.updateNode( node, 0 );
        assertThat( _decoder, received().method( "decode" ).never() );
    }

    [Test]
    public function hasNext_true_decode_calls_defined_by_chunkingSize():void
    {
        const node:DecodeNode = createNode( true );
        _classUnderTest.updateNode( node, 0 );
        assertThat( _decoder, received().method( "decode" ).args( node.request, node.document ).times( CHUNKING_SIZE ) );
    }

    [Test]
    public function previousChunkingTime_set_on_Chunker():void
    {
        const node:DecodeNode = createNode( true );
        const timeBefore:Number = getTimer();
        _classUnderTest.updateNode( node, 0 );
        const timeTaken:Number = getTimer() - timeBefore;
        assertThat( node.chunker.previousChunkingTime, between( timeTaken - 1, timeTaken + 1 ) );
    }

    private function createNode( hasNext:Boolean ):DecodeNode
    {

        const node:DecodeNode = new DecodeNode();
        const wordData:WordData = nice( WordData );
        stub( wordData ).getter( "hasNext" ).returns( hasNext );
        node.document = wordData;
        node.request = URL_WELL_FORMED_DOCUMENT_DOCX;
        node.chunker = new Chunker( CHUNKING_SIZE )
        return node;
    }


}
}
