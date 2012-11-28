package
{

import bigbird.components.BigBirdProgress;
import bigbird.controller.BigBirdFSMController;
import bigbird.controller.StartBigBird;
import bigbird.controller.StartWordFileLoad;
import bigbird.controller.StopBigBird;
import bigbird.core.KeyValuePairSignal;
import bigbird.core.ProgressSignal;
import bigbird.core.StopSignal;
import bigbird.core.WordDataSignal;
import bigbird.factories.WordEntityFactory;
import bigbird.systems.IdleSystem;
import bigbird.systems.SystemPriority;
import bigbird.systems.load.LoadCompleteSystem;
import bigbird.systems.load.LoadProgressSystem;
import bigbird.systems.utils.removal.AddLoadingSystems;

import flash.display.Sprite;
import flash.net.URLRequest;

import net.richardlord.ash.core.Game;
import net.richardlord.ash.tick.FrameTickProvider;
import net.richardlord.ash.tick.TickProvider;

import org.swiftsuspenders.Injector;

public class BigBird extends Sprite
{
    public const onLoaded:WordDataSignal = new WordDataSignal();
    public const onDecoded:KeyValuePairSignal = new KeyValuePairSignal();
    public const onProgress:ProgressSignal = new ProgressSignal();
    public const onStop:StopSignal = new StopSignal();

    private var _injector:Injector;

    public function BigBird()
    {
        prepare();
    }

    private function prepare():void
    {
        const game:Game = new Game();

        _injector = new Injector();

        _injector.map( Game ).toValue( game );
        _injector.map( TickProvider ).toValue( new FrameTickProvider( this ) );
        _injector.map( Injector ).toValue( _injector );
        _injector.map( AddLoadingSystems );
        _injector.map( WordEntityFactory ).asSingleton();
        _injector.map( ProgressSignal ).toValue( onProgress );
        _injector.map( WordDataSignal ).toValue( onLoaded );
        _injector.map( KeyValuePairSignal ).toValue( onDecoded );
        _injector.map( StopSignal ).toValue( onStop );
        _injector.map( BigBirdProgress ).asSingleton();
        _injector.map( BigBirdFSMController ).asSingleton();
        _injector.map( LoadProgressSystem );
        _injector.map( LoadCompleteSystem );
        _injector.map( IdleSystem );

        game.addSystem( _injector.getInstance( IdleSystem ), SystemPriority.IDLE_CHECK );
        onStop.add( stop );
    }


    public function start():void
    {
        _injector.getInstance( StartBigBird ).start();
    }

    public function stop():void
    {
        _injector.getInstance( StopBigBird ).stop();
    }

    public function load( request:URLRequest ):void
    {
        _injector.getInstance( StartWordFileLoad ).load( request );
        start();
    }


}
}
