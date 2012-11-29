package bigbird.systems.load
{
import bigbird.components.BigBirdProgress;
import bigbird.nodes.LoadProgressNode;
import bigbird.systems.BaseSelfRemovingSystem;

public class LoadProgressSystem extends BaseSelfRemovingSystem
{
    public function LoadProgressSystem( progress:BigBirdProgress )
    {
        super( LoadProgressNode, updateNode );
        _progress = progress;
    }

    private var _progress:BigBirdProgress;


    public function updateNode( node:LoadProgressNode, time:Number ):void
    {
        _progress.totalWork += node.loader.bytesTotal;
        _progress.workDone += node.loader.bytesLoaded;

        confirmActivity();

    }


}
}
