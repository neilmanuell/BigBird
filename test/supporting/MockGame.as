package supporting
{
import net.richardlord.ash.core.Entity;
import net.richardlord.ash.core.Game;
import net.richardlord.ash.core.System;

public class MockGame extends Game
{
    public const entitiesReceived:Array = [];
    public const systemsReceived:Array = [];

    public override function addEntity( entity:Entity ):void
    {
        super.addEntity( entity );
        entitiesReceived.push( entity );
    }

    public override function addSystem( system:System, priority:int ):void
    {
        super.addSystem( system, priority );
        systemsReceived.push( system );
    }
}
}
