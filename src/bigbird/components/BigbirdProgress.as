package bigbird.components
{
import bigbird.core.ProgressSignal;

public class BigBirdProgress
{
    public var workDone:int;
    public var totalWork:int;

    private var _onProgress:ProgressSignal;

    public function BigBirdProgress( onProgress:ProgressSignal )
    {
        _onProgress = onProgress;
    }

    public function dispatch():void
    {
        _onProgress.dispatchProgress( this );
    }


}
}
