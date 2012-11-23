package bigbird.systems
{
import bigbird.components.BigBirdProgress;
import bigbird.core.ProgressSignal;

import net.richardlord.ash.core.Game;

import org.hamcrest.assertThat;
import org.hamcrest.object.notNullValue;
import org.hamcrest.object.nullValue;

public class DispatchProgressSystemRemovalTest
{
    private var _game:Game;
    private var _progress:BigBirdProgress;
    private var _progressSignal:ProgressSignal;
    private var _classUnderTest:DispatchProgressSystem;

    [Before]
    public function before():void
    {

        _game = new Game();

        _progressSignal = new ProgressSignal();
        _progress = new BigBirdProgress( _progressSignal );
        _classUnderTest = new DispatchProgressSystem( _progress );
        _game.addSystem( _classUnderTest, 0 );

    }

    [After]
    public function after():void
    {
        _game = null;
        _progress = null;
        _progressSignal = null;
        _classUnderTest = null;
    }


    [Test]
    public function does_not_remove_self_before_3_inactive_updates():void
    {

        update();
        update();

        assertThat( _game.getSystem( DispatchProgressSystem ), notNullValue() );
    }

    [Test]
    public function removes_self_after_3_inactive_updates():void
    {
        _progress.totalWork = 0;
        _progress.workDone = 0;
        update();
        update();
        update();

        assertThat( _game.getSystem( DispatchProgressSystem ), nullValue() );
    }

    [Test]
    public function does_not_removes_self_if_new_value_added():void
    {

        update();
        update();
        _progress.totalWork = 10;
        _progress.workDone = 1;
        update();

        assertThat( _game.getSystem( DispatchProgressSystem ), notNullValue() );
    }


    private function update():void
    {
        _game.update( 0 );

    }


}
}
