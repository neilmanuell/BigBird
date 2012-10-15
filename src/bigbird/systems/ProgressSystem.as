package bigbird.systems
{
import bigbird.components.BigBirdProgress;
import bigbird.nodes.DecodeNode;

import net.richardlord.ash.core.Game;
import net.richardlord.ash.core.NodeList;
import net.richardlord.ash.core.System;

public class ProgressSystem extends System
{
    private var _stateMachine:StateMachine;
    private var _decodeNodes:NodeList;
    private var _progress:BigBirdProgress;

    public function ProgressSystem( progress:BigBirdProgress, stateMachine:StateMachine )
    {
        _stateMachine = stateMachine;
        _progress = progress;
    }

    override public function addToGame( game:Game ):void
    {
        _decodeNodes = game.getNodeList( DecodeNode )
    }

    override public function removeFromGame( game:Game ):void
    {
        _decodeNodes = null;
    }

    override public function update( time:Number ):void
    {
        _progress.totalDecodingWork = 0;
        _progress.decodingWorkDone = 0;

        for ( var node:DecodeNode = _decodeNodes.head; node; node = node.next )
        {
            _progress.totalDecodingWork += node.progress.totalWork;
            _progress.decodingWorkDone += node.progress.workDone;
        }

        if ( _progress.totalDecodingWork == _progress.decodingWorkDone )
        {
            _stateMachine.exitDecodingState();
        }
    }


}
}
