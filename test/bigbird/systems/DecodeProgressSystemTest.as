package bigbird.systems
{
import bigbird.components.BigBirdProgress;
import bigbird.components.Chunker;
import bigbird.components.WordData;
import bigbird.core.ProgressSignal;

import net.richardlord.ash.core.Entity;
import net.richardlord.ash.core.Game;

import org.hamcrest.assertThat;
import org.hamcrest.object.equalTo;

import supporting.values.DOCUMENT_FULL_MISSING_VALUE_XML;
import supporting.values.DOCUMENT_FULL_SMALL_XML;
import supporting.values.DOCUMENT_SINGLE_KEY_VALUE_PAIR_XML;

public class DecodeProgressSystemTest
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
    public function totalWork_summation():void
    {
        createEntity( DOCUMENT_SINGLE_KEY_VALUE_PAIR_XML, 1 );
        createEntity( DOCUMENT_FULL_SMALL_XML, 4 );
        createEntity( DOCUMENT_FULL_MISSING_VALUE_XML, 8 );
        update();

        assertThat( _progress.totalWork, equalTo( 49 ) );
    }

    [Test]
    public function workDone_summation():void
    {
        createEntity( DOCUMENT_SINGLE_KEY_VALUE_PAIR_XML, 1 );
        createEntity( DOCUMENT_FULL_SMALL_XML, 4 );
        createEntity( DOCUMENT_FULL_MISSING_VALUE_XML, 8 );
        update();

        assertThat( _progress.workDone, equalTo( 13 ) );
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
