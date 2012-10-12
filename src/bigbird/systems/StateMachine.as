package bigbird.systems
{
import bigbird.components.BigBirdState;
import bigbird.factories.SingletonSystemFactory;

public class StateMachine
{
    private var _factory:SingletonSystemFactory;
    private var _state:BigBirdState

    public function StateMachine( state:BigBirdState, factory:SingletonSystemFactory )
    {
        _factory = factory;
        _state = state;
    }

    public function enterDecodingState():void
    {
        if ( _state.isDecoding )return;
        _factory.addSystem( SystemName.DECODE );
        _factory.addSystem( SystemName.DISPATCH_DECODED );
        _state.isDecoding = true;
    }

    public function exitDecodingState():void
    {
        if ( !_state.isDecoding )return;
        _factory.removeSystem( SystemName.DECODE );
        _factory.removeSystem( SystemName.DISPATCH_DECODED );
        _state.isDecoding = false;
    }

}
}
