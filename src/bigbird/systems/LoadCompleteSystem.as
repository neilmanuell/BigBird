package bigbird.systems
{
import bigbird.components.EntityStateNames;
import bigbird.nodes.LoadingNode;
import bigbird.systems.utils.SystemRemoval;

import net.richardlord.ash.core.Game;
import net.richardlord.ash.core.NodeList;
import net.richardlord.ash.core.System;

public class LoadCompleteSystem extends System
{

    private var _loadingNodes:NodeList;
    private var _systemRemoval:SystemRemoval;

    override public function addToGame( game:Game ):void
    {
        const that:System = this;
        const onRemove:Function = function ():void
        {
            game.removeSystem( that );
        };

        _systemRemoval = new SystemRemoval( onRemove, game.updateComplete );
        _loadingNodes = game.getNodeList( LoadingNode );
    }

    override public function removeFromGame( game:Game ):void
    {
        _loadingNodes = null;
        _systemRemoval = null;
    }

    override public function update( time:Number ):void
    {
        _systemRemoval.resetActivity();

        for ( var node:LoadingNode = _loadingNodes.head; node; node = node.next )
        {
            if ( node.loader.isLoadComplete )
            {
                node.wordData.setData( node.loader.data );
                node.fsm.changeState( EntityStateNames.DECODING );
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
