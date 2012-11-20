package bigbird.core.vos
{
import bigbird.components.BigBirdProgress;

public class ProgressVO
{
    private var _progress:BigBirdProgress;

    public function ProgressVO( progress:BigBirdProgress )
    {
        _progress = progress;
    }

    public function get totalWork():int
    {
        return _progress.totalWork
    }

    public function get workDone():int
    {
        return _progress.workDone
    }


}
}
