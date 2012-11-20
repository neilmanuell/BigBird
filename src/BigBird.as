package
{

import bigbird.components.BigBirdProgress;
import bigbird.core.KeyValuePairSignal;
import bigbird.core.ProgressSignal;
import bigbird.factories.WordEntityFactory;
import bigbird.systems.utils.addLoadingSystems;

import flash.display.Sprite;
import flash.net.URLRequest;

import net.richardlord.ash.core.Game;
import net.richardlord.ash.tick.FrameTickProvider;

public class BigBird extends Sprite
{
    public const onDecoded:KeyValuePairSignal = new KeyValuePairSignal();
    public const onProgress:ProgressSignal = new ProgressSignal();

    public const game:Game = new Game();

    private var _tickProvider:FrameTickProvider;
    private var _wordEntityFactory:WordEntityFactory;
    private var _progress:BigBirdProgress;

    public function BigBird()
    {
        prepare();
    }

    private function prepare():void
    {
        _tickProvider = new FrameTickProvider( this );
        _wordEntityFactory = new WordEntityFactory( game );
        _progress = new BigBirdProgress( onProgress );

    }


    public function start():void
    {
        _tickProvider.add( game.update );
        _tickProvider.start();
    }

    public function stop():void
    {
        _tickProvider.stop();
        _tickProvider.remove( game.update );
    }


    public function load( url:URLRequest ):void
    {
        _wordEntityFactory.createWordFileEntity( url );
        addLoadingSystems( game, _progress );
    }


}
}
