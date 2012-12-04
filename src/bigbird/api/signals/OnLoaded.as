package bigbird.api.signals
{
import bigbird.components.io.DataLoader;
import bigbird.api.vos.WordScriptVO;

import net.richardlord.signals.Signal1;

public class OnLoaded extends Signal1
{
    public function OnLoaded()
    {
        super( WordScriptVO );
    }

    public function dispatchWordData( data:DataLoader ):void
    {
        dispatch( new WordScriptVO( data ) );
    }
}
}
