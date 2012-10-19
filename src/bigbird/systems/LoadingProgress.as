package bigbird.systems
{
import bigbird.components.BigBirdProgress;
import bigbird.nodes.LoadingNode;

import net.richardlord.ash.core.Game;
import net.richardlord.ash.core.NodeList;
import net.richardlord.signals.Signal0;

public class LoadingProgress
{
    private var _progress:BigBirdProgress;
    private var _stateMachine:StateMachine;
    private var _loadingNodes:NodeList;
    private var _updateComplete:Signal0;

    public function LoadingProgress( progress:BigBirdProgress, stateMachine:StateMachine )
    {
        _progress = progress;
        _stateMachine = stateMachine;
    }

    public function addToGame( game:Game ):void
    {
        _updateComplete = game.updateComplete;
        _loadingNodes = game.getNodeList( LoadingNode );
    }

    public function removeFromGame( game:Game ):void
    {
        _loadingNodes = null;
        _updateComplete = null;
    }

    public function update( time:Number ):void
    {
        _progress.totalLoadingWork = 0;
        _progress.loadingWorkDone = 0;

        for ( var node:LoadingNode = _loadingNodes.head; node; node = node.next )
        {
            // we need to map to local value as the stubbed Loader in test will get called twice
            const bytesTotal:int = node.loader.loader.bytesTotal;
            const bytesLoaded:int = node.loader.loader.bytesLoaded;

            _progress.totalLoadingWork += bytesTotal
            _progress.loadingWorkDone += bytesLoaded;

            if ( bytesLoaded == bytesTotal )
            {
                scheduleDataTransferOnUpdateComplete( node );
            }
        }

        if ( _progress.totalLoadingWork == _progress.loadingWorkDone )
        {
            _stateMachine.exitLoadingState();
        }


    }

    private function scheduleDataTransferOnUpdateComplete( node:LoadingNode ):void
    {
        const onUpdateComplete:Function = function ():void
        {
            node.state.enterDecodingState(  );
        }
        _updateComplete.addOnce( onUpdateComplete );

    }
}
}
