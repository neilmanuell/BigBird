package bigbird.systems.utils
{
import net.richardlord.signals.Signal0;

import org.hamcrest.assertThat;
import org.hamcrest.object.equalTo;
import org.hamcrest.object.isFalse;
import org.hamcrest.object.isTrue;

public class SystemRemovalTest
{


    private var _classUnderTest:SystemRemoval;
    private var _onRemove:Function;
    private var _inactiveCount:int = 0;

    public function prepare( onRemove:Function, updateComplete:Signal0, inactiveCount:int = 3 ):void
    {
        _classUnderTest = new SystemRemoval( onRemove, updateComplete, inactiveCount );
    }

    [After]
    public function after():void
    {

    }

    [Test]
    public function isActive_by_default_false():void
    {
        prepare( null, null );
        assertThat( _classUnderTest.isActive, isFalse() )
    }

    [Test]
    public function count_by_default_zero():void
    {
        prepare( null, null );
        assertThat( _classUnderTest.count, equalTo( 0 ) )
    }

    [Test]
    public function confirmActivity_sets_isActive_true():void
    {
        prepare( null, null );
        _classUnderTest.confirmActivity();
        assertThat( _classUnderTest.isActive, isTrue() );
    }

    [Test]
    public function confirmActivity_sets_count_to_zero():void
    {
        prepare( null, null );
        _classUnderTest.applyActivity();
        _classUnderTest.confirmActivity();
        assertThat( _classUnderTest.count, equalTo( 0 ) );
    }

    [Test]
    public function resetActivity_sets_isActive_false():void
    {
        prepare( null, null );
        _classUnderTest.confirmActivity();
        _classUnderTest.resetActivity();
        assertThat( _classUnderTest.isActive, isFalse() );
    }

    [Test]
    public function applyActivity_inc_count_if_no_confirmActivity():void
    {
        prepare( null, null );
        _classUnderTest.applyActivity();
        assertThat( _classUnderTest.count, equalTo( 1 ) );
    }

    [Test]
    public function inactiveCount_set_by_constructor():void
    {
        prepare( null, null, 5 );
        assertThat( _classUnderTest.inactiveCount, equalTo( 5 ) );
    }

    [Test]
    public function onRemove_called_after_correct_period_of_inactivity():void
    {
        var onRemoveCalled:Boolean = false;
        const updateComplete:Signal0 = new Signal0();
        const onRemove:Function = function ():void
        {
            onRemoveCalled = true
        };

        prepare( onRemove, updateComplete, 3 );
        update( updateComplete );
        update( updateComplete );
        update( updateComplete );
        assertThat( onRemoveCalled, isTrue() );
    }

    [Test]
    public function onRemove_not_called_until_correct_period_of_inactivity():void
    {
        var onRemoveCalled:Boolean = false;
        const updateComplete:Signal0 = new Signal0();
        const onRemove:Function = function ():void
        {
            onRemoveCalled = true
        };

        prepare( onRemove, updateComplete, 3 );
        update( updateComplete );

        update( updateComplete );
        assertThat( onRemoveCalled, isFalse() );
    }

    private function update( updateComplete:Signal0 = null ):void
    {
        _classUnderTest.applyActivity();
        if ( updateComplete != null )
            updateComplete.dispatch();
    }


}
}
