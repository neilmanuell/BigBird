package bigbird.systems.utils
{
import bigbird.systems.DispatchProgressSystem;
import bigbird.systems.LoadCompleteSystem;
import bigbird.systems.LoadProgressSystem;
import bigbird.systems.SystemPriority;

public class AddAllLoadingSystems extends SystemAddition
{
    override public function add():void
    {
        addSystem( LoadProgressSystem, SystemPriority.PROGRESS );
        addSystem( LoadCompleteSystem, SystemPriority.END );
        addSystem( DispatchProgressSystem, SystemPriority.END );
    }
}
}
