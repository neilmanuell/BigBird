package bigbird.factories
{


import bigbird.components.EntityStateNames;
import bigbird.components.KeyCell;
import bigbird.components.KeyValuePairIndex;
import bigbird.components.ValueCell;

import flash.net.URLRequest;
import flash.utils.Dictionary;

import net.richardlord.ash.core.Entity;
import net.richardlord.ash.core.Game;
import net.richardlord.ash.fsm.EntityStateMachine;

public class KeyValuePairFactory
{
    private var game:Game;
    private const _indices:Dictionary = new Dictionary();

    public function KeyValuePairFactory( game:Game )
    {
        this.game = game;
    }

    public function createKeyValuePair( request:URLRequest, keyCellData:XML, valueCellData:XML ):Entity
    {
        const entity:Entity = new Entity();
        const fsm:EntityStateMachine = new EntityStateMachine( entity );
        const index:KeyValuePairIndex = new KeyValuePairIndex( _indices[request]++ );
        const keyCell:KeyCell = new KeyCell( keyCellData, keyCellData.namespace( "w" ) );
        const valueCell:ValueCell = new ValueCell( valueCellData, valueCellData.namespace( "w" ) );

        if ( _indices[request] == null ) _indices[request] = 0;


        fsm.createState( EntityStateNames.PRE_DISPATCH )
                .add( KeyValuePairIndex ).withInstance( index )
                .add( URLRequest ).withInstance( request )
                .add( KeyCell ).withInstance( keyCell )
                .add( ValueCell ).withInstance( valueCell );

        fsm.createState( EntityStateNames.POST_DISPATCH )
                .add( KeyValuePairIndex ).withInstance( index )
                .add( KeyCell ).withInstance( keyCell )
                .add( ValueCell ).withInstance( valueCell );


        entity.add( fsm );

        game.addEntity( entity );

        return entity;
    }
}
}
