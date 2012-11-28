package bigbird.systems.progress
{
import bigbird.components.BigBirdProgress;
import bigbird.core.ProgressSignal;
import bigbird.core.vos.ProgressVO;

import net.richardlord.ash.core.Game;

import org.hamcrest.assertThat;
import org.hamcrest.object.equalTo;
import org.hamcrest.object.instanceOf;
import org.hamcrest.object.nullValue;

public class DispatchProgressSystemTest
{
    private const TOTAL_WORK:int = 10;
    private const WORK_DONE:int = 1;
    private var _game:Game;
    private var _progress:BigBirdProgress;
    private var _progressSignal:ProgressSignal;
    private var _classUnderTest:DispatchProgressSystem;

    [Before]
    public function before():void
    {
        _progressSignal = new ProgressSignal();
        _progress = new BigBirdProgress( _progressSignal );
        _progress.totalWork = TOTAL_WORK;
        _progress.workDone = WORK_DONE;
        _classUnderTest = new DispatchProgressSystem( _progress );
        _classUnderTest.addToGame( new Game() );
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
    public function progress_dispatched_on_update():void
    {
        var vo:ProgressVO;

        const onProgress:Function = function ( progress:ProgressVO ):void
        {
            vo = progress
        };
        _progressSignal.addOnce( onProgress );


        update();


        assertThat( vo, instanceOf( ProgressVO ) );
    }

    [Test]
    public function progress_not_dispatched_on_update_when_factor_isNAN():void
    {
        var vo:ProgressVO;

        const onProgress:Function = function ( progress:ProgressVO ):void
        {
            vo = progress
        };
        _progressSignal.addOnce( onProgress );
        _progress.totalWork = 0;
        _progress.workDone = 0

        update();

        assertThat( vo, nullValue() );
    }

    [Test]
    public function workDone_dispatched():void
    {
        var vo:ProgressVO;

        const onProgress:Function = function ( progress:ProgressVO ):void
        {
            vo = progress
        };
        _progressSignal.addOnce( onProgress );

        update();

        assertThat( vo.workDone, WORK_DONE );
    }


    [Test]
    public function totalWork_dispatched():void
    {
        var vo:ProgressVO;

        const onProgress:Function = function ( progress:ProgressVO ):void
        {
            vo = progress
        };
        _progressSignal.addOnce( onProgress );

        update();

        assertThat( vo.totalWork, TOTAL_WORK );
    }

    [Test]
    public function totalWork_reset_after_dispatch():void
    {


        update();

        assertThat( _progress.totalWork, equalTo( 0 ) );
    }

    [Test]
    public function workDone_reset_after_dispatch():void
    {

        update();

        assertThat( _progress.workDone, equalTo( 0 ) );
    }


    private function update():void
    {
        _classUnderTest.update( 0 );
    }


}
}
