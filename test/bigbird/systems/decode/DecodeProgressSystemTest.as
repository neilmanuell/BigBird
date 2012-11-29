package bigbird.systems.decode
{
import bigbird.components.BigBirdProgress;
import bigbird.components.WordData;
import bigbird.controller.Removals;
import bigbird.nodes.DecodeNode;
import bigbird.systems.utils.removal.ActivityMonitor;

import flash.events.Event;

import mockolate.nice;
import mockolate.prepare;
import mockolate.received;
import mockolate.stub;

import org.flexunit.async.Async;
import org.hamcrest.assertThat;
import org.hamcrest.object.equalTo;

public class DecodeProgressSystemTest
{

    private var _progress:BigBirdProgress;
    private var _classUnderTest:DecodeProgressSystem;
    private var _activityMonitor:ActivityMonitor;
    private const WORK_DONE:int = 10;
    private const TOTAL_WORK:int = 20;


    [Before(order=1, async, timeout=5000)]
    public function prepareMockolates():void
    {
        Async.proceedOnEvent( this,
                prepare( Removals, WordData, ActivityMonitor ),
                Event.COMPLETE );
    }

    [Before(order=2)]
    public function before():void
    {

        _progress = new BigBirdProgress( null );
        _progress.workDone = WORK_DONE;
        _progress.totalWork = TOTAL_WORK;
        _activityMonitor = nice( ActivityMonitor );
        _classUnderTest = new DecodeProgressSystem( _progress );
        _classUnderTest.removals = nice( Removals );
        _classUnderTest.activityMonitor = _activityMonitor;


    }


    [Test]
    public function totalWork_summation():void
    {
        const POSITION:int = 5;
        const LENGTH:int = 10;
        const node:DecodeNode = createNode( POSITION, LENGTH );

        _classUnderTest.updateNode( node, 0 );

        assertThat( _progress.totalWork, equalTo( LENGTH + TOTAL_WORK ) );
    }

    [Test]
    public function workDone_summation():void
    {
        const POSITION:int = 5;
        const LENGTH:int = 10;
        const node:DecodeNode = createNode( POSITION, LENGTH );

        _classUnderTest.updateNode( node, 0 );

        assertThat( _progress.workDone, equalTo( POSITION + WORK_DONE ) );
    }

    [Test]
    public function confirms_activity():void
    {
        const node:DecodeNode = createNode( 1, 2 );
        _classUnderTest.updateNode( node, 0 );
        assertThat( _activityMonitor, received().method( "confirmActivity" ).once() );
    }


    private function createNode( position:int, length:int ):DecodeNode
    {

        const node:DecodeNode = new DecodeNode();
        const wordData:WordData = nice( WordData );
        stub( wordData ).getter( "position" ).returns( position );
        stub( wordData ).getter( "length" ).returns( length );
        node.document = wordData;
        return node;
    }


}
}
