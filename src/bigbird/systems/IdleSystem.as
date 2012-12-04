package bigbird.systems
{
import bigbird.controller.StopTick;

import net.richardlord.ash.core.Game;
import net.richardlord.ash.core.System;

public class IdleSystem extends System
{

    private var _stop:StopTick;
    private var _idlingNumber:int = 1;
    private var _game:Game;

    public function IdleSystem( stop:StopTick )
    {
        _stop = stop;
    }

    public function set idlingNumber( val:int ):void
    {
        _idlingNumber = val;
    }

    public function get idlingNumber():int
    {
        return _idlingNumber;
    }

    override public function addToGame( game:Game ):void
    {
        _game = game;
    }

    override public function removeFromGame( game:Game ):void
    {
        _stop.removeAll();
        _stop = null;
    }

    override public function update( time:Number ):void
    {
        const systemsInGame:int = _game.systems.length;
        if ( systemsInGame <= _idlingNumber )
        {
            _stop.dispatch();
        }
    }


}
}
