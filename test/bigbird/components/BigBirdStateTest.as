package bigbird.components
{
import net.richardlord.signals.Signal0;

import org.hamcrest.assertThat;
import org.hamcrest.object.isFalse;
import org.hamcrest.object.isTrue;

public class BigBirdStateTest
{
    private var _classUnderTest:BigBirdState;
    private var _onUpdateComplete:Signal0;


    [Before]
    public function setUp():void
    {
        _onUpdateComplete = new Signal0();
        _classUnderTest = new BigBirdState( _onUpdateComplete );
    }

    [After]
    public function tearDown():void
    {
        _onUpdateComplete = null;
        _classUnderTest = null;

    }

    [Test]
    public function isDecoding_does_not_set_value_immediately():void
    {
        setIsDecoding( true, false );
        assertThat( _classUnderTest.isDecoding, isFalse() );
    }

    [Test]
    public function isLoading_does_not_set_value_immediately():void
    {
        setIsLoading( true, false )
        assertThat( _classUnderTest.isLoading, isFalse() );
    }

    [Test]
    public function isDecoding_sets_value_onUpdateComplete():void
    {
        setIsDecoding( true );
        assertThat( _classUnderTest.isDecoding, isTrue() );
    }

    [Test]
    public function isLoading_sets_value_onUpdateComplete():void
    {
        setIsLoading( true );
        assertThat( _classUnderTest.isLoading, isTrue() );
    }

    [Test]
    public function isLoading_bitmasking_works_both_ways_independently_of_other_bits():void
    {
        setValueOnDecodingAndLoading( true );
        setIsLoading( false );
        assertThat( "isDecoding is true", _classUnderTest.isDecoding, isTrue() );
        assertThat( "isLoading is false", _classUnderTest.isLoading, isFalse() );
    }


    [Test]
    public function isLoading_bitmask_applied_twice_to_true():void
    {
        setIsLoading( true );
        setIsLoading( true );
        assertThat( "isLoading is true", _classUnderTest.isLoading, isTrue() );
        assertThat( "isDecoding is false", _classUnderTest.isDecoding, isFalse() );
    }

    [Test]
    public function isLoading_bitmask_applied_twice_to_false():void
    {
        setValueOnDecodingAndLoading( true );
        setIsLoading( false );
        setIsLoading( false );
        assertThat( "isDecoding is true", _classUnderTest.isDecoding, isTrue() );
        assertThat( "isLoading is false", _classUnderTest.isLoading, isFalse() );
    }


    [Test]
    public function isLoading_bitmask_applies_only_once():void
    {
        setValueOnDecodingAndLoading( true );
        _classUnderTest.isLoading = false;
        setIsLoading( false, false );
        setIsLoading( false );
        assertThat( "isDecoding is true", _classUnderTest.isDecoding, isTrue() );
        assertThat( "isLoading is false", _classUnderTest.isLoading, isFalse() );
    }

    [Test]
    public function areAllInactive_returns_true_by_default():void
    {
        assertThat( _classUnderTest.areAllInactive, isTrue() );
    }

    [Test]
    public function areAllInactive_returns_false_if_isDecoding_true():void
    {
        setIsDecoding( true );
        assertThat( _classUnderTest.areAllInactive, isFalse() );
    }

    [Test]
    public function onActive_dispatches_once_one_state_is_active():void
    {
        var onActiveDispatched:Boolean = false;
        const onActiveHandler:Function = function ():void
        {
            onActiveDispatched = true;
        }
        _classUnderTest.onActive.addOnce( onActiveHandler );
        setIsDecoding( true );
        assertThat( onActiveDispatched, isTrue() );
    }

    [Test]
    public function onInactive_dispatches_once_all_states_are_inactive():void
    {
        var onInactiveDispatched:Boolean = false;
        const onInactiveHandler:Function = function ():void
        {
            onInactiveDispatched = true;
        }
        _classUnderTest.onInactive.addOnce( onInactiveHandler );
        setIsDecoding( true );
        setIsDecoding( false );
        assertThat( onInactiveDispatched, isTrue() );
    }

    private function setValueOnDecodingAndLoading( value:Boolean, dispatch:Boolean = true ):void
    {
        _classUnderTest.isLoading = value;
        _classUnderTest.isDecoding = value;
        if ( dispatch ) _onUpdateComplete.dispatch();
    }

    private function setIsLoading( value:Boolean, dispatch:Boolean = true ):void
    {
        _classUnderTest.isLoading = value;
        if ( dispatch ) _onUpdateComplete.dispatch();
    }

    private function setIsDecoding( value:Boolean, dispatch:Boolean = true ):void
    {
        _classUnderTest.isDecoding = value;
        if ( dispatch )  _onUpdateComplete.dispatch();
    }

}
}
