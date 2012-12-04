package bigbird.api.signals
{
import flash.net.URLRequest;

import net.richardlord.signals.Signal1;

public class LoadWordScript extends Signal1
{

    public function LoadWordScript()
    {
        super( URLRequest );
    }

    public function load( request:URLRequest ):void
    {
        dispatch( request );
    }
}
}
