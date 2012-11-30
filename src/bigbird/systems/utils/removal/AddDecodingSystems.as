package bigbird.systems.utils.removal
{
import bigbird.systems.SystemPriority;
import bigbird.systems.decode.DecodeCompleteSystem;
import bigbird.systems.decode.DecodeProgressSystem;
import bigbird.systems.decode.DecodeSystem;
import bigbird.systems.decode.DispatchDecodedSystem;
import bigbird.systems.progress.DispatchProgressSystem;

public class AddDecodingSystems extends SystemAddition
{
    override public function add():void
    {
        addSystem( DecodeSystem, SystemPriority.PROCESS );
        addSystem( DecodeProgressSystem, SystemPriority.PROGRESS );
        addSystem( DecodeCompleteSystem, SystemPriority.END );
        addSystem( DispatchDecodedSystem, SystemPriority.END );
        addSystem( DispatchProgressSystem, SystemPriority.END );
    }
}
}
