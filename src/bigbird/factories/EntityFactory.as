package bigbird.factories
{
import bigbird.components.*;

import flash.net.URLRequest;

import net.richardlord.ash.core.Entity;
import net.richardlord.ash.core.Game;

public class EntityFactory
{
    private var _game:Game;

    public function EntityFactory( game:Game )
    {
        _game = game;
    }

    public function createDocument( request:URLRequest ):Entity
    {
        const entity:Entity = new Entity();
        const access:DocumentState = new DocumentState( entity );
        access.addURL( request );
        entity.add( new Progress( 0 ) );
        entity.add( access );
        _game.addEntity( entity );
        return entity;
    }

    public function createWordDocument( rawData:XML ):Entity
    {
        const entity:Entity = new Entity();
        const document:RawWordDocument = new RawWordDocument( rawData )
        const progress:Progress = new Progress( document.length );
        entity.add( new URLRequest( "document.xml" ) );
        entity.add( document );
        entity.add( progress );
        _game.addEntity( entity );
        return entity;
    }


}
}
