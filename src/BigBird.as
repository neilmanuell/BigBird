package
{

import bigbird.components.BigBirdState;
import bigbird.configuration.configureSingletonSystemFactory;
import bigbird.core.KeyValuePairSignal;
import bigbird.core.ProgressSignal;
import bigbird.factories.EntityFactory;
import bigbird.factories.SingletonSystemFactory;
import bigbird.systems.StateMachine;

import flash.display.Sprite;
import flash.net.URLRequest;

import net.richardlord.ash.core.Game;
import net.richardlord.ash.tick.FrameTickProvider;

public class BigBird extends Sprite
{
    public const onDecoded:KeyValuePairSignal = new KeyValuePairSignal();
    public const onProgress:ProgressSignal = new ProgressSignal();

    public const game:Game = new Game();
    public var stateMachine:StateMachine;

    private var _tickProvider:FrameTickProvider;
    private var _entityFactory:EntityFactory;

    public function BigBird()
    {
        prepare();
    }

    private function prepare():void
    {
        _tickProvider = new FrameTickProvider( this );
        _entityFactory = new EntityFactory( game );
        const factory:SingletonSystemFactory = new SingletonSystemFactory( game );
        stateMachine = createStateMachine( factory );
        configureSingletonSystemFactory( factory, this );
    }

    public function createStateMachine( factory:SingletonSystemFactory ):StateMachine
    {
        const state:BigBirdState = new BigBirdState( game.updateComplete );
        state.onActive.add( start );
        state.onInactive.add( stop );

        return new StateMachine( state, factory );
    }

    public function start():void
    {
        _tickProvider.add( game.update );
        _tickProvider.start();
    }

    public function stop():void
    {
        _tickProvider.remove( game.update );
        _tickProvider.stop();
    }


    public function load( url:URLRequest ):void
    {

    }

    public function addRawDocumentXML( url:URLRequest, xml:XML ):void
    {
        _entityFactory.createDocument( "hello", xml );
        stateMachine.enterDecodingState();
        start();
    }


}
}
