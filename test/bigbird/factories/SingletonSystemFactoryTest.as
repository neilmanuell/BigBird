package bigbird.factories
{
import bigbird.systems.DecodeSystem;
import bigbird.systems.DispatchDecodedSystem;
import bigbird.systems.SystemName;

import org.hamcrest.assertThat;
import org.hamcrest.object.equalTo;
import org.hamcrest.object.instanceOf;
import org.hamcrest.object.nullValue;
import org.hamcrest.object.strictlyEqualTo;

import supporting.MockGame;
import supporting.utils.configureTestSingletonSystemFactory;

public class SingletonSystemFactoryTest
{

    private var _game:MockGame;
    private var _classUnderTest:SingletonSystemFactory;


    [Before]
    public function before():void
    {
        _game = new MockGame();
        _classUnderTest = configureTestSingletonSystemFactory( _game )
    }

    [After]
    public function after():void
    {
        _game = null;
        _classUnderTest = null;
    }

    [Test]
    public function addDecodeSystem_does_not_add_System_immediately():void
    {
        _classUnderTest.addSystem( SystemName.DECODE );

        assertThat( _game.getSystem( DecodeSystem ), nullValue() );
    }

    [Test]
    public function addDecodeSystem_adds_System_onUpdateComplete():void
    {
        _classUnderTest.addSystem( SystemName.DECODE );
        dispatchUpdateComplete();

        assertThat( _game.getSystem( DecodeSystem ), instanceOf( DecodeSystem ) );
    }

    [Test]
    public function addDecodeSystem_removes_onUpdateCompleteHandler():void
    {
        _classUnderTest.addSystem( SystemName.DECODE );
        dispatchUpdateComplete();
        _game.removeAllSystems();
        dispatchUpdateComplete();

        assertThat( _game.getSystem( DecodeSystem ), nullValue() );
    }

    [Test]
    public function addDecodeSystem_adds_singleton_instance():void
    {
        _classUnderTest.addSystem( SystemName.DECODE );
        dispatchUpdateComplete();
        _classUnderTest.removeAllSystems();
        dispatchUpdateComplete();
        _classUnderTest.addSystem( SystemName.DECODE );
        dispatchUpdateComplete();

        assertThat( _game.systemsReceived[0], strictlyEqualTo( _game.systemsReceived[1] ) );
    }

    [Test]
    public function addDecodeSystem_will_not_add_if_already_added():void
    {
        _classUnderTest.addSystem( SystemName.DECODE );
        dispatchUpdateComplete();
        _classUnderTest.addSystem( SystemName.DECODE );
        dispatchUpdateComplete();

        assertThat( _game.systemsReceived.length, equalTo( 1 ) );
    }

    [Test]
    public function removeDecodeSystem_does_not_remove_System_immediately():void
    {
        _classUnderTest.addSystem( SystemName.DECODE );
        dispatchUpdateComplete();
        _classUnderTest.removeSystem( SystemName.DECODE );

        assertThat( _game.getSystem( DecodeSystem ), instanceOf( DecodeSystem ) );
    }

    [Test]
    public function removeDecodeSystem_removes_System_onUpdateComplete():void
    {
        _classUnderTest.addSystem( SystemName.DECODE );
        _classUnderTest.removeSystem( SystemName.DECODE );
        dispatchUpdateComplete();

        assertThat( _game.getSystem( DecodeSystem ), nullValue() );
    }

    [Test]
    public function addDecodeSystem_registers_one_listener_per_system():void
    {
        _classUnderTest.addSystem( SystemName.DECODE );
        _classUnderTest.addSystem( SystemName.DECODE );
        dispatchUpdateComplete();

        assertThat( _game.systemsReceived.length, equalTo( 1 ) );
    }


    [Test]
    public function removeDecodeSystem_removes_onUpdateComplete_handler():void
    {
        _classUnderTest.addSystem( SystemName.DECODE );
        _classUnderTest.removeSystem( SystemName.DECODE );
        dispatchUpdateComplete();
        _classUnderTest.addSystem( SystemName.DECODE );
        dispatchUpdateComplete();

        assertThat( _game.getSystem( DecodeSystem ), instanceOf( DecodeSystem ) );
    }

    [Test]
    public function removeAllSystems_removes_all_systems_from_Game():void
    {
        _classUnderTest.addSystem( SystemName.DECODE );
        _classUnderTest.addSystem( SystemName.DISPATCH_DECODED );
        dispatchUpdateComplete();
        _classUnderTest.removeAllSystems();
        dispatchUpdateComplete();

        assertThat( "check for DecodeSystem", _game.getSystem( DecodeSystem ), nullValue() );
        assertThat( "check for DispatchDecodedSystem", _game.getSystem( DispatchDecodedSystem ), nullValue() );
    }

    private function dispatchUpdateComplete():void
    {
        _game.updateComplete.dispatch();
    }

}
}
