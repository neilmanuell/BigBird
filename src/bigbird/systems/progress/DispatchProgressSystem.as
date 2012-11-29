package bigbird.systems.progress
{
import bigbird.components.BigBirdProgress;
import bigbird.controller.Removals;
import bigbird.systems.utils.removal.ActivityMonitor;
import bigbird.systems.utils.removal.SelfRemovingSystem;

import net.richardlord.ash.core.Game;
import net.richardlord.ash.core.System;

public class DispatchProgressSystem extends System implements SelfRemovingSystem
{
    public function DispatchProgressSystem( progress:BigBirdProgress )
    {
        _progress = progress;
    }

    private var _progress:BigBirdProgress;
    private var _activityMonitor:ActivityMonitor;
    private var _removals:Removals;

    override public function addToGame( game:Game ):void
    {
        defineActivityMonitor( game );
    }

    [Inject]
    public function set activityMonitor( value:ActivityMonitor ):void
    {
        _activityMonitor = value;
    }

    [Inject]
    public function set removals( value:Removals ):void
    {
        _removals = value;
    }

    private function defineActivityMonitor( game:Game ):void
    {
        const self:System = this;
        const onRemove:Function = function ():void
        {
            _removals.removeSystem( self );
        };

        _activityMonitor.onLimit = onRemove;
        _activityMonitor.updateComplete = game.updateComplete;
    }

    public function get flaggedForRemove():Boolean
    {
        return _activityMonitor.flaggedForRemove;
    }

    public function cancelRemoval():void
    {
        _activityMonitor.cancelRemoval();
    }

    override public function removeFromGame( game:Game ):void
    {
        _removals = null;
        _activityMonitor = null;
    }

    override public function update( time:Number ):void
    {
        if ( !isNaN( _progress.workDone / _progress.totalWork ) )
        {
            _activityMonitor.confirmActivity();
            _progress.dispatch();
        }

        _progress.workDone = 0;
        _progress.totalWork = 0;

        _activityMonitor.applyActivity();
    }


}
}
