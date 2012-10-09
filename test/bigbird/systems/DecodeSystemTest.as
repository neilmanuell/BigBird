package bigbird.systems
{
import bigbird.components.Progress;
import bigbird.components.RawWordDocument;
import bigbird.factories.KeyValuePairFactory;
import bigbird.nodes.DecodeNode;

import org.hamcrest.assertThat;
import org.hamcrest.core.not;
import org.hamcrest.number.lessThan;
import org.hamcrest.object.equalTo;

import supporting.MockGame;
import supporting.values.DOCUMENT_FULL_XML;
import supporting.values.DOCUMENT_NAME;

public class DecodeSystemTest
{
    private var _node:DecodeNode;
    private var _decoder:DecodeFromRawDocument;
    private var _factory:KeyValuePairFactory;
    private var _game:MockGame;
    private var _classUnderTest:DecodeSystem;

    [Before]
    public function before():void
    {
        _node = new DecodeNode();
        _node.document = new RawWordDocument( DOCUMENT_NAME, DOCUMENT_FULL_XML );
        _node.progress = new Progress( _node.document.length );
        _game = new MockGame();
        _factory = new KeyValuePairFactory( _game );
        _decoder = new DecodeFromRawDocument( _factory );
        _classUnderTest = new DecodeSystem( _decoder );
    }

    [After]
    public function after():void
    {
        _node = null;
        _factory = null;
        _decoder = null;
        _game = null;
        _classUnderTest = null;
    }


    [Test]
    public function chunkSize_of_TEN_creates_TEN_entities_if_data_is_well_formed():void
    {
        _node.progress.chunkingSize = 10;
        _classUnderTest.updateNode( _node, 0 );
        assertThat( _game.entitiesReceived.length, equalTo( 10 ) );
    }

    [Test]
    public function previousChunkingTime_set_on_Progress():void
    {
        _node.progress.previousChunkingTime = -1;
        _classUnderTest.updateNode( _node, 0 );
        assertThat( _node.progress.previousChunkingTime, not( -1 ) );
    }

    [Test]
    public function workDone_set_on_Progress():void
    {
        _node.progress.chunkingSize = 50;
        _node.progress.workDone = -1;
        _classUnderTest.updateNode( _node, 0 );
        assertThat( _node.progress.workDone, equalTo( 50 ) );
    }

    [Test]
    public function process_breaks_when_overshoots():void
    {
        _node.progress.chunkingSize = 700;
        _classUnderTest.updateNode( _node, 0 );
        assertThat( _node.progress.workDone, lessThan( _node.progress.totalWork ) );
    }


}
}
