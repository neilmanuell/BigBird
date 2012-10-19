package bigbird.components
{
import bigbird.core.ProgressSignal;

public class BigBirdProgress
{
    public var decodingWorkDone:int;
    public var totalDecodingWork:int;

    public var loadingWorkDone:int;
    public var totalLoadingWork:int;

    private var _onProgress:ProgressSignal;

    public function BigBirdProgress( onProgress:ProgressSignal )
    {
        _onProgress = onProgress;
    }

    public function dispatch():void
    {
        _onProgress.dispatchProgress( this );
    }

    public function  get allWorkDone():Number
    {
        return  totalDecodingWork + totalLoadingWork;
    }

    public function  get totalWork():Number
    {
        return  decodingWorkDone + loadingWorkDone;
    }
}
}
