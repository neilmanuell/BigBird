package bigbird.systems
{
import bigbird.components.BigBirdState;
import bigbird.factories.SingletonSystemFactory;

import org.hamcrest.assertThat;
import org.hamcrest.object.instanceOf;
import org.hamcrest.object.isFalse;
import org.hamcrest.object.isTrue;
import org.hamcrest.object.nullValue;

import supporting.MockGame;
import supporting.utils.configureTestSingletonSystemFactory;

public class StateMachineTest
{
    private var _game:MockGame;
    private var _factory:SingletonSystemFactory;
    private var _state:BigBirdState;
    private var _classUnderTest:StateMachine;

    [Before]
    public function before():void
    {
        _game = new MockGame();
        _state = new BigBirdState( _game.updateComplete );
        _factory = configureTestSingletonSystemFactory( _game );
        _classUnderTest = new StateMachine( _state, _factory );
    }

    [After]
    public function after():void
    {
        _game = null;
        _factory = null;
        _state = null;
        _classUnderTest = null;
    }


    [Test]
    public function enterDecodingState_adds_DecodingSystem_to_game():void
    {
        _classUnderTest.enterDecodingState();
        dispatchOnUpdateComplete();

        assertThat( _game.getSystem( DecodeSystem ), instanceOf( DecodeSystem ) );
    }

    [Test]
    public function enterDecodingState_adds_DispatchKeyValuePairSystem_to_game():void
    {
        _classUnderTest.enterDecodingState();
        dispatchOnUpdateComplete();

        assertThat( _game.getSystem( DispatchDecodedSystem ), instanceOf( DispatchDecodedSystem ) );
    }

    [Test]
    public function exitDecodingState_removes_DecodingSystem_from_game():void
    {
        _classUnderTest.enterDecodingState();
        dispatchOnUpdateComplete();
        _classUnderTest.exitDecodingState();
        dispatchOnUpdateComplete();

        assertThat( _game.getSystem( DecodeSystem ), nullValue() );
    }


    [Test]
    public function exitDecodingState_removes_DispatchDecodedSystem_from_game():void
    {
        _classUnderTest.enterDecodingState();
        dispatchOnUpdateComplete();
        _classUnderTest.exitDecodingState();
        dispatchOnUpdateComplete();

        assertThat( _game.getSystem( DispatchDecodedSystem ), nullValue() );
    }

    [Test]
    public function enterDecodingState_does_not_set_isDecoding_true_immediately():void
    {
        _classUnderTest.enterDecodingState();

        assertThat( _state.isDecoding, isFalse );
    }

    [Test]
    public function enterDecodingState_sets_isDecoding_true_onUpdateComplete():void
    {
        _classUnderTest.enterDecodingState();
        dispatchOnUpdateComplete();

        assertThat( _state.isDecoding, isTrue() );
    }

    [Test]
    public function exitDecodingState_does_not_set_isDecoding_false_immediately():void
    {
        _state.isDecoding = true;
        dispatchOnUpdateComplete();
        _classUnderTest.exitDecodingState();

        assertThat( _state.isDecoding, isTrue() );
    }

    [Test]
    public function exitDecodingState_sets_isDecoding_true_onUpdateComplete():void
    {
        _state.isDecoding = true;
        dispatchOnUpdateComplete();
        _classUnderTest.exitDecodingState();
        dispatchOnUpdateComplete();

        assertThat( _state.isDecoding, isFalse() );
    }

    [Test]
    public function enterDecodingState_if_isDecoding_true_state_not_entered():void
    {
        _state.isDecoding = true;
        dispatchOnUpdateComplete();
        _classUnderTest.enterDecodingState();
        dispatchOnUpdateComplete();

        assertThat( _game.getSystem( DecodeSystem ), nullValue() );
    }

    [Test]
    public function exitDecodingState_if_isDecoding_false_state_not_exited():void
    {
        _classUnderTest.enterDecodingState();
        dispatchOnUpdateComplete();
        _state.isDecoding = false;
        dispatchOnUpdateComplete();
        _classUnderTest.exitDecodingState();
        dispatchOnUpdateComplete();

        assertThat( _game.getSystem( DecodeSystem ), instanceOf( DecodeSystem ) );
    }

    private function dispatchOnUpdateComplete():void
    {
        _game.updateComplete.dispatch();
    }
}

}
