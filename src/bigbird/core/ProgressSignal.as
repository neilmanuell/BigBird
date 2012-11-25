package bigbird.core
{
import bigbird.components.BigBirdProgress;
import bigbird.core.vos.ProgressVO;

import net.richardlord.signals.Signal1;

public class ProgressSignal extends Signal1
{
    public function ProgressSignal()
    {
        super( ProgressVO );
    }

    public function dispatchProgress( progress:BigBirdProgress ):void
    {
        dispatch( new ProgressVO( progress ) );
    }
}
}
