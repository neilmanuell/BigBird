package bigbird.systems
{
import bigbird.asserts.assertExpectedComponents;
import bigbird.components.Chunker;
import bigbird.components.WordData;
import bigbird.components.io.DataLoader;
import bigbird.components.io.Loader;
import bigbird.core.WordDataSignal;
import bigbird.core.vos.DataLoaderVO;
import bigbird.factories.WordEntityFactory;

import flash.net.URLRequest;

import net.richardlord.ash.core.Entity;
import net.richardlord.ash.core.Game;
import net.richardlord.ash.fsm.EntityStateMachine;

import org.hamcrest.assertThat;
import org.hamcrest.number.greaterThan;
import org.hamcrest.object.equalTo;
import org.hamcrest.object.notNullValue;
import org.hamcrest.object.nullValue;

import supporting.io.GrumpyDataLoader;
import supporting.io.HappyDataLoader;
import supporting.values.URL_WELL_FORMED_DOCUMENT_XML;

public class LoadCompleteSystemTest
{

    private const defaultComponents:Array = [EntityStateMachine];
    private var _game:Game;
    private var _classUnderTest:LoadCompleteSystem;
    private var _factory:WordEntityFactory;
    private var _onLoaded:WordDataSignal;
    private var _recieved:Array = [];


    [Before]
    public function before():void
    {
        _game = new Game();
        _onLoaded = new WordDataSignal();
        _classUnderTest = new LoadCompleteSystem( _onLoaded );
        _game.addSystem( _classUnderTest, 0 );
        _factory = new WordEntityFactory( _game );
    }

    [After]
    public function after():void
    {
        _game = null;
        _factory = null;
        _classUnderTest = null;
        _recieved = null;
    }

    [Test]
    public function update_Entity_state_remains_LOADING_if_not_complete():void
    {
        const expectedComponents:Array = defaultComponents.concat( [  WordData, Loader] );
        const entity:Entity = createEntity( false );
        update();
        assertExpectedComponents( expectedComponents, entity );
    }

    [Test]
    public function update_sets_Entity_state_to_DECODING_on_complete():void
    {
        const expectedComponents:Array = defaultComponents.concat( [  WordData, Chunker] );
        const entity:Entity = createEntity( true );
        update();
        assertExpectedComponents( expectedComponents, entity );
    }

    [Test]
    public function update_does_not_apply_data_until_complete():void
    {
        const entity:Entity = createEntity( false );
        const wordData:WordData = entity.get( WordData );
        update();
        assertThat( wordData.length, equalTo( 0 ) );
    }

    [Test]
    public function update_applies_data_on_complete():void
    {
        const entity:Entity = createEntity( true );
        const wordData:WordData = entity.get( WordData );
        update();
        assertThat( wordData.length, greaterThan( 0 ) );
    }


    [Test]
    public function removes_self_after_3_inactive_updates():void
    {
        createEntity( true );
        update();
        update();
        update();

        assertThat( _game.getSystem( LoadCompleteSystem ), nullValue() );
    }

    [Test]
    public function does_not_removes_self_if_new_value_added():void
    {
        createEntity( true );
        update();
        update();
        createEntity( false );
        update();

        assertThat( _game.getSystem( LoadCompleteSystem ), notNullValue() );
    }


    private function update():void
    {
        _game.update( 0 );
    }

    private function createEntity( isComplete:Boolean ):Entity
    {
        const dataLoaderFactory:Function = function ( request:URLRequest ):DataLoader
        {
            if ( isComplete )
                return new HappyDataLoader( request );
            else
                return new GrumpyDataLoader( request );
        };

        return _factory.createWordFileEntity( URL_WELL_FORMED_DOCUMENT_XML, dataLoaderFactory );
    }

    private function onLoaded( wordData:DataLoaderVO ):void
    {
        _recieved.push( wordData )
    }


}
}
