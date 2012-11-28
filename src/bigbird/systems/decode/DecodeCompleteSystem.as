package bigbird.systems.decode
{
import bigbird.nodes.DecodeNode;
import bigbird.systems.utils.removal.SelfRemovingSystem;
import bigbird.systems.utils.removal.SystemRemoval;

import net.richardlord.ash.core.Entity;
import net.richardlord.ash.core.Game;
import net.richardlord.ash.core.NodeList;
import net.richardlord.ash.core.System;

public class DecodeCompleteSystem extends System implements SelfRemovingSystem
{

    private var _decodingNodes:NodeList;
    private var _systemRemoval:SystemRemoval;
    private var _destroyEntity:Function;


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
        createRemoval( game );
        _decodingNodes = game.getNodeList( DecodeNode );
    }

    private function createRemoval( game:Game ):void
    {
        const that:System = this;
        const onRemove:Function = function ():void
        {
            game.removeSystem( that );
        };

        _systemRemoval = new SystemRemoval( onRemove, game.updateComplete );

        _destroyEntity = function ( entity:Entity ):void
        {
            game.removeEntity( entity );
        }
    }

    override public function removeFromGame( game:Game ):void
    {
        _decodingNodes = null;
        _systemRemoval = null;
    }

    override public function update( time:Number ):void
    {

        if ( !_decodingNodes.empty )
        {
            for ( var node:DecodeNode = _decodingNodes.head; node; node = node.next )
            {
                if ( !node.document.hasNext )
                    _destroyEntity( node.entity );

            }
            _systemRemoval.confirmActivity();
        }

        _systemRemoval.applyActivity();
    }


}
}
