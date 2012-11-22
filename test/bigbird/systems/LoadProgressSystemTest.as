package bigbird.systems
{
import bigbird.components.BigBirdProgress;
import bigbird.components.io.DataLoader;
import bigbird.components.io.Loader;
import bigbird.core.ProgressSignal;
import bigbird.core.vos.ProgressVO;

import net.richardlord.ash.core.Entity;
import net.richardlord.ash.core.Game;

import org.hamcrest.assertThat;
import org.hamcrest.object.equalTo;
import org.hamcrest.object.instanceOf;
import org.hamcrest.object.notNullValue;
import org.hamcrest.object.nullValue;

import supporting.io.ConfigurableDataLoader;
import supporting.values.URL_WELL_FORMED_DOCUMENT_XML;

public class LoadProgressSystemTest
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
    public function totalWork_totalled():void
    {
        createEntity( 1, 10, false );
        createEntity( 5, 20, false );
        createEntity( 12, 30, false );
        update();
        assertThat( _progress.totalWork, equalTo( 60 ) );
    }

    [Test]
    public function workDone_totalled():void
    {
        createEntity( 1, 10, false );
        createEntity( 5, 20, false );
        createEntity( 12, 30, false );
        update();
        assertThat( _progress.workDone, equalTo( 18 ) );
    }

    [Test]
    public function totalWork_reset_before_update():void
    {
        createEntity( 1, 10, false );
        createEntity( 5, 20, false );
        createEntity( 12, 30, false );
        update();

        flushEntities();

        createEntity( 2, 10, false );
        createEntity( 10, 20, false );
        createEntity( 24, 30, false );
        update();

        assertThat( _progress.totalWork, equalTo( 60 ) );
    }

    [Test]
    public function workDone_reset_before_update():void
    {
        createEntity( 1, 10, false );
        createEntity( 5, 20, false );
        createEntity( 12, 30, false );
        update();

        flushEntities();

        createEntity( 2, 10, false );
        createEntity( 10, 20, false );
        createEntity( 24, 30, false );
        update();

        assertThat( _progress.workDone, equalTo( 36 ) );
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

    [Test]
    public function progress_dispatched_on_update():void
    {
        var vo:ProgressVO;

        const onProgress:Function = function ( progress:ProgressVO ):void
        {
            vo = progress
        };
        _progressSignal.addOnce( onProgress );

        createEntity( 1, 10, false );
        createEntity( 5, 20, false );
        createEntity( 12, 30, false );
        update();


        assertThat( vo, instanceOf( ProgressVO ) );
    }

    [Test]
    public function workDone_dispatched():void
    {
        var vo:ProgressVO;

        const onProgress:Function = function ( progress:ProgressVO ):void
        {
            vo = progress
        };
        _progressSignal.addOnce( onProgress );

        createEntity( 1, 10, false );
        createEntity( 5, 20, false );
        createEntity( 12, 30, false );
        update();


        assertThat( vo.workDone, 18 );
    }

    [Test]
    public function totalWork_dispatched():void
    {
        var vo:ProgressVO;

        const onProgress:Function = function ( progress:ProgressVO ):void
        {
            vo = progress
        };
        _progressSignal.addOnce( onProgress );

        createEntity( 1, 10, false );
        createEntity( 5, 20, false );
        createEntity( 12, 30, false );
        update();


        assertThat( vo.totalWork, 60 );
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

    private function flushEntities():void
    {
        _game.removeAllEntities();
    }

    private function update():void
    {
        _game.update( 0 );
    }


}
}
