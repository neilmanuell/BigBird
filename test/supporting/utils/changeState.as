package supporting.utils
{
import net.richardlord.ash.core.Entity;
import net.richardlord.ash.fsm.EntityStateMachine;

public function changeState( statename:String, entity:Entity ):void
{
    const fsm:EntityStateMachine = entity.get( EntityStateMachine );
    fsm.changeState( statename );
}

}
