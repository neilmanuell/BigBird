package bigbird.systems
{
import bigbird.systems.utils.removal.SelfRemovingSystem;
import bigbird.systems.utils.removal.SystemRemoval;

import net.richardlord.ash.core.Entity;
import net.richardlord.ash.core.Game;
import net.richardlord.ash.core.System;
import net.richardlord.ash.tools.ListIteratingSystem;

public class BaseSelfRemovingSystem extends ListIteratingSystem implements SelfRemovingSystem
{
    private var _systemRemoval:SystemRemoval;
    protected var destroyEntity:Function;

    public function BaseSelfRemovingSystem( nodeClass:Class, nodeUpdateFunction:Function, nodeAddedFunction:Function = null, nodeRemovedFunction:Function = null )
    {
        super( nodeClass, nodeUpdateFunction, nodeAddedFunction, nodeRemovedFunction );
    }

    public function get flaggedForRemove():Boolean
    {
        return _systemRemoval.flaggedForRemove;
    }

    public function cancelRemoval():void
    {
        _systemRemoval.cancelRemoval();
    }

    override public function addToGame( game:Game ):void
    {
        super.addToGame( game );
        defineRemoval( game );
        defineDestroyEntity( game );
    }

    private function defineDestroyEntity( game:Game ):void
    {
        destroyEntity = function ( entity:Entity ):void
        {
            game.removeEntity( entity );
        }
    }

    private function defineRemoval( game:Game ):void
    {
        const that:System = this;
        const onRemove:Function = function ():void
        {
            game.removeSystem( that );
        };

        _systemRemoval = new SystemRemoval( onRemove, game.updateComplete );
    }


    override public function removeFromGame( game:Game ):void
    {
        super.removeFromGame( game );
        _systemRemoval = null;
        destroyEntity = null;
    }

    override public function update( time:Number ):void
    {
        super.update( time );
        _systemRemoval.applyActivity();
    }


}
}
