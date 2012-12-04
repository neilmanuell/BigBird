package
{

import bigbird.api.signals.LoadWordScript;
import bigbird.api.signals.OnDecoded;
import bigbird.api.signals.OnLoaded;
import bigbird.api.signals.OnProgress;
import bigbird.api.signals.OnStop;
import bigbird.components.BigBirdProgress;
import bigbird.controller.BigBirdFSMController;
import bigbird.controller.StartBigBird;
import bigbird.controller.StartWordFileLoad;
import bigbird.controller.StopBigBird;
import bigbird.controller.StopTick;
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
    public const onLoaded:OnLoaded = new OnLoaded();
    public const onDecoded:OnDecoded = new OnDecoded();
    public const onProgress:OnProgress = new OnProgress();
    public const onStop:OnStop = new OnStop();

    private const stopTick:StopTick = new StopTick();
    private const loadWordScript:LoadWordScript = new LoadWordScript();

    private var _injector:Injector;

    public function BigBird( shellinjector:Injector = null )
    {
        prepare();
        injectShell( shellinjector );
    }


    public function load( request:URLRequest ):void
    {

        _injector.getInstance( StartWordFileLoad ).load( request );
        start();
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
        _injector.map( OnProgress ).toValue( onProgress );
        _injector.map( OnLoaded ).toValue( onLoaded );
        _injector.map( OnDecoded ).toValue( onDecoded );
        _injector.map( OnStop ).toValue( onStop );
        _injector.map( StopTick ).toValue( stopTick );
        _injector.map( BigBirdProgress ).asSingleton();
        _injector.map( BigBirdFSMController ).asSingleton();
        _injector.map( LoadProgressSystem );
        _injector.map( LoadCompleteSystem );
        _injector.map( IdleSystem );

        game.addSystem( _injector.getInstance( IdleSystem ), SystemPriority.IDLE_CHECK );
        stopTick.add( stop );
        loadWordScript.add( load );
    }

    private function injectShell( shellinjector:Injector ):void
    {
        if ( shellinjector == null ) return;
        shellinjector.map( OnProgress ).toValue( onProgress );
        shellinjector.map( OnLoaded ).toValue( onLoaded );
        shellinjector.map( OnDecoded ).toValue( onDecoded );
        shellinjector.map( OnStop ).toValue( onStop );
        shellinjector.map( LoadWordScript ).toValue( loadWordScript );
    }


    protected function start():void
    {
        _injector.getInstance( StartBigBird ).start();
    }

    protected function stop():void
    {
        _injector.getInstance( StopBigBird ).stop();
    }


}
}
