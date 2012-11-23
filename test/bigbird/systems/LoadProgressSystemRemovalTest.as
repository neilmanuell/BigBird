package bigbird.systems
{
import bigbird.components.BigBirdProgress;
import bigbird.components.io.DataLoader;
import bigbird.components.io.Loader;
import bigbird.core.ProgressSignal;

import net.richardlord.ash.core.Entity;
import net.richardlord.ash.core.Game;

import org.hamcrest.assertThat;
import org.hamcrest.object.notNullValue;
import org.hamcrest.object.nullValue;

import supporting.io.ConfigurableDataLoader;
import supporting.values.URL_WELL_FORMED_DOCUMENT_XML;

public class LoadProgressSystemRemovalTest
{
    private var _game:Game;
    private var _progress:BigBirdProgress;
    private var _progressSignal:ProgressSignal;
    private var _classUnderTest:LoadProgressSystem;

    [Before]
    public function before():void
    {

        _game = new Game();

        _progressSignal = new ProgressSignal();
        _progress = new BigBirdProgress( _progressSignal );
        _classUnderTest = new LoadProgressSystem( _progress );
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
    public function does_not_remove_self_before_3_inactive_updates():void
    {
        createEntity( 1, 10, true );
        createEntity( 5, 20, true );
        createEntity( 12, 30, true );
        update();
        update();

        assertThat( _game.getSystem( LoadProgressSystem ), notNullValue() );
    }

    [Test]
    public function removes_self_after_3_inactive_updates():void
    {
        createEntity( 1, 10, true );
        createEntity( 5, 20, true );
        createEntity( 12, 30, true );
        update();
        update();
        update();

        assertThat( _game.getSystem( LoadProgressSystem ), nullValue() );
    }

    [Test]
    public function does_not_removes_self_if_new_value_added():void
    {
        createEntity( 1, 10, true );
        createEntity( 5, 20, true );
        createEntity( 12, 30, true );
        update();
        update();
        createEntity( 1, 10, false );
        update();

        assertThat( _game.getSystem( LoadProgressSystem ), notNullValue() );
    }


    private function createEntity( workDone:int, totalWork:int, isComplete:Boolean ):Entity
    {
        const factory:Function = function ():DataLoader
        {
            return new ConfigurableDataLoader( workDone, totalWork, isComplete );
        };

        const entity:Entity = new Entity();
        entity.add( new Loader( URL_WELL_FORMED_DOCUMENT_XML, factory ) );

        _game.addEntity( entity );

        return entity;
    }


    private function update():void
    {
        _game.update( 0 );
    }


}
}
