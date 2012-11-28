package bigbird.systems.decode
{
import bigbird.core.KeyValuePairSignal;
import bigbird.nodes.KeyValuePairNode;

import net.richardlord.ash.tools.ListIteratingSystem;

public class DispatchDecodedSystem extends ListIteratingSystem
{
    private var _signal:KeyValuePairSignal;

    public function DispatchDecodedSystem( signal:KeyValuePairSignal )
    {
        super( KeyValuePairNode, updateNode );
        _signal = signal;
    }

    internal function updateNode( node:KeyValuePairNode, time:Number ):void
    {
        /* if ( node.state.hasDispatched )return;
         node.state.hasDispatched = true;             */
        _signal.dispatchKeyValuePair( node.request, node.uid.index, node.key, node.value );
    }


}
}
