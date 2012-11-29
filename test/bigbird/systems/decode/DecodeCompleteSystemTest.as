package bigbird.systems.decode
{
import bigbird.components.WordData;
import bigbird.controller.Removals;
import bigbird.nodes.DecodeNode;
import bigbird.systems.utils.removal.ActivityMonitor;

import flash.events.Event;

import mockolate.nice;
import mockolate.prepare;
import mockolate.received;
import mockolate.stub;

import net.richardlord.ash.core.Entity;

import org.flexunit.async.Async;
import org.hamcrest.assertThat;

public class DecodeCompleteSystemTest
{
    private var _classUnderTest:DecodeCompleteSystem;
    private var _removals:Removals;
    private var _activityMonitor:ActivityMonitor;


    [Before(order=1, async, timeout=5000)]
    public function prepareMockolates():void
    {
        Async.proceedOnEvent( this,
                prepare( Removals, WordData, ActivityMonitor, Entity ),
                Event.COMPLETE );
    }

    [Before(order=2)]
    public function before():void
    {
        _removals = nice( Removals );
        _activityMonitor = nice( ActivityMonitor );
        _classUnderTest = new DecodeCompleteSystem();
        _classUnderTest.removals = _removals;
        _classUnderTest.activityMonitor = _activityMonitor;
    }

    [Test]
    public function hasNext_true_confirms_activity():void
    {
        const node:DecodeNode = createNode( true );
        _classUnderTest.updateNode( node, 0 );
        assertThat( _activityMonitor, received().method( "confirmActivity" ).once() );
    }


    [Test]
    public function hasNext_false_does_not_confirm_activity():void
    {
        const node:DecodeNode = createNode( false );
        _classUnderTest.updateNode( node, 0 );
        assertThat( _activityMonitor, received().method( "confirmActivity" ).never() );
    }

    [Test]
    public function hasNext_false_removes_Entity():void
    {
        const node:DecodeNode = createNode( false );
        _classUnderTest.updateNode( node, 0 );
        assertThat( _removals, received().method( "removeEntity" ).arg( node.entity ).once() );
    }

    [Test]
    public function hasNext_true_does_not_remove_Entity():void
    {
        const node:DecodeNode = createNode( true );
        _classUnderTest.updateNode( node, 0 );
        assertThat( _removals, received().method( "removeEntity" ).arg( node.entity ).never() );
    }


    private function createNode( hasNext:Boolean ):DecodeNode
    {
        const node:DecodeNode = new DecodeNode();
        const wordData:WordData = nice( WordData );
        node.entity = nice( Entity );
        stub( wordData ).getter( "hasNext" ).returns( hasNext );
        node.document = wordData;
        return node;
    }


}
}
