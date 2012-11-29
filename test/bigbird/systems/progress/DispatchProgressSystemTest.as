package bigbird.systems.progress
{
import bigbird.components.BigBirdProgress;
import bigbird.controller.Removals;
import bigbird.systems.utils.removal.ActivityMonitor;

import flash.events.Event;

import mockolate.nice;
import mockolate.prepare;
import mockolate.received;

import net.richardlord.ash.core.Game;

import org.flexunit.async.Async;
import org.hamcrest.assertThat;
import org.hamcrest.object.equalTo;

public class DispatchProgressSystemTest
{
    private const TOTAL_WORK:int = 10;
    private const WORK_DONE:int = 1;

    private var _progress:BigBirdProgress;

    private var _classUnderTest:DispatchProgressSystem;
    private var _activityMonitor:ActivityMonitor;
    private var _removals:Removals;

    [Before(order=1, async, timeout=5000)]
    public function prepareMockolates():void
    {
        Async.proceedOnEvent( this,
                prepare( Game, BigBirdProgress, Removals, ActivityMonitor ),
                Event.COMPLETE );
    }

    [Before(order=2)]
    public function before():void
    {
        _progress = nice( BigBirdProgress );
        _progress.totalWork = TOTAL_WORK;
        _progress.workDone = WORK_DONE;
        _classUnderTest = new DispatchProgressSystem( _progress );
        _activityMonitor = nice( ActivityMonitor );
        _removals = nice( Removals );
        _classUnderTest.activityMonitor = _activityMonitor;
        _classUnderTest.removals = _removals;
        _classUnderTest.addToGame( nice( Game ) );
    }

    [Test]
    public function workDone_set_to_zero():void
    {
        _classUnderTest.update( 0 );
        assertThat( _progress.workDone, equalTo( 0 ) )
    }

    [Test]
    public function totalWork_set_to_zero():void
    {
        _classUnderTest.update( 0 );
        assertThat( _progress.totalWork, equalTo( 0 ) );
    }

    [Test]
    public function factor_not_isNaN_confirms_activity():void
    {
        _classUnderTest.update( 0 );
        assertThat( _activityMonitor, received().method( "confirmActivity" ).once() );
    }

    [Test]
    public function factor_not_isNaN_dispatches():void
    {
        _classUnderTest.update( 0 );
        assertThat( _progress, received().method( "dispatch" ).once() );
    }

    [Test]
    public function factor_isNaN_does_not_confirm_activity():void
    {
        _progress.totalWork = 0;
        _progress.workDone = 0;
        _classUnderTest.update( 0 );
        assertThat( _activityMonitor, received().method( "confirmActivity" ).never() );
    }

    [Test]
    public function factor_isNaN_does_not_dispatch():void
    {
        _progress.totalWork = 0;
        _progress.workDone = 0;
        _classUnderTest.update( 0 );
        assertThat( _progress, received().method( "dispatch" ).never() );
    }


}
}
