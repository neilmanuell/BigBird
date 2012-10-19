package bigbird.systems
{
import bigbird.components.BigBirdProgress;

import net.richardlord.ash.core.Game;
import net.richardlord.ash.core.System;

public class ProgressSystem extends System
{


    private var _loadingProgress:LoadingProgress;
    private var _decodingProgress:DecodingProgress;

    public function ProgressSystem( progress:BigBirdProgress, stateMachine:StateMachine )
    {
        _decodingProgress = new DecodingProgress( progress, stateMachine );
        _loadingProgress = new LoadingProgress( progress, stateMachine );
    }

    override public function addToGame( game:Game ):void
    {
        _decodingProgress.addToGame( game );
        _loadingProgress.addToGame( game );
    }

    override public function removeFromGame( game:Game ):void
    {
        _decodingProgress.removeFromGame( game );
        _loadingProgress.removeFromGame( game );
    }

    override public function update( time:Number ):void
    {
        _loadingProgress.update( time );
        _decodingProgress.update( time );

    }


}
}
