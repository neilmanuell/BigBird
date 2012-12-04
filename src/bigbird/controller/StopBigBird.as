package bigbird.controller
{
import bigbird.api.signals.OnStop;

import net.richardlord.ash.core.Game;
import net.richardlord.ash.tick.TickProvider;

public class StopBigBird
{
    [Inject]
    public var game:Game;


    [Inject]
    public var tickProvider:TickProvider;

    [Inject]
    public var onStop:OnStop;


    public function stop():void
    {
        tickProvider.stop();
        tickProvider.remove( game.update );
        onStop.dispatch();

    }


}
}
