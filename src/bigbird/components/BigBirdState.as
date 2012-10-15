package bigbird.components
{
import net.richardlord.signals.Signal0;

public class BigBirdState
{
    public const onInactive:Signal0 = new Signal0();
    public const onActive:Signal0 = new Signal0();

    private var _updateComplete:Signal0;
    private const IS_LOADING:uint = 1;
    private const IS_DECODING:uint = 2;
    private var _states:uint = 0;
    private var _scheduledChanges:uint = 0;


    public function BigBirdState( updateComplete:Signal0 )
    {
        _updateComplete = updateComplete;
    }

    public function get isDecoding():Boolean
    {
        return (_states & IS_DECODING);
    }

    public function set isDecoding( value:Boolean ):void
    {
        setBit( value, IS_DECODING );
    }

    public function get isLoading():Boolean
    {
        return (_states & IS_LOADING);
    }

    public function set isLoading( value:Boolean ):void
    {
        setBit( value, IS_LOADING );
    }

    public function get  areAllInactive():Boolean
    {
        return( !isDecoding && !isLoading )
    }

    public function setBit( value:Boolean, flag:uint ):void
    {
        if ( _scheduledChanges & flag || (_states & flag) == value ) return;
        _scheduledChanges |= flag;

        if ( areAllInactive && value )
        {
            onActive.dispatch();
        }

        const onUpDateComplete:Function = function ():void
        {

            if ( value )
            {
                _states |= flag;
            }
            else
            {
                _states ^= flag;
            }

            _scheduledChanges ^= flag;

            if ( areAllInactive )
            {
                onInactive.dispatch();
            }
        }

        _updateComplete.addOnce( onUpDateComplete );
    }
}
}
