package bigbird.systems.decode
{
import bigbird.components.Chunker;
import bigbird.components.WordData;
import bigbird.nodes.DecodeNode;

import net.richardlord.ash.core.Entity;
import net.richardlord.ash.core.Game;

import org.hamcrest.assertThat;
import org.hamcrest.object.equalTo;

import supporting.values.DOCUMENT_SINGLE_KEY_VALUE_PAIR_XML;
import supporting.values.URL_WELL_FORMED_DOCUMENT_DOCX;

public class DecodeCompleteSystemTest
{
    private var _classUnderTest:DecodeCompleteSystem;
    private var _node:DecodeNode;
    private var _game:Game;


    [Before]
    public function before():void
    {
        _classUnderTest = new DecodeCompleteSystem();
        _game = new Game();
        _game.addSystem( _classUnderTest, 0 );
    }

    [After]
    public function after():void
    {
        _classUnderTest = null;
        _game = null;

    }

    [Test]
    public function test():void
    {
        const entity:Entity = createEntity( DOCUMENT_SINGLE_KEY_VALUE_PAIR_XML, 2 );
        update();
        assertThat( _game.entities.length, equalTo( 0 ) );
    }


    [Test]
    public function test2():void
    {
        const entity:Entity = createEntity( DOCUMENT_SINGLE_KEY_VALUE_PAIR_XML, 0 );
        update();
        assertThat( _game.entities.length, equalTo( 1 ) );
    }

    private function update():void
    {
        _game.update( 0 );
    }

    private function createEntity( data:XML, position:int ):Entity
    {
        const wordData:WordData = new WordData( data );
        var count:int = 0;
        while ( count++ < position )
        {
            wordData.getNext();
        }

        const entity:Entity = new Entity();
        entity.add( new Chunker() );
        entity.add( URL_WELL_FORMED_DOCUMENT_DOCX );
        entity.add( wordData );

        _game.addEntity( entity );
        return entity;
    }


}
}
