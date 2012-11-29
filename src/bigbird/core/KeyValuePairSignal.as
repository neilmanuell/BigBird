package bigbird.core
{
import bigbird.core.vos.KeyValuePairVO;
import bigbird.nodes.KeyValuePairNode;

import flash.net.URLRequest;

import net.richardlord.signals.Signal3;

public class KeyValuePairSignal extends Signal3
{
    public function KeyValuePairSignal()
    {
        super( URLRequest, int, KeyValuePairVO );
    }

    public function dispatchKeyValuePair( node:KeyValuePairNode ):void
    {
        dispatch( node.info.request, node.info.index, new KeyValuePairVO( node.key, node.value ) );
    }
}
}
