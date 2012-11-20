package bigbird.factories
{
import bigbird.asserts.assertExpectedComponents;
import bigbird.components.EntityStateNames;
import bigbird.components.KeyCell;
import bigbird.components.KeyValuePairIndex;
import bigbird.components.ValueCell;

import flash.net.URLRequest;

import net.richardlord.ash.core.Entity;
import net.richardlord.ash.fsm.EntityStateMachine;

import supporting.MockGame;
import supporting.values.DOCUMENT_URL;
import supporting.values.KEY_CELL_XML;
import supporting.values.VALUE_CELL_XML;

public class KeyValuePairEntityFSMTest
{
    private const defaultComponents:Array = [EntityStateMachine];

    private var _game:MockGame;
    private var _classUnderTest:Entity;
    private var _fsm:EntityStateMachine;

    [Before]
    public function before():void
    {
        _game = new MockGame();
        _classUnderTest = new KeyValuePairFactory( _game ).createKeyValuePair( DOCUMENT_URL, KEY_CELL_XML, VALUE_CELL_XML );
        _fsm = _classUnderTest.get( EntityStateMachine );
    }

    [After]
    public function after():void
    {
        _game = null;
        _classUnderTest = null;
        _fsm = null;
    }

    [Test]
    public function pre_despatch_state():void
    {
        const expectedComponents:Array = defaultComponents.concat( [URLRequest, KeyValuePairIndex, KeyCell, ValueCell] );
        changeState( EntityStateNames.PRE_DISPATCH );
        assertExpectedComponents( expectedComponents, _classUnderTest );
    }

    /*  [Test]
     public function pre_loading_state_is_default():void
     {
     const expectedComponents:Array = defaultComponents.concat( [URLRequest] );
     assertExpectedComponents( expectedComponents, _classUnderTest );
     }*/

    private function changeState( name:String ):void
    {
        _fsm.changeState( name );
    }


}
}
