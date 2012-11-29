package bigbird.systems.utils.removal
{
import net.richardlord.signals.Signal0;

public class ActivityMonitor implements SelfRemovingSystem
{

    public function ActivityMonitor( inactiveCount:int = 3 ):void
    {
        _inactiveCount = inactiveCount;

    }

    private var _flaggedForRemove:Boolean = false;
    private var _onLimit:Function;
    private var _updateComplete:Signal0;

    private var _inactiveCount:int = 0;


    public function set onLimit( value:Function ):void
    {
        _onLimit = value;
    }

    public function set updateComplete( signal:Signal0 ):void
    {
        _updateComplete = signal;
    }

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
        if ( _updateComplete != null )
            _updateComplete.remove( onUpdateComplete );
    }

    public function confirmActivity():void
    {
        _isActive = true;
        _count = 0;
    }

    public function applyActivity():void
    {

        if ( !_isActive && ++_count == 3 && _onLimit != null && _updateComplete != null )
        {
            _flaggedForRemove = true;
            if ( _updateComplete != null )
                _updateComplete.addOnce( onUpdateComplete );
            else
            {
                onUpdateComplete();
            }
        }
        _isActive = false;
    }

    private function onUpdateComplete():void
    {
        if ( _onLimit != null )
            _onLimit();
    }


}
}
