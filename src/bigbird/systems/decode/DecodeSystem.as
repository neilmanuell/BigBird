package bigbird.systems.decode
{
import bigbird.nodes.DecodeNode;
import bigbird.systems.utils.removal.SelfRemovingSystem;
import bigbird.systems.utils.removal.SystemRemoval;

import flash.utils.getTimer;

import net.richardlord.ash.core.Game;
import net.richardlord.ash.core.NodeList;
import net.richardlord.ash.core.System;

public class DecodeSystem extends System implements SelfRemovingSystem
{
    private var _decoder:DecodeFromWordFile;
    private var _decodeNodes:NodeList;
    private var _systemRemoval:SystemRemoval;

    public function DecodeSystem( decoder:DecodeFromWordFile )
    {
        _decoder = decoder;
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
        _decodeNodes = game.getNodeList( DecodeNode );
    }

    override public function removeFromGame( game:Game ):void
    {
        super.removeFromGame( game );
    }

    override public function update( time:Number ):void
    {
        if ( !_decodeNodes.empty )
        {
            _systemRemoval.confirmActivity();

            for ( var node:DecodeNode = _decodeNodes.head; node; node = node.next )
            {
                updateNode( node, time );

            }
        }

        _systemRemoval.applyActivity();
    }

    internal function updateNode( node:DecodeNode, time:Number ):void
    {
        const timeBefore:Number = getTimer();
        var count:int = 0;

        while ( node.document.hasNext && count < node.chunker.chunkingSize )
        {
            _decoder.decode( node.request, node.document );
            count++;
        }

        node.chunker.previousChunkingTime = getTimer() - timeBefore;

    }
}
}
