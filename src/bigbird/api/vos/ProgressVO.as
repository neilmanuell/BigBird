package bigbird.api.vos
{
import bigbird.components.BigBirdProgress;

public class ProgressVO
{
    private var _totalWork:int;
    private var _workDone:int;

    public function ProgressVO( progress:BigBirdProgress )
    {
        _totalWork = progress.totalWork;
        _workDone = progress.workDone
    }

    public function get totalWork():int
    {
        return _totalWork
    }

    public function get workDone():int
    {
        return _workDone
    }


}
}
