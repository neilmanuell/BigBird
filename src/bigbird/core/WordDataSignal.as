package bigbird.core
{
import bigbird.components.io.DataLoader;
import bigbird.core.vos.DataLoaderVO;

import net.richardlord.signals.Signal1;

public class WordDataSignal extends Signal1
{
    public function WordDataSignal()
    {
        super( DataLoaderVO );
    }

    public function dispatchWordData( data:DataLoader ):void
    {
        dispatch( new DataLoaderVO( data ) );
    }
}
}
