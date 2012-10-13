package bigbird.factories
{
import bigbird.components.*;

import net.richardlord.ash.core.Entity;
import net.richardlord.ash.core.Game;

public class EntityFactory
{
    private var _game:Game;

    public function EntityFactory( game:Game )
    {
        _game = game;
    }

    public function createDocument( name:String, rawData:XML ):Entity
    {
        const entity:Entity = new Entity();
        const document:RawWordDocument = new RawWordDocument( name, rawData )
        const progress:Progress = new Progress( document.length );
        entity.add( document );
        entity.add( progress );
        _game.addEntity( entity );
        return entity;
    }


}
}
