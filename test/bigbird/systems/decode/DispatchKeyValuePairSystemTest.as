package bigbird.systems.decode
{
import bigbird.components.KeyCell;
import bigbird.components.KeyValuePairIndex;
import bigbird.components.ValueCell;
import bigbird.core.KeyValuePairSignal;
import bigbird.core.vos.KeyValuePairVO;
import bigbird.nodes.KeyValuePairNode;

import flash.net.URLRequest;

import org.hamcrest.assertThat;
import org.hamcrest.object.equalTo;
import org.hamcrest.object.instanceOf;

import supporting.values.DOCUMENT_NAME;
import supporting.values.KEY_CELL_XML;
import supporting.values.URL_WELL_FORMED_DOCUMENT_DOCX;
import supporting.values.VALUE_CELL_XML;

public class DispatchKeyValuePairSystemTest
{
    private var _recievedData:KeyValuePairVO;
    private var _recievedRequest:URLRequest;
    private var _receivedIndex:int;
    private var _numTimesDispatched:int;

    private var _classUnderTest:DispatchDecodedSystem;
    private var _signal:KeyValuePairSignal;

    [Before]
    public function before():void
    {
        _signal = new KeyValuePairSignal();
        _classUnderTest = new DispatchDecodedSystem( _signal );
    }

    [After]
    public function after():void
    {
        _classUnderTest = null;
    }


    /*[Test]
     public function updateNode_sets_isDispatched_to_true():void
     {
     const node:KeyValuePairNode = createNode( KEY_CELL_XML, VALUE_CELL_XML, DOCUMENT_NAME );
     _classUnderTest.updateNode( node, 0 );

     assertThat( node.state.hasDispatched, isTrue() );
     }*/

    [Test]
    public function updateNode_dispatches_onKeyValuePairAdded_first_time():void
    {
        const node:KeyValuePairNode = createNode( KEY_CELL_XML, VALUE_CELL_XML, DOCUMENT_NAME );
        _signal.add( onDispatch );

        _classUnderTest.updateNode( node, 0 );

        assertThat( _numTimesDispatched, equalTo( 1 ) );
    }

    //  [Test]
    public function updateNode_not_dispatches_onKeyValuePairAdded_after_first_time():void
    {
        const node:KeyValuePairNode = createNode( KEY_CELL_XML, VALUE_CELL_XML, DOCUMENT_NAME );
        _signal.add( onDispatch );

        _classUnderTest.updateNode( node, 0 );
        _classUnderTest.updateNode( node, 0 );

        assertThat( _numTimesDispatched, equalTo( 1 ) );
    }

    //   [Test]
    public function updateNode_dispatches_documentName():void
    {
        const node:KeyValuePairNode = createNode( KEY_CELL_XML, VALUE_CELL_XML, DOCUMENT_NAME );
        _signal.add( onDispatch );

        _classUnderTest.updateNode( node, 0 );

        assertThat( _recievedRequest, equalTo( DOCUMENT_NAME ) );
    }

    //   [Test]
    public function updateNode_dispatches_instanceOf_KeyValuePair():void
    {
        const node:KeyValuePairNode = createNode( KEY_CELL_XML, VALUE_CELL_XML, DOCUMENT_NAME );
        _signal.add( onDispatch );

        _classUnderTest.updateNode( node, 0 );

        assertThat( _recievedData, instanceOf( KeyValuePairVO ) );
    }

    //  [Test]
    public function updateNode_dispatches_KeyValuePair_with_correct_label():void
    {
        const node:KeyValuePairNode = createNode( KEY_CELL_XML, VALUE_CELL_XML, DOCUMENT_NAME );
        _signal.add( onDispatch );

        _classUnderTest.updateNode( node, 0 );

        assertThat( _recievedData.label, equalTo( "Activity Type" ) );
    }

    //  [Test]
    public function updateNode_dispatches_KeyValuePair_with_correct_content():void
    {
        const node:KeyValuePairNode = createNode( KEY_CELL_XML, VALUE_CELL_XML, DOCUMENT_NAME );
        _signal.add( onDispatch );

        _classUnderTest.updateNode( node, 0 );

        assertThat( _recievedData.content, equalTo( "QAA" ) );
    }

    private function onDispatch( request:URLRequest, index:int, data:KeyValuePairVO ):void
    {
        _numTimesDispatched++;
        _receivedIndex = index;
        _recievedRequest = request;
        _recievedData = data;
    }

    private function createNode( keyCellData:XML, valueCellData:XML, documentName:String ):KeyValuePairNode
    {
        const node:KeyValuePairNode = new KeyValuePairNode();
        node.key = new KeyCell( keyCellData, keyCellData.namespace( "w" ) );
        node.value = new ValueCell( valueCellData, valueCellData.namespace( "w" ) );
        node.request = URL_WELL_FORMED_DOCUMENT_DOCX;
        node.uid = new KeyValuePairIndex( 0 );
        return node;
    }

}
}
