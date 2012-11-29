package bigbird.controller
{

import flash.events.Event;

import mockolate.nice;
import mockolate.prepare;
import mockolate.received;

import net.richardlord.ash.core.Entity;
import net.richardlord.ash.core.Game;
import net.richardlord.ash.core.System;

import org.flexunit.async.Async;
import org.hamcrest.assertThat;

public class RemovalsTest
{
    private var _game:Game;

    [Before(order=1, async, timeout=5000)]
    public function prepareMockolates():void
    {
        Async.proceedOnEvent( this,
                prepare( Game, Entity, System ),
                Event.COMPLETE );
    }

    [Before(order=2)]
    public function before():void
    {
        _game = nice( Game );
    }

    [After]
    public function after():void
    {
    }

    [Test]
    public function removeEntity_calls_removeEntity_on_Game():void
    {
        const entity:Entity = nice( Entity );
        removeEntity( entity );
        assertThat( _game, received().method( "removeEntity" ).arg( entity ).once() )
    }

    [Test]
    public function removeSystem_calls_removeSystem_on_Game():void
    {
        const system:System = nice( System );
        removeSystem( system );
        assertThat( _game, received().method( "removeSystem" ).arg( system ).once() )
    }

    public function removeEntity( entity:Entity ):void
    {
        _game.removeEntity( entity );
    }

    public function removeSystem( system:System ):void
    {
        _game.removeSystem( system );
    }
}
}
