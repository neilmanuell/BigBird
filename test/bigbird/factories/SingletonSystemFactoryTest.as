package bigbird.factories
{
import bigbird.components.SystemFactoryConfig;
import bigbird.systems.DecodeFromRawDocument;
import bigbird.systems.DecodeSystem;
import bigbird.systems.SystemName;
import bigbird.systems.SystemPriority;

import net.richardlord.ash.core.System;

import org.hamcrest.assertThat;
import org.hamcrest.object.equalTo;
import org.hamcrest.object.instanceOf;
import org.hamcrest.object.nullValue;
import org.hamcrest.object.strictlyEqualTo;

import supporting.MockGame;
import supporting.values.DOCUMENT_NAME;

use namespace DOCUMENT_NAME;

public class SingletonSystemFactoryTest
{

    private var _game:MockGame;
    private var _classUnderTest:SingletonSystemFactory;


    [Before]
    public function before():void
    {
        _game = new MockGame();
        _classUnderTest = new SingletonSystemFactory( _game );
        const config:SystemFactoryConfig = new SystemFactoryConfig(
                SystemName.DECODE,
                DecodeSystem,
                SystemPriority.DECODE_SYSTEM,
                createDecodeSystem );

        _classUnderTest.register( config )
    }

    private function createDecodeSystem():System
    {
        return new DecodeSystem( new DecodeFromRawDocument( _game ) );
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
        _game.updateComplete.dispatch();

        assertThat( _game.getSystem( DecodeSystem ), instanceOf( DecodeSystem ) );
    }

    [Test]
    public function addDecodeSystem_removes_onUpdateCompleteHandler():void
    {
        _classUnderTest.addSystem( SystemName.DECODE );
        _game.updateComplete.dispatch();
        _game.removeAllSystems();
        _game.updateComplete.dispatch();

        assertThat( _game.getSystem( DecodeSystem ), nullValue() );
    }

    [Test]
    public function addDecodeSystem_adds_singleton_instance():void
    {
        _classUnderTest.addSystem( SystemName.DECODE );
        _game.updateComplete.dispatch();
        _game.removeAllSystems();
        _classUnderTest.addSystem( SystemName.DECODE );
        _game.updateComplete.dispatch();

        assertThat( _game.systemsReceived[0], strictlyEqualTo( _game.systemsReceived[1] ) );
    }

    [Test]
    public function addDecodeSystem_will_not_add_if_already_added():void
    {
        _classUnderTest.addSystem( SystemName.DECODE );
        _game.updateComplete.dispatch();
        _classUnderTest.addSystem( SystemName.DECODE );
        _game.updateComplete.dispatch();

        assertThat( _game.systemsReceived.length, equalTo( 1 ) );
    }

    [Test]
    public function removeDecodeSystem_does_not_remove_System_immediately():void
    {
        _classUnderTest.addSystem( SystemName.DECODE );
        _game.updateComplete.dispatch();
        _classUnderTest.removeSystem( SystemName.DECODE );

        assertThat( _game.getSystem( DecodeSystem ), instanceOf( DecodeSystem ) );
    }

    [Test]
    public function removeDecodeSystem_removes_System_onUpdateComplete():void
    {
        _classUnderTest.addSystem( SystemName.DECODE );
        _classUnderTest.removeSystem( SystemName.DECODE );
        _game.updateComplete.dispatch();

        assertThat( _game.getSystem( DecodeSystem ), nullValue() );
    }


    [Test]
    public function removeDecodeSystem_removes_onUpdateComplete_handler():void
    {
        _classUnderTest.addSystem( SystemName.DECODE );
        _classUnderTest.removeSystem( SystemName.DECODE );
        _game.updateComplete.dispatch();
        _classUnderTest.addSystem( SystemName.DECODE );
        _game.updateComplete.dispatch();

        assertThat( _game.getSystem( DecodeSystem ), instanceOf( DecodeSystem ) );
    }

}
}
