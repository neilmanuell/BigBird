package bigbird.systems
{
import bigbird.core.KeyValuePairSignal;
import bigbird.nodes.KeyValuePairNode;

import net.richardlord.ash.tools.ListIteratingSystem;
import net.richardlord.signals.Signal2;

public class DispatchKeyValuePairSystem extends ListIteratingSystem
{
    private var _signal:KeyValuePairSignal;

    public function DispatchKeyValuePairSystem( signal:KeyValuePairSignal )
    {
        super( KeyValuePairNode, updateNode );
        _signal = signal;
    }

    internal function updateNode( node:KeyValuePairNode, time:Number ):void
    {
        if ( node.state.hasDispatched )return;
        node.state.hasDispatched = true;
        _signal.dispatchKeyValuePair( node.uid.groupID, node.key, node.value );
    }

    public function get onKeyValuePairAdded():Signal2
    {
        return _signal;
    }
}
}
