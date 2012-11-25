package bigbird.components.utils
{
import flash.utils.Dictionary;

import net.richardlord.ash.core.Entity;
import net.richardlord.ash.fsm.EntityStateMachine;

public class EntityFSMController
{

    private const _map:Dictionary = new Dictionary( false );

    public function changeState( statename:*, entity:Entity ):void
    {
        const fsm:EntityStateMachine = entity.get( EntityStateMachine );
        fsm.changeState( statename );
        if ( _map[statename] != null )
        {
            _map[statename]();
        }

    }

    public function removeOnEnter( statename:String ):void
    {
        delete _map[statename];
    }

    public function addOnEnter( statename:String, onEnter:Function ):void
    {
        if ( _map[statename] == null )
            _map[statename] = onEnter;

    }


}
}
