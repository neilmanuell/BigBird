package bigbird.systems.load
{
import bigbird.components.BigBirdProgress;
import bigbird.components.io.Loader;
import bigbird.controller.Removals;
import bigbird.nodes.LoadProgressNode;
import bigbird.systems.utils.removal.ActivityMonitor;

import flash.events.Event;

import mockolate.nice;
import mockolate.prepare;
import mockolate.received;
import mockolate.stub;

import org.flexunit.async.Async;
import org.hamcrest.assertThat;
import org.hamcrest.object.equalTo;

import supporting.values.URL_WELL_FORMED_DOCUMENT_DOCX;

public class LoadProgressSystemTest
{
    private var _progress:BigBirdProgress;
    private var _classUnderTest:LoadProgressSystem;
    private var _activityMonitor:ActivityMonitor;
    private const WORK_DONE:int = 10;
    private const TOTAL_WORK:int = 20;


    [Before(order=1, async, timeout=5000)]
    public function prepareMockolates():void
    {
        Async.proceedOnEvent( this,
                prepare( Removals, ActivityMonitor, Loader ),
                Event.COMPLETE );
    }

    [Before(order=2)]
    public function before():void
    {

        _progress = new BigBirdProgress( null );
        _progress.workDone = WORK_DONE;
        _progress.totalWork = TOTAL_WORK;
        _activityMonitor = nice( ActivityMonitor );
        _classUnderTest = new LoadProgressSystem( _progress );
        _classUnderTest.removals = nice( Removals );
        _classUnderTest.activityMonitor = _activityMonitor;


    }


    [Test]
    public function totalWork_summation():void
    {
        const POSITION:int = 5;
        const LENGTH:int = 10;
        const node:LoadProgressNode = createNode( POSITION, LENGTH );

        _classUnderTest.updateNode( node, 0 );

        assertThat( _progress.totalWork, equalTo( LENGTH + TOTAL_WORK ) );
    }

    [Test]
    public function workDone_summation():void
    {
        const POSITION:int = 5;
        const LENGTH:int = 10;
        const node:LoadProgressNode = createNode( POSITION, LENGTH );

        _classUnderTest.updateNode( node, 0 );

        assertThat( _progress.workDone, equalTo( POSITION + WORK_DONE ) );
    }

    [Test]
    public function confirms_activity():void
    {
        const node:LoadProgressNode = createNode( 1, 2 );
        _classUnderTest.updateNode( node, 0 );
        assertThat( _activityMonitor, received().method( "confirmActivity" ).once() );
    }


    private function createNode( bytesLoaded:int, bytesTotal:int ):LoadProgressNode
    {
        const node:LoadProgressNode = new LoadProgressNode();
        const loader:Loader = nice( Loader, "Loader", [URL_WELL_FORMED_DOCUMENT_DOCX] );
        stub( loader ).getter( "bytesLoaded" ).returns( bytesLoaded );
        stub( loader ).getter( "bytesTotal" ).returns( bytesTotal );
        node.loader = loader;
        return node;

    }
}
}
