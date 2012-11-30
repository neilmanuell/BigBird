package bigbird.systems
{
import bigbird.systems.utils.removal.ActivityMonitor;

import flash.events.Event;

import mockolate.nice;
import mockolate.prepare;
import mockolate.received;
import mockolate.stub;

import net.richardlord.ash.core.Game;
import net.richardlord.ash.core.NodeList;

import org.flexunit.async.Async;
import org.hamcrest.assertThat;

public class BaseSelfRemovingSystemTest
{
    private var _classUnderTest:BaseSelfRemovingSystem;
    private var _activityMonitor:ActivityMonitor;
    private var _game:Game;

    [Before(order=1, async, timeout=5000)]
    public function prepareMockolates():void
    {
        Async.proceedOnEvent( this,
                prepare( Game, ActivityMonitor ),
                Event.COMPLETE );
    }

    [Before(order=2)]
    public function before():void
    {
        _game = nice( Game );
        stub( _game ).method( "getNodeList" ).returns( new NodeList() );
        _classUnderTest = new BaseSelfRemovingSystem( null, null );
        _activityMonitor = nice( ActivityMonitor );
        _classUnderTest.activityMonitor = _activityMonitor;
        _classUnderTest.addToGame( _game );
    }

    [Test]
    public function update_applies_activity():void
    {
        _classUnderTest.update( 0 );
        assertThat( _activityMonitor, received().method( "applyActivity" ).once() )
    }

    [Test]
    public function onLimit_function_set():void
    {
        assertThat( _activityMonitor, received().setter( "onLimit" ).once() )
    }

    [Test]
    public function updateComplete_signal_set():void
    {
        assertThat( _activityMonitor, received().setter( "updateComplete" ).once() )
    }
}
}
