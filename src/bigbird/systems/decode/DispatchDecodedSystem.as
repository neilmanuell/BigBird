package bigbird.systems.decode
{
import bigbird.api.signals.OnDecoded;
import bigbird.nodes.KeyValuePairNode;
import bigbird.systems.BaseSelfRemovingSystem;

public class DispatchDecodedSystem extends BaseSelfRemovingSystem
{
    private var _signal:OnDecoded;

    public function DispatchDecodedSystem( signal:OnDecoded )
    {
        super( KeyValuePairNode, updateNode );
        _signal = signal;
    }

    internal function updateNode( node:KeyValuePairNode, time:Number ):void
    {
        if ( !node.info.dispatched )
        {
            _signal.dispatchKeyValuePair( node );
            node.info.dispatched = true;
            confirmActivity();
        }
    }


}
}
