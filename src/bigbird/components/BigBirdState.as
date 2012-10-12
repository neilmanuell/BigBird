package bigbird.components
{
import net.richardlord.signals.Signal0;

public class BigBirdState
{

    private var _isDecoding:Boolean;

    private var _updateComplete:Signal0;


    public function BigBirdState( updateComplete:Signal0 )
    {
        _updateComplete = updateComplete;
    }

    public function get isDecoding():Boolean
    {
        return _isDecoding;
    }

    public function set isDecoding( value:Boolean ):void
    {
        const onUpDateComplete:Function = function ():void
        {
            _isDecoding = value;
        }
        _updateComplete.addOnce( onUpDateComplete );
    }
}
}
