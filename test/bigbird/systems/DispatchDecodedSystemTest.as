package bigbird.systems
{
import bigbird.components.KeyCell;
import bigbird.components.KeyValuePairState;
import bigbird.components.KeyValuePairUID;
import bigbird.components.ValueCell;
import bigbird.core.KeyValuePair;
import bigbird.core.KeyValuePairSignal;
import bigbird.nodes.KeyValuePairNode;

import org.hamcrest.assertThat;
import org.hamcrest.object.equalTo;
import org.hamcrest.object.instanceOf;
import org.hamcrest.object.isTrue;

import supporting.values.DOCUMENT_NAME;
import supporting.values.KEY_CELL_XML;
import supporting.values.VALUE_CELL_XML;

public class DispatchDecodedSystemTest
{
    private var _recievedData:KeyValuePair;
    private var _recievedDocumentName:String;
    private var _numTimesDispatched:int;
    private var _classUnderTest:DispatchDecodedSystem;

    [Before]
    public function before():void
    {
        _classUnderTest = new DispatchDecodedSystem( new KeyValuePairSignal() );
    }

    [After]
    public function after():void
    {
        _classUnderTest = null;
    }

    [Test]
    public function onKeyValuePairAdded_returns_instanceOf_KeyValuePairSignal():void
    {
        assertThat( _classUnderTest.onKeyValuePairAdded, instanceOf( KeyValuePairSignal ) );
    }

    [Test]
    public function updateNode_sets_isDispatched_to_true():void
    {
        const node:KeyValuePairNode = createNode( KEY_CELL_XML, VALUE_CELL_XML, DOCUMENT_NAME );
        _classUnderTest.updateNode( node, 0 );

        assertThat( node.state.hasDispatched, isTrue() );
    }

    [Test]
    public function updateNode_dispatches_onKeyValuePairAdded_first_time():void
    {
        const node:KeyValuePairNode = createNode( KEY_CELL_XML, VALUE_CELL_XML, DOCUMENT_NAME );
        _classUnderTest.onKeyValuePairAdded.add( onDispatch );

        _classUnderTest.updateNode( node, 0 );

        assertThat( _numTimesDispatched, equalTo( 1 ) );
    }

    [Test]
    public function updateNode_not_dispatches_onKeyValuePairAdded_after_first_time():void
    {
        const node:KeyValuePairNode = createNode( KEY_CELL_XML, VALUE_CELL_XML, DOCUMENT_NAME );
        _classUnderTest.onKeyValuePairAdded.add( onDispatch );

        _classUnderTest.updateNode( node, 0 );
        _classUnderTest.updateNode( node, 0 );

        assertThat( _numTimesDispatched, equalTo( 1 ) );
    }

    [Test]
    public function updateNode_dispatches_documentName():void
    {
        const node:KeyValuePairNode = createNode( KEY_CELL_XML, VALUE_CELL_XML, DOCUMENT_NAME );
        _classUnderTest.onKeyValuePairAdded.add( onDispatch );

        _classUnderTest.updateNode( node, 0 );

        assertThat( _recievedDocumentName, equalTo( DOCUMENT_NAME ) );
    }

    [Test]
    public function updateNode_dispatches_instanceOf_KeyValuePair():void
    {
        const node:KeyValuePairNode = createNode( KEY_CELL_XML, VALUE_CELL_XML, DOCUMENT_NAME );
        _classUnderTest.onKeyValuePairAdded.add( onDispatch );

        _classUnderTest.updateNode( node, 0 );

        assertThat( _recievedData, instanceOf( KeyValuePair ) );
    }

    [Test]
    public function updateNode_dispatches_KeyValuePair_with_correct_label():void
    {
        const node:KeyValuePairNode = createNode( KEY_CELL_XML, VALUE_CELL_XML, DOCUMENT_NAME );
        _classUnderTest.onKeyValuePairAdded.add( onDispatch );

        _classUnderTest.updateNode( node, 0 );

        assertThat( _recievedData.label, equalTo( "Activity Type" ) );
    }

    [Test]
    public function updateNode_dispatches_KeyValuePair_with_correct_content():void
    {
        const node:KeyValuePairNode = createNode( KEY_CELL_XML, VALUE_CELL_XML, DOCUMENT_NAME );
        _classUnderTest.onKeyValuePairAdded.add( onDispatch );

        _classUnderTest.updateNode( node, 0 );

        assertThat( _recievedData.content, equalTo( "QAA" ) );
    }

    private function onDispatch( documentName:String, data:KeyValuePair ):void
    {
        _numTimesDispatched++;
        _recievedDocumentName = documentName;
        _recievedData = data;
    }

    private function createNode( keyCellData:XML, valueCellData:XML, documentName:String ):KeyValuePairNode
    {
        const node:KeyValuePairNode = new KeyValuePairNode();
        node.key = new KeyCell( keyCellData, keyCellData.namespace( "w" ) );
        node.value = new ValueCell( valueCellData, valueCellData.namespace( "w" ) );
        node.state = new KeyValuePairState();
        node.uid = new KeyValuePairUID( 0, documentName );
        return node;
    }

}
}
