package bigbird.systems.progress
{
import bigbird.components.BigBirdProgress;
import bigbird.nodes.LoadingProgressNode;
import bigbird.systems.utils.removal.SelfRemovingSystem;
import bigbird.systems.utils.removal.SystemRemoval;

import net.richardlord.ash.core.Game;
import net.richardlord.ash.core.NodeList;
import net.richardlord.ash.core.System;

public class DispatchProgressSystem extends System implements SelfRemovingSystem
{
    public function DispatchProgressSystem( progress:BigBirdProgress )
    {
        _progress = progress;
    }

    private var _progress:BigBirdProgress;
    private var _progressNodes:NodeList;
    private var _systemRemoval:SystemRemoval;

    override public function addToGame( game:Game ):void
    {
        const that:System = this;
        const onRemove:Function = function ():void
        {
            game.removeSystem( that );
        };

        _systemRemoval = new SystemRemoval( onRemove, game.updateComplete );

        _progressNodes = game.getNodeList( LoadingProgressNode );
    }

    public function get flaggedForRemove():Boolean
    {
        return _systemRemoval.flaggedForRemove;
    }

    public function cancelRemoval():void
    {
        _systemRemoval.cancelRemoval();
    }


    override public function removeFromGame( game:Game ):void
    {
        _progressNodes = null;
        _systemRemoval = null;
    }

    override public function update( time:Number ):void
    {
        if ( !isNaN( _progress.workDone / _progress.totalWork ) )
        {
            _systemRemoval.confirmActivity();
            _progress.dispatch();
        }
        _progress.workDone = 0;
        _progress.totalWork = 0;

        _systemRemoval.applyActivity();
    }


}
}
