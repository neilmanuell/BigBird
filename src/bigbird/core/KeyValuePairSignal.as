package bigbird.core
{
import bigbird.components.KeyCell;
import bigbird.components.ValueCell;
import bigbird.core.vos.KeyValuePairVO;

import net.richardlord.signals.Signal2;

public class KeyValuePairSignal extends Signal2
{
    public function KeyValuePairSignal()
    {
        super( String, KeyValuePairVO );
    }

    public function dispatchKeyValuePair( documentName:String, key:KeyCell, value:ValueCell ):void
    {
        dispatch( documentName, new KeyValuePairVO( key, value ) );
    }
}
}
