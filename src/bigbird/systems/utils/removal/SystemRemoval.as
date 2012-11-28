package bigbird.systems.utils.removal
{
import net.richardlord.signals.Signal0;

public class SystemRemoval implements SelfRemovingSystem
{

    public function SystemRemoval( onRemove:Function, updateComplete:Signal0, inactiveCount:int = 3 ):void
    {
        _onRemove = onRemove;
        _inactiveCount = inactiveCount;
        _updateComplete = updateComplete;
    }

    private var _flaggedForRemove:Boolean = false;
    private var _onRemove:Function;
    private var _updateComplete:Signal0;

    private var _inactiveCount:int = 0;

    public function get inactiveCount():int
    {
        return _inactiveCount;
    }

    public function get flaggedForRemove():Boolean
    {
        return _flaggedForRemove;
    }


    private var _count:int = 0;

    public function get count():int
    {
        return _count;
    }

    private var _isActive:Boolean = false;

    public function get isActive():Boolean
    {
        return _isActive;
    }

    public function cancelRemoval():void
    {
        _flaggedForRemove = false;
        _count = 0;
        _updateComplete.remove( onUpdateComplete );
    }

    public function confirmActivity():void
    {
        _isActive = true;
        _count = 0;
    }

    public function applyActivity():void
    {

        if ( !_isActive && ++_count == 3 && _onRemove != null && _updateComplete != null )
        {
            _flaggedForRemove = true;
            _updateComplete.addOnce( onUpdateComplete );
        }
        _isActive = false;
    }

    private function onUpdateComplete():void
    {
        _onRemove();
    }


}
}
