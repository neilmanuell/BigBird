package bigbird.systems.decode
{
import bigbird.core.KeyValuePairSignal;
import bigbird.nodes.KeyValuePairInfoNode;
import bigbird.nodes.KeyValuePairNode;
import bigbird.systems.BaseSelfRemovingSystem;

public class DispatchDecodedSystem extends BaseSelfRemovingSystem
{
    private var _signal:KeyValuePairSignal;

    public function DispatchDecodedSystem( signal:KeyValuePairSignal )
    {
        super( KeyValuePairInfoNode, updateNode );
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
