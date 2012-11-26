package bigbird.systems
{
import bigbird.controller.EntityStateNames;
import bigbird.factories.WordEntityFactory;

import net.richardlord.ash.core.Entity;
import net.richardlord.ash.core.Game;
import net.richardlord.ash.fsm.EntityStateMachine;

import org.hamcrest.assertThat;
import org.hamcrest.object.notNullValue;
import org.hamcrest.object.nullValue;

import supporting.values.URL_WELL_FORMED_DOCUMENT_DOCX;

public class DecodeSystemRemovalTest
{

    private var _classUnderTest:DecodeSystem;
    private var _game:Game;


    [Before]
    public function before():void
    {
        _classUnderTest = new DecodeSystem( null );
        _game = new Game();

        _game.addSystem( _classUnderTest, 0 );

    }

    [After]
    public function after():void
    {
        _classUnderTest = null;
    }

    [Test]
    public function does_not_remove_self_before_3_inactive_updates():void
    {
        update();
        update();

        assertThat( _game.getSystem( DecodeSystem ), notNullValue() );
    }

    [Test]
    public function removes_self_after_3_inactive_updates():void
    {
        update();
        update();
        update();

        assertThat( _game.getSystem( DecodeSystem ), nullValue() );
    }

    [Test]
    public function does_not_removes_self_if_new_value_added():void
    {

        update();
        update();
        const entity:Entity = new WordEntityFactory( _game ).createWordFileEntity( URL_WELL_FORMED_DOCUMENT_DOCX );
        changeState( EntityStateNames.DECODING, entity );
        update();

        assertThat( _game.getSystem( DecodeSystem ), notNullValue() );
    }

    private function update():void
    {
        _game.update( 0 );
    }

    private function changeState( name:String, entity:Entity ):void
    {
        const fsm:EntityStateMachine = entity.get( EntityStateMachine );
        fsm.changeState( name );
    }


}
}
