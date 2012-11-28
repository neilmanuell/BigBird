package bigbird.systems.decode
{
import net.richardlord.ash.core.Game;

import org.hamcrest.assertThat;
import org.hamcrest.object.notNullValue;
import org.hamcrest.object.nullValue;

public class DecodeCompleteSystemRemovalTest
{
    private var _game:Game;
    private var _classUnderTest:DecodeCompleteSystem;


    [Before]
    public function before():void
    {
        _game = new Game();
        _classUnderTest = new DecodeCompleteSystem();
        _game.addSystem( _classUnderTest, 0 );
    }

    [After]
    public function after():void
    {
        _game = null;
        _classUnderTest = null;
    }


    [Test]
    public function removes_self_after_3_updates():void
    {

        update();
        update();
        update();

        assertThat( _game.getSystem( DecodeCompleteSystem ), nullValue() );
    }

    [Test]
    public function does_not_remove_self_until_after_3_updates():void
    {

        update();
        update();

        assertThat( _game.getSystem( DecodeCompleteSystem ), notNullValue() );
    }

    /*  [Test]
     public function does_not_remove_self_if_new_node_added():void
     {

     update();
     update();
     createEntity( DOCUMENT_SINGLE_KEY_VALUE_PAIR_XML, 1 );
     update();

     assertThat( _game.getSystem( DecodeCompleteSystem ), notNullValue() );
     }*/


    /* private function createEntity( data:XML, position:int ):Entity
     {
     const wordData:WordData = new WordData( data );
     var count:int = 0;
     while ( count++ < position )
     {
     wordData.getNext();
     }

     const entity:Entity = new Entity();
     entity.add( new Chunker() );
     entity.add( wordData );

     entity.add(URL_WELL_FORMED_DOCUMENT_DOCX );

     _game.addEntity( entity );
     return entity;
     }*/


    private function update():void
    {
        _game.update( 0 );
    }


}
}
