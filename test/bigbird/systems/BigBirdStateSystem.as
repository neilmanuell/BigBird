package bigbird.systems
{
import bigbird.components.BigBirdState;

import net.richardlord.ash.core.Game;
import net.richardlord.ash.core.System;

import supporting.MockGame;

public class BigBirdStateSystem extends System
{
    private var _game:MockGame;

    [Before]
    public function before():void
    {
        _game = new MockGame();
        _state = new BigBirdState();
    }

    [After]
    public function after():void
    {
    }

    [Test]
    public function addToGame_adds_listener():void
    {
        addToGame( _game );
        //assertThat( _game.getSystem( DecodeSystem ), instanceOf( DecodeSystem ) );
    }

    [Test]
    public function test():void
    {

    }


    private var _state:BigBirdState

    override public function addToGame( game:Game ):void
    {
        //game.updateComplete.add( onUpdateComplete )

    }

    private const systemsToBeRemoved:Vector.<System> = new <System>[];

    private function onUpdateComplete():void
    {
        systemsToBeRemoved
    }

    private function enterDecodingState():void
    {
        _game.addSystem( new DecodeSystem( null ), 0 );
    }

    override public function removeFromGame( game:Game ):void
    {

    }

    override public function update( time:Number ):void
    {

    }
}
}
