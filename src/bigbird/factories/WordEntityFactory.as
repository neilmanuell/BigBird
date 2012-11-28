package bigbird.factories
{

import bigbird.components.Chunker;
import bigbird.components.WordData;
import bigbird.components.io.Loader;
import bigbird.controller.EntityStateNames;
import bigbird.systems.utils.removal.AddLoadingSystems;

import flash.net.URLRequest;

import net.richardlord.ash.core.Entity;
import net.richardlord.ash.core.Game;
import net.richardlord.ash.fsm.EntityStateMachine;

public class WordEntityFactory
{
    [Inject]
    public var systemAdd:AddLoadingSystems;

    public function WordEntityFactory( game:Game )
    {
        _game = game;
    }

    private var _game:Game;

    public function createWordFileEntity( request:URLRequest, loaderFactory:Function = null ):Entity
    {
        const entity:Entity = new Entity();
        var fsm:EntityStateMachine = createFSM( entity, request, loaderFactory );
        _game.addEntity( entity );
        return entity;
    }

    private function createFSM( entity:Entity, request:URLRequest, loaderFactory:Function ):EntityStateMachine
    {
        const fsm:EntityStateMachine = new EntityStateMachine( entity );

        fsm.createState( EntityStateNames.LOADING )
                .add( WordData )
                .add( Loader ).withInstance( new Loader( request, loaderFactory ) );

        fsm.createState( EntityStateNames.DECODING )
                .add( URLRequest ).withInstance( request )
                .add( WordData )
                .add( Chunker );

        entity.add( fsm );
        return fsm;
    }


}
}
