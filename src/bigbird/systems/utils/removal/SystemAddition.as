package bigbird.systems.utils.removal
{
import net.richardlord.ash.core.Game;

import org.swiftsuspenders.Injector;

public class SystemAddition
{
    [Inject]
    public var game:Game;

    [Inject]
    public var injector:Injector;

    public function add():void
    {

    }


    internal final function addSystem( systemClass:Class, priority:int ):void
    {
        const system:SelfRemovingSystem = SelfRemovingSystem( game.getSystem( systemClass ) );

        if ( system == null )
        {
            game.addSystem( injector.getInstance( systemClass ), priority )
        }

        else if ( system.flaggedForRemove )
        {
            system.cancelRemoval();
        }
    }
}
}
