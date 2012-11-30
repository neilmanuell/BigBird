package bigbird.systems
{
import bigbird.controller.Removals;
import bigbird.systems.utils.removal.ActivityMonitor;
import bigbird.systems.utils.removal.SelfRemovingSystem;

import net.richardlord.ash.core.Entity;
import net.richardlord.ash.core.Game;
import net.richardlord.ash.core.System;
import net.richardlord.ash.tools.ListIteratingSystem;

public class BaseSelfRemovingSystem extends ListIteratingSystem implements SelfRemovingSystem
{
    private var _activityMonitor:ActivityMonitor;
    private var _removals:Removals;

    public function BaseSelfRemovingSystem( nodeClass:Class, nodeUpdateFunction:Function )
    {
        super( nodeClass, nodeUpdateFunction );
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

    public function get flaggedForRemove():Boolean
    {
        return _activityMonitor.flaggedForRemove;
    }

    public function cancelRemoval():void
    {
        _activityMonitor.cancelRemoval();
    }

    protected function confirmActivity():void
    {
        _activityMonitor.confirmActivity();
    }

    override public function addToGame( game:Game ):void
    {
        super.addToGame( game );
        defineActivityMonitor( game );
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

    protected function destroyEntity( entity:Entity ):void
    {
        _removals.removeEntity( entity );
    }

    override public function removeFromGame( game:Game ):void
    {
        super.removeFromGame( game );
        _activityMonitor = null;
        _removals = null;
    }

    override public function update( time:Number ):void
    {
        super.update( time );
        _activityMonitor.applyActivity();
    }


}
}
