package bigbird.systems
{
import bigbird.components.BigBirdProgress;
import bigbird.nodes.DecodeNode;
import bigbird.nodes.LoadingNode;

import net.richardlord.ash.core.Game;
import net.richardlord.ash.core.NodeList;

public class DecodingProgress
{
    private var _progress:BigBirdProgress;
    private var _stateMachine:StateMachine;
    private var _decodingNodes:NodeList;

    public function DecodingProgress( progress:BigBirdProgress, stateMachine:StateMachine )
    {
        _progress = progress;
        _stateMachine = stateMachine;
    }

    public function addToGame( game:Game ):void
    {
        _decodingNodes = game.getNodeList( DecodeNode );
    }

    public function removeFromGame( game:Game ):void
    {
        _decodingNodes = null;
    }

    public function update( time:Number ):void
    {
        _progress.totalDecodingWork = 0;
        _progress.decodingWorkDone = 0;

        for ( var node:DecodeNode = _decodingNodes.head; node; node = node.next )
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
