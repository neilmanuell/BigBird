package bigbird.factories
{


import bigbird.components.KeyCell;
import bigbird.components.KeyValuePairInfo;
import bigbird.components.ValueCell;

import flash.net.URLRequest;
import flash.utils.Dictionary;

import net.richardlord.ash.core.Entity;
import net.richardlord.ash.core.Game;

public class KeyValuePairFactory
{
    private const _indices:Dictionary = new Dictionary();
    private var _game:Game;

    public function KeyValuePairFactory( game:Game )
    {
        _game = game;
    }

    public function createKeyValuePair( request:URLRequest, keyCellData:XML, valueCellData:XML ):Entity
    {
        if ( _indices[request] == null ) _indices[request] = 0;
        const entity:Entity = new Entity();
        entity.add( new KeyValuePairInfo( _indices[request]++, request ) )
        entity.add( new KeyCell( keyCellData, keyCellData.namespace( "w" ) ) );
        entity.add( new ValueCell( valueCellData, valueCellData.namespace( "w" ) ) );

        _game.addEntity( entity );

        return entity;
    }
}
}
