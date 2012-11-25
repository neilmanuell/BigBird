package bigbird.components.utils
{
import net.richardlord.ash.core.Entity;
import net.richardlord.ash.fsm.EntityStateMachine;

import org.hamcrest.assertThat;
import org.hamcrest.collection.hasItem;
import org.hamcrest.object.strictlyEqualTo;

public class EntityStateChangerTest
{
    private const STATE_ONE:Object = {name:"stateOne", onEnter:onEnterStateOne};
    private const STATE_TWO:Object = {name:"stateTwo", onEnter:onEnterStateTwo};

    private var _entity:Entity;
    private var _fsm:EntityStateMachine;
    private var _recievedState:Object;
    private var _classUnderTest:EntityFSMController

    [Before]
    public function before():void
    {
        _entity = new Entity()
        _fsm = new EntityStateMachine( _entity );
        _fsm.createState( STATE_ONE.name ).add( Object ).withInstance( STATE_ONE );
        _fsm.createState( STATE_TWO.name ).add( Object ).withInstance( STATE_TWO );
        _entity.add( _fsm );
        _classUnderTest = new EntityFSMController()
    }

    [After]
    public function after():void
    {
        _entity = null;
        _fsm = null;

    }

    [Test]
    public function changeState_changes_state():void
    {
        _classUnderTest.changeState( STATE_ONE.name, _entity );
        assertThat( _entity.getAll(), hasItem( STATE_ONE ) );
    }

    [Test]
    public function onEnter_for_state_one_executed():void
    {
        _classUnderTest.addOnEnter( STATE_ONE.name, STATE_ONE.onEnter );
        _classUnderTest.changeState( STATE_ONE.name, _entity );

        assertThat( _recievedState, strictlyEqualTo( STATE_ONE ) );
    }

    [Test]
    public function onEnter_for_state_two_executed():void
    {
        _classUnderTest.addOnEnter( STATE_TWO.name, STATE_TWO.onEnter );
        _classUnderTest.changeState( STATE_TWO.name, _entity );

        assertThat( _recievedState, strictlyEqualTo( STATE_TWO ) );
    }

    [Test]
    public function duplicate_mapping_ignored():void
    {
        _classUnderTest.addOnEnter( STATE_ONE.name, STATE_ONE.onEnter );
        _classUnderTest.addOnEnter( STATE_ONE.name, STATE_TWO.onEnter );
        _classUnderTest.changeState( STATE_ONE.name, _entity );

        assertThat( _recievedState, strictlyEqualTo( STATE_ONE ) );
    }

    [Test]
    public function remove_mapping():void
    {
        _classUnderTest.addOnEnter( STATE_ONE.name, STATE_ONE.onEnter );
        _classUnderTest.removeOnEnter( STATE_ONE.name )
        _classUnderTest.addOnEnter( STATE_ONE.name, STATE_TWO.onEnter );
        _classUnderTest.changeState( STATE_ONE.name, _entity );

        assertThat( _recievedState, strictlyEqualTo( STATE_TWO ) );
    }


    private function onEnterStateOne():void
    {
        _recievedState = STATE_ONE;
    }

    private function onEnterStateTwo():void
    {
        _recievedState = STATE_TWO;
    }


}
}
