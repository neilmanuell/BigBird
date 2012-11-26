package bigbird.systems
{
import bigbird.components.BigBirdProgress;
import bigbird.nodes.DecodeNode;
import bigbird.systems.utils.SelfRemovingSystem;
import bigbird.systems.utils.SystemRemoval;

import net.richardlord.ash.core.Game;
import net.richardlord.ash.core.NodeList;
import net.richardlord.ash.core.System;

public class DecodeProgressSystem extends System implements SelfRemovingSystem
{
    private var _progress:BigBirdProgress;
    private var _decodingNodes:NodeList;
    private var _systemRemoval:SystemRemoval;

    public function DecodeProgressSystem( progress:BigBirdProgress )
    {
        _progress = progress;
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
                _progress.totalWork += node.document.length;
                _progress.workDone += node.document.position;
            }
            _systemRemoval.confirmActivity();
        }

        _systemRemoval.applyActivity();
    }
}
}
