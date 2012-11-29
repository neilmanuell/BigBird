package bigbird.systems.decode
{
import bigbird.components.BigBirdProgress;
import bigbird.nodes.DecodeNode;
import bigbird.systems.BaseSelfRemovingSystem;

public class DecodeProgressSystem extends BaseSelfRemovingSystem
{
    private var _progress:BigBirdProgress;

    public function DecodeProgressSystem( progress:BigBirdProgress )
    {
        super( DecodeNode, updateNode );
        _progress = progress;
    }


    public function updateNode( node:DecodeNode, time:Number ):void
    {
        _progress.totalWork += node.document.length;
        _progress.workDone += node.document.position;

        confirmActivity();

    }
}
}
