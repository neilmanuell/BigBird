package bigbird.systems
{
import bigbird.controller.StopTick;

import net.richardlord.ash.core.Game;
import net.richardlord.ash.core.System;

import org.hamcrest.assertThat;
import org.hamcrest.object.equalTo;
import org.hamcrest.object.isFalse;
import org.hamcrest.object.isTrue;

public class IdleSystemTest
{
    private var _game:Game;
    private var _classUnderTest:IdleSystem;
    private var _stopSignal:StopTick;
    private var _onStopCalled:Boolean = false;

    [Before]
    public function before():void
    {
        _game = new Game();
        _stopSignal = new StopTick();
        _classUnderTest = new IdleSystem( _stopSignal );
        _game.addSystem( _classUnderTest, 0 );
    }

    [After]
    public function after():void
    {
        _game = null;
        _stopSignal = null;
        _classUnderTest = null;
    }

    [Test]
    public function idlingNumber_by_default_one():void
    {
        assertThat( _classUnderTest.idlingNumber, equalTo( 1 ) )
    }

    [Test]
    public function idlingNumber_setter():void
    {
        _classUnderTest.idlingNumber = 5
        assertThat( _classUnderTest.idlingNumber, equalTo( 5 ) )
    }

    [Test]
    public function update__if_systems_in_game_equals_idlingNumber_dispatch_stop():void
    {
        _stopSignal.add( onStop );
        _classUnderTest.update( 0 );
        assertThat( _onStopCalled, isTrue() );
    }

    [Test]
    public function update__if_systems_in_game_greaterThan_idlingNumber_not_dispatch_stop():void
    {
        _stopSignal.add( onStop );
        _game.addSystem( new System(), 0 );
        _classUnderTest.update( 0 );
        assertThat( _onStopCalled, isFalse() );
    }


    private function onStop():void
    {
        _onStopCalled = true;
    }


}
}
