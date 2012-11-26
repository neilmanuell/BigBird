package bigbird.controller
{
import net.richardlord.ash.core.Game;
import net.richardlord.ash.tick.TickProvider;

public class StartBigBird
{
    [Inject]
    public var game:Game;


    [Inject]
    public var tickProvider:TickProvider;


    public function start():void
    {
        tickProvider.add( game.update );
        tickProvider.start();
    }


}
}
