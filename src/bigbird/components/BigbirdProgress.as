package bigbird.components
{
import bigbird.api.signals.OnProgress;

public class BigBirdProgress
{
    public var workDone:int;
    public var totalWork:int;

    private var _onProgress:OnProgress;

    public function BigBirdProgress( onProgress:OnProgress )
    {
        _onProgress = onProgress;
    }

    public function dispatch():void
    {
        _onProgress.dispatchProgress( this );
    }

}
}
