package bigbird.core
{
import bigbird.components.KeyCell;
import bigbird.components.ValueCell;
import bigbird.core.vos.KeyValuePairVO;

import flash.net.URLRequest;

import net.richardlord.signals.Signal3;

public class KeyValuePairSignal extends Signal3
{
    public function KeyValuePairSignal()
    {
        super( URLRequest, int, KeyValuePairVO );
    }

    public function dispatchKeyValuePair( request:URLRequest, index:int, key:KeyCell, value:ValueCell ):void
    {
        dispatch( request, index, new KeyValuePairVO( key, value ) );
    }
}
}
