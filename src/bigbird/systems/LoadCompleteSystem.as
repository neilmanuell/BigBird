package bigbird.systems
{
import bigbird.controller.EntityStateNames;
import bigbird.core.WordDataSignal;
import bigbird.nodes.LoadingNode;
import bigbird.systems.utils.SelfRemovingSystem;
import bigbird.systems.utils.SystemRemoval;

import net.richardlord.ash.core.Entity;
import net.richardlord.ash.core.Game;
import net.richardlord.ash.core.NodeList;
import net.richardlord.ash.core.System;

public class LoadCompleteSystem extends System implements SelfRemovingSystem
{

    private var _loadingNodes:NodeList;
    private var _systemRemoval:SystemRemoval;
    private var _onLoaded:WordDataSignal;
    private var _destroyEntity:Function;

    public function LoadCompleteSystem( onLoaded:WordDataSignal )
    {
        _onLoaded = onLoaded;
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
        const that:System = this;
        const onRemove:Function = function ():void
        {
            game.removeSystem( that );
        };

        _systemRemoval = new SystemRemoval( onRemove, game.updateComplete );
        _loadingNodes = game.getNodeList( LoadingNode );

        _destroyEntity = function ( entity:Entity ):void
        {
            game.removeEntity( entity );
        }
    }


    override public function removeFromGame( game:Game ):void
    {
        _loadingNodes = null;
        _systemRemoval = null;
        _destroyEntity = null;
    }

    override public function update( time:Number ):void
    {
        for ( var node:LoadingNode = _loadingNodes.head; node; node = node.next )
        {
            if ( node.loader.isLoadComplete )
            {
                _onLoaded.dispatchWordData( node.loader );

                if ( node.loader.success )
                {
                    node.wordData.setData( node.loader.data );
                    node.fsm.changeState( EntityStateNames.DECODING );
                }
                else
                {
                    _destroyEntity( node.entity );
                }

            }
            else
            {
                _systemRemoval.confirmActivity();
            }
        }

        _systemRemoval.applyActivity();

    }


}
}
