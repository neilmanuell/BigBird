package bigbird.factories
{
import bigbird.asserts.assertExpectedComponents;
import bigbird.components.EntityStateNames;
import bigbird.components.WordData;
import bigbird.components.io.Loader;

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
import org.hamcrest.object.instanceOf;
import org.hamcrest.object.strictlyEqualTo;

import supporting.values.DOCUMENT_URL;

public class WordEntityFSMTest
{
    private const defaultComponents:Array = [EntityStateMachine];
    private var _game:Game;
    private var _classUnderTest:Entity;
    private var _fsm:EntityStateMachine;

    [Before(order=1, async, timeout=5000)]
    public function prepareMockolates():void
    {
        Async.proceedOnEvent( this,
                prepare( Game ),
                Event.COMPLETE );
    }

    public function createEntity( request:URLRequest = null ):void
    {
        const currentRequest:URLRequest = request || DOCUMENT_URL
        _game = nice( Game );
        _classUnderTest = new WordEntityFactory( _game ).createWordFileEntity( currentRequest );
        _fsm = _classUnderTest.get( EntityStateMachine );
    }

    [After]
    public function after():void
    {
        _game = null;
        _classUnderTest = null;
        _fsm = null;
    }

    [Test]
    public function createWordFileEntity_returns_instanceOf_Entity():void
    {
        createEntity();
        assertThat( _classUnderTest, instanceOf( Entity ) );
    }

    [Test]
    public function createWordFileEntity_adds_Entity_to_Game():void
    {
        createEntity();
        assertThat( _game, received().method( "addEntity" ).arg( strictlyEqualTo( _classUnderTest ) ).once() )
    }

    [Test]
    public function createWordFileEntity_returns_Entity_containing_instanceOf_EntityStateMachine():void
    {
        createEntity();
        assertThat( _classUnderTest.get( EntityStateMachine ), instanceOf( EntityStateMachine ) );
    }

    [Test]
    public function loading_state_is_default():void
    {
        createEntity();
        const expectedComponents:Array = defaultComponents.concat( [ WordData, Loader] );
        assertExpectedComponents( expectedComponents, _classUnderTest );
    }

    [Test]
    public function loading_state():void
    {
        createEntity();
        const expectedComponents:Array = defaultComponents.concat( [  WordData, Loader] );
        changeState( EntityStateNames.LOADING );
        assertExpectedComponents( expectedComponents, _classUnderTest );
    }

    [Test]
    public function decoding_state():void
    {
        createEntity();
        const expectedComponents:Array = defaultComponents.concat( [  WordData] );
        changeState( EntityStateNames.DECODING );
        assertExpectedComponents( expectedComponents, _classUnderTest );
    }

    [Test]
    public function completed_state():void
    {
        createEntity();
        const expectedComponents:Array = defaultComponents.concat( [URLRequest, WordData] );
        changeState( EntityStateNames.COMPLETE );
        assertExpectedComponents( expectedComponents, _classUnderTest );
    }

    private function changeState( name:String ):void
    {
        _fsm.changeState( name );
    }


}
}
