package bigbird.systems.load
{
import bigbird.asserts.assertExpectedComponents;
import bigbird.components.WordData;
import bigbird.components.io.DataLoader;
import bigbird.components.io.Loader;
import bigbird.controller.EntityStateNames;
import bigbird.controller.StartWordFileDecode;
import bigbird.core.WordDataSignal;
import bigbird.factories.WordEntityFactory;

import flash.events.Event;
import flash.net.URLRequest;

import mockolate.nice;
import mockolate.prepare;
import mockolate.received;

import net.richardlord.ash.core.Entity;
import net.richardlord.ash.core.Game;
import net.richardlord.ash.fsm.EntityStateMachine;

import org.flexunit.async.Async;
import org.hamcrest.assertThat;
import org.hamcrest.object.hasPropertyWithValue;
import org.hamcrest.object.notNullValue;
import org.hamcrest.object.nullValue;
import org.hamcrest.object.strictlyEqualTo;

import supporting.io.GrumpyDataLoader;
import supporting.io.HappyDataLoader;
import supporting.utils.changeState;
import supporting.values.URL_WELL_FORMED_DOCUMENT_XML;

public class LoadCompleteSystemTest
{

    private const defaultComponents:Array = [EntityStateMachine];
    private var _game:Game;
    private var _classUnderTest:LoadCompleteSystem;
    private var _factory:WordEntityFactory;
    private var _onLoaded:WordDataSignal;
    private var _recieved:Array = [];
    private var _decoder:StartWordFileDecode;


    [Before(order=1, async, timeout=5000)]
    public function prepareMockolates():void
    {
        Async.proceedOnEvent( this,
                prepare( StartWordFileDecode ),
                Event.COMPLETE );
    }

    [Before(order=2)]
    public function before():void
    {
        _decoder = nice( StartWordFileDecode )
        _game = new Game();
        _onLoaded = new WordDataSignal();
        _classUnderTest = new LoadCompleteSystem( _onLoaded, _decoder );
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

        const entity:Entity = createEntity( true );
        update();
        assertThat( _decoder, received().method( "decode" ).arg( hasPropertyWithValue( "entity", strictlyEqualTo( entity ) ) ).once() )
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

        const entity:Entity = _factory.createWordFileEntity( URL_WELL_FORMED_DOCUMENT_XML, dataLoaderFactory );
        changeState( EntityStateNames.LOADING, entity );
        return entity;
    }

}
}
