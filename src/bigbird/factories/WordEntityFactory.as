package bigbird.factories
{

import bigbird.components.EntityStateNames;
import bigbird.components.WordData;
import bigbird.components.io.Loader;

import flash.net.URLRequest;

import net.richardlord.ash.core.Entity;
import net.richardlord.ash.core.Game;
import net.richardlord.ash.fsm.EntityStateMachine;

public class WordEntityFactory
{
    public function WordEntityFactory( game:Game )
    {
        _game = game;
    }

    private var _game:Game;

    public function createWordFileEntity( request:URLRequest, loaderFactory:Function = null ):Entity
    {
        const entity:Entity = new Entity();
        const fsm:EntityStateMachine = new EntityStateMachine( entity );

        fsm.createState( EntityStateNames.LOADING )
                .add( WordData )
                .add( Loader ).withInstance( new Loader( request, loaderFactory ) );

        fsm.createState( EntityStateNames.DECODING )
                .add( WordData );

        fsm.createState( EntityStateNames.COMPLETE )
                .add( URLRequest ).withInstance( request )
                .add( WordData );

        entity.add( fsm );

        _game.addEntity( entity );

        fsm.changeState( EntityStateNames.LOADING );

        return entity;
    }


}
}
