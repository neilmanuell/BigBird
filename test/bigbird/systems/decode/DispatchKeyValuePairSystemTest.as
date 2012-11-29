package bigbird.systems.decode
{
import bigbird.components.KeyValuePairInfo;
import bigbird.core.KeyValuePairSignal;
import bigbird.nodes.KeyValuePairNode;
import bigbird.systems.utils.removal.ActivityMonitor;

import flash.events.Event;

import mockolate.nice;
import mockolate.prepare;
import mockolate.received;

import org.flexunit.async.Async;
import org.hamcrest.assertThat;

import supporting.values.URL_WELL_FORMED_DOCUMENT_DOCX;

public class DispatchKeyValuePairSystemTest
{

    private var _classUnderTest:DispatchDecodedSystem;
    private var _signal:KeyValuePairSignal;
    private var _activityMontitor:ActivityMonitor;

    [Before(order=1, async, timeout=5000)]
    public function prepareMockolates():void
    {
        Async.proceedOnEvent( this,
                prepare( KeyValuePairSignal, ActivityMonitor ),
                Event.COMPLETE );
    }

    [Before(order=2)]
    public function before():void
    {
        _signal = nice( KeyValuePairSignal );
        _classUnderTest = new DispatchDecodedSystem( _signal );
        _activityMontitor = nice( ActivityMonitor );
        _classUnderTest.activityMonitor = _activityMontitor;
    }


    [Test]
    public function dispatches():void
    {
        const node:KeyValuePairNode = createNode();
        _classUnderTest.updateNode( node, 0 );

        assertThat( _signal, received().method( "dispatchKeyValuePair" ).arg( node ).once() );
    }

    [Test]
    public function dispatches_only_once():void
    {
        const node:KeyValuePairNode = createNode();
        _classUnderTest.updateNode( node, 0 );
        _classUnderTest.updateNode( node, 0 );

        assertThat( _signal, received().method( "dispatchKeyValuePair" ).arg( node ).once() );
    }

    [Test]
    public function dispatch_confirms_activity():void
    {
        const node:KeyValuePairNode = createNode();
        _classUnderTest.updateNode( node, 0 );

        assertThat( _activityMontitor, received().method( "confirmActivity" ).once() );
    }

    /*   [Test]
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
     }*/


    private function createNode():KeyValuePairNode
    {
        const node:KeyValuePairNode = new KeyValuePairNode();

        node.info = new KeyValuePairInfo( 0, URL_WELL_FORMED_DOCUMENT_DOCX );
        return node;
    }

}
}
