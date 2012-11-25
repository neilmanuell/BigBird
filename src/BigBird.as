package
{

import bigbird.components.BigBirdProgress;
import bigbird.core.KeyValuePairSignal;
import bigbird.core.ProgressSignal;
import bigbird.core.StopSignal;
import bigbird.core.WordDataSignal;
import bigbird.factories.WordEntityFactory;
import bigbird.systems.IdleSystem;
import bigbird.systems.LoadCompleteSystem;
import bigbird.systems.LoadProgressSystem;
import bigbird.systems.SystemPriority;
import bigbird.systems.utils.AddAllLoadingSystems;

import flash.display.Sprite;
import flash.net.URLRequest;

import net.richardlord.ash.core.Game;
import net.richardlord.ash.integration.swiftsuspenders.SwiftSuspendersGame;
import net.richardlord.ash.tick.FrameTickProvider;

import org.swiftsuspenders.Injector;

public class BigBird extends Sprite
{
    public const onLoaded:WordDataSignal = new WordDataSignal();
    public const onDecoded:KeyValuePairSignal = new KeyValuePairSignal();
    public const onProgress:ProgressSignal = new ProgressSignal();
    public const onStop:StopSignal = new StopSignal();

    private var _game:Game;
    private var _tickProvider:FrameTickProvider;
    private var _injector:Injector;
    private var _active:Boolean;

    public function BigBird()
    {
        prepare();
    }

    private function prepare():void
    {
        _injector = new Injector();
        _game = new SwiftSuspendersGame( _injector );
        _tickProvider = new FrameTickProvider( this );

        _injector.map( Game ).toValue( _game );
        _injector.map( Injector ).toValue( _injector );
        _injector.map( AddAllLoadingSystems );
        _injector.map( WordEntityFactory ).asSingleton();
        _injector.map( ProgressSignal ).toValue( onProgress );
        _injector.map( WordDataSignal ).toValue( onLoaded );
        _injector.map( StopSignal ).toValue( onStop );
        _injector.map( BigBirdProgress ).asSingleton();
        _injector.map( LoadProgressSystem );
        _injector.map( LoadCompleteSystem );
        _injector.map( IdleSystem );


        _game.addSystem( _injector.getInstance( IdleSystem ), SystemPriority.IDLE_CHECK );


        onStop.add( stop );
    }


    public function start():void
    {
        if ( _active )return;
        _active = true;
        _tickProvider.add( _game.update );
        _tickProvider.start();
    }

    public function stop():void
    {
        if ( !_active )return;
        _active = false;
        _tickProvider.stop();
        _tickProvider.remove( _game.update );
    }


    public function load( request:URLRequest ):void
    {
        const factory:WordEntityFactory = _injector.getInstance( WordEntityFactory );
        factory.createWordFileEntity( request );
        start();
    }


}
}
