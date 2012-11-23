package bigbird.systems
{
import bigbird.components.Chunker;
import bigbird.components.WordData;
import bigbird.nodes.DecodeNode;

import flash.events.Event;

import mockolate.nice;
import mockolate.prepare;
import mockolate.received;

import org.flexunit.async.Async;
import org.hamcrest.assertThat;

import supporting.values.DOCUMENT_FULL_SMALL_XML;

public class DecodeSystemTest
{
    private const CHUNKING_SIZE:int = 4;
    private var _classUnderTest:DecodeSystem;
    private var _decoder:Decoder;
    private var _node:DecodeNode;

    [Before(order=1, async, timeout=5000)]
    public function prepareMockolates():void
    {
        Async.proceedOnEvent( this,
                prepare( DecodeFromWordFile ),
                Event.COMPLETE );
    }

    [Before(order=2)]
    public function before():void
    {
        _decoder = nice( DecodeFromWordFile );
        _classUnderTest = new DecodeSystem( _decoder );
        _node = new DecodeNode();
        _node.document = new WordData( DOCUMENT_FULL_SMALL_XML );
        _node.chunker = new Chunker( CHUNKING_SIZE );
    }

    [After]
    public function after():void
    {
        _classUnderTest = null;
    }

    [Test]
    public function during_single_update_decoder_gets_called_as_prescribed_by_chunkingSize():void
    {
        _classUnderTest.updateNode( _node, 0 );
        assertThat( _decoder, received().method( "decode" ).arg( _node.document ).times( CHUNKING_SIZE ) )
    }


}
}
