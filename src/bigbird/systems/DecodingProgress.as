package bigbird.systems
{
import bigbird.components.BigBirdProgress;
import bigbird.nodes.DecodeNode;

import net.richardlord.ash.core.Game;
import net.richardlord.ash.core.NodeList;
import net.richardlord.ash.core.System;

public class DecodingProgress extends System
{
    private var _progress:BigBirdProgress;
    private var _decodingNodes:NodeList;

    public function DecodingProgress( progress:BigBirdProgress )
    {
        _progress = progress;
    }

    override public function addToGame( game:Game ):void
    {
        _decodingNodes = game.getNodeList( DecodeNode );
    }

    override public function removeFromGame( game:Game ):void
    {
        _decodingNodes = null;
    }

    override public function update( time:Number ):void
    {


        for ( var node:DecodeNode = _decodingNodes.head; node; node = node.next )
        {
            _progress.totalWork += node.document.length;
            _progress.workDone += node.document.position;
        }

    }
}
}
