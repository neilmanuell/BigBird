package supporting
{
import net.richardlord.ash.core.Entity;
import net.richardlord.ash.core.Game;

public class MockGame extends Game
{
    public const entitiesReceived:Array = [];

    public override function addEntity( entity:Entity ):void
    {
        entitiesReceived.push( entity );
    }
}
}
