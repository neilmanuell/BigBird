package bigbird.systems.utils.removal
{
import bigbird.systems.SystemPriority;
import bigbird.systems.load.LoadCompleteSystem;
import bigbird.systems.load.LoadProgressSystem;
import bigbird.systems.progress.DispatchProgressSystem;

public class AddLoadingSystems extends SystemAddition
{
    override public function add():void
    {
        addSystem( LoadProgressSystem, SystemPriority.PROGRESS );
        addSystem( LoadCompleteSystem, SystemPriority.END );
        addSystem( DispatchProgressSystem, SystemPriority.END );
    }
}
}
