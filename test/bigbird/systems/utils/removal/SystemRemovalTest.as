package bigbird.systems.utils.removal
{
import net.richardlord.signals.Signal0;

import org.hamcrest.assertThat;
import org.hamcrest.object.equalTo;
import org.hamcrest.object.isFalse;
import org.hamcrest.object.isTrue;

public class SystemRemovalTest
{


    private var _classUnderTest:ActivityMonitor;
    private var _onRemoveCalled:Boolean
    private var _onRemove:Function;
    private var _updateComplete:Signal0 = new Signal0();


    [After]
    public function after():void
    {
        _classUnderTest = null;
        _updateComplete = null;
        _onRemove = null;
    }

    [Test]
    public function isActive_by_default_false():void
    {
        prepare( null, 3 );
        assertThat( _classUnderTest.isActive, isFalse() )
    }

    [Test]
    public function count_by_default_zero():void
    {
        prepare( null, 3 );
        assertThat( _classUnderTest.count, equalTo( 0 ) )
    }

    [Test]
    public function confirmActivity_sets_isActive_true():void
    {
        prepare( null, 3 );
        _classUnderTest.confirmActivity();
        assertThat( _classUnderTest.isActive, isTrue() );
    }

    [Test]
    public function confirmActivity_sets_count_to_zero():void
    {
        prepare( null, 3 );
        _classUnderTest.applyActivity();
        _classUnderTest.confirmActivity();
        assertThat( _classUnderTest.count, equalTo( 0 ) );
    }

    [Test]
    public function overrideRemoval_sets_count_to_zero():void
    {
        prepare( null, 3 );
        _classUnderTest.applyActivity();
        _classUnderTest.cancelRemoval();
        assertThat( _classUnderTest.count, equalTo( 0 ) );
    }


    [Test]
    public function applyActivity_inc_count_if_no_confirmActivity():void
    {
        prepare( null, 3 );
        _classUnderTest.applyActivity();
        assertThat( _classUnderTest.count, equalTo( 1 ) );
    }

    [Test]
    public function inactiveCount_set_by_constructor():void
    {
        prepare( null, 5 );
        assertThat( _classUnderTest.inactiveCount, equalTo( 5 ) );
    }

    [Test]
    public function onRemove_called_after_correct_period_of_inactivity():void
    {
        prepare( onRemove, 3 );
        update( 3 );
        assertThat( _onRemoveCalled, isTrue() );
    }

    [Test]
    public function onRemove_not_called_after_correct_period_of_inactivity():void
    {
        prepare( onRemove, 3 );
        update( 3 );
        assertThat( _onRemoveCalled, isTrue() );
    }

    [Test]
    public function flaggedForRemove_true_after_correct_period_of_inactivity():void
    {
        prepare( emptyFunction, 3 );
        update( 3 );
        assertThat( _classUnderTest.flaggedForRemove, isTrue() );
    }


    [Test]
    public function onRemove_not_called_until_correct_period_of_inactivity():void
    {
        prepare( onRemove, 3 );
        update( 2 );
        assertThat( _onRemoveCalled, isFalse() );
    }

    [Test]
    public function onRemove_not_called_until_updateComplete():void
    {
        prepare( onRemove, 3 );
        update( 3, false );
        assertThat( _onRemoveCalled, isFalse() );
    }


    [Test]
    public function flaggedForRemove_false_until_correct_period_of_inactivity():void
    {
        prepare( emptyFunction, 3 );
        update( 2 );
        assertThat( _classUnderTest.flaggedForRemove, isFalse() );
    }

    [Test]
    public function onRemove_not_called_after_overrideRemoval():void
    {
        prepare( onRemove, 3 );
        update( 3, false );
        _classUnderTest.cancelRemoval();
        _updateComplete.dispatch();
        assertThat( _onRemoveCalled, isFalse() );
    }

    [Test]
    public function overrideRemoval_sets_flaggedForRemove_false():void
    {
        prepare( onRemove, 3 );
        update( 3, false );
        _classUnderTest.cancelRemoval();

        assertThat( _classUnderTest.flaggedForRemove, isFalse() );
    }

    [Test]
    public function overrideRemoval_sets_isActive_false():void
    {
        prepare( onRemove, 3 );
        update( 3, false );
        _classUnderTest.cancelRemoval();

        assertThat( _classUnderTest.isActive, isFalse() );
    }


    public function prepare( onRemove:Function, inactiveCount:int = 3 ):void
    {
        _classUnderTest = new ActivityMonitor( inactiveCount );
        _classUnderTest.onLimit = onRemove;
        _classUnderTest.updateComplete = _updateComplete;
    }

    private function update( times:int, dispatch:Boolean = true ):void
    {
        var count:int = 0;
        while ( count++ < times )
        {
            _classUnderTest.applyActivity();
            if ( dispatch )_updateComplete.dispatch();
        }
    }

    private function onRemove():void
    {
        _onRemoveCalled = true
    }

    private function emptyFunction():void
    {
    }


}
}
