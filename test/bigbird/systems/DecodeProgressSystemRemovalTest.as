package bigbird.systems
{
import bigbird.components.BigBirdProgress;
import bigbird.components.Chunker;
import bigbird.components.WordData;
import bigbird.core.ProgressSignal;

import net.richardlord.ash.core.Entity;
import net.richardlord.ash.core.Game;

import org.hamcrest.assertThat;
import org.hamcrest.object.notNullValue;
import org.hamcrest.object.nullValue;

import supporting.values.DOCUMENT_SINGLE_KEY_VALUE_PAIR_XML;

public class DecodeProgressSystemRemovalTest
{
    private var _game:Game;
    private var _progress:BigBirdProgress;
    private var _progressSignal:ProgressSignal;
    private var _classUnderTest:DecodeProgressSystem;


    [Before]
    public function before():void
    {

        _game = new Game();

        _progressSignal = new ProgressSignal();
        _progress = new BigBirdProgress( _progressSignal );
        _classUnderTest = new DecodeProgressSystem( _progress );
        _game.addSystem( _classUnderTest, 0 );
    }

    [After]
    public function after():void
    {
        _game = null;
        _progress = null;
        _progressSignal = null;

        _classUnderTest = null;
    }


    [Test]
    public function removes_self_after_3_updates():void
    {

        update();
        update();
        update();

        assertThat( _game.getSystem( DecodeProgressSystem ), nullValue() );
    }

    [Test]
    public function does_not_remove_self_until_after_3_updates():void
    {

        update();
        update();

        assertThat( _game.getSystem( DecodeProgressSystem ), notNullValue() );
    }

    [Test]
    public function does_not_remove_self_if_new_node_added():void
    {

        update();
        update();
        createEntity( DOCUMENT_SINGLE_KEY_VALUE_PAIR_XML, 1 );
        update();

        assertThat( _game.getSystem( DecodeProgressSystem ), notNullValue() );
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
        entity.add( wordData );

        _game.addEntity( entity );
        return entity;
    }


    private function update():void
    {
        _game.update( 0 );
    }


}
}
