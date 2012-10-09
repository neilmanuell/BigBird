package bigbird.factories
{
import bigbird.components.*;

import flash.utils.Dictionary;

import net.richardlord.ash.core.Entity;
import net.richardlord.ash.core.Game;

public class KeyValuePairFactory
{

    private var game:Game;
    private const _indices:Dictionary = new Dictionary();

    public function KeyValuePairFactory( game:Game )
    {
        this.game = game;
    }

    public function createKeyValuePair( documentName:String, keyCellData:XML, valueCellData:XML ):Entity
    {
        const entity:Entity = new Entity();
        if ( _indices[documentName] == null ) _indices[documentName] = 0;
        entity.add( new KeyValuePairUID( _indices[documentName]++, documentName ) );
        entity.add( new KeyCell( keyCellData, keyCellData.namespace( "w" ) ) );
        entity.add( new ValueCell( valueCellData, valueCellData.namespace( "w" ) ) );
        game.addEntity( entity );
        return entity;
    }
}
}
