package supporting.systems
{
import bigbird.systems.utils.removal.SelfRemovingSystem;

import net.richardlord.ash.core.System;

public class FlaggedSelfRemovingSystem extends System implements SelfRemovingSystem
{
    public var removalCancelled:Boolean = false;


    public function get flaggedForRemove():Boolean
    {
        return true;
    }

    public function cancelRemoval():void
    {
        removalCancelled = true;
    }
}
}
