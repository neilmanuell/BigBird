package bigbird.systems
{
import bigbird.components.BigBirdProgress;
import bigbird.components.DocumentState;
import bigbird.components.DocumentLoader;
import bigbird.components.Progress;
import bigbird.io.Loader;

import flash.events.Event;
import flash.net.URLRequest;

import mockolate.nice;
import mockolate.prepare;
import mockolate.received;
import mockolate.stub;

import net.richardlord.ash.core.Entity;
import net.richardlord.ash.core.Game;

import org.flexunit.async.Async;
import org.hamcrest.assertThat;
import org.hamcrest.core.not;
import org.hamcrest.object.equalTo;

import supporting.MockGame;
import supporting.values.DOCUMENT_FULL_SMALL_XML;
import supporting.values.DOCUMENT_SINGLE_KEY_VALUE_PAIR_XML;

public class Loading_ProgressSystemTest
{
    private var _game:MockGame;
    private var _stateMachine:StateMachine;
    private var _progress:BigBirdProgress;
    private var _classUnderTest:ProgressSystem;
    private var _entityOne:Entity;
    private var _entityTwo:Entity;
    private var _loaderOne:Loader;
    private var _loaderTwo:Loader;

    [Before(order=1, async, timeout=5000)]
    public function prepareMockolates():void
    {
        Async.proceedOnEvent( this,
                prepare( StateMachine, Loader ),
                Event.COMPLETE );
    }

    [Before(order=2)]
    public function before():void
    {
        _stateMachine = nice( StateMachine );
        _game = new MockGame();
        stubAndAddEntities( _game );

        _progress = new BigBirdProgress( null );
        _classUnderTest = new ProgressSystem( _progress, _stateMachine );
    }



    [After]
    public function after():void
    {
        _game = null;
        _progress = null;
        _stateMachine = null;
        _classUnderTest = null;
    }

    [Test]
    public function update_sets_totalLoadingWork():void
    {
        _classUnderTest.addToGame( _game );
        callUpdate( 1 );

        assertThat( _progress.totalLoadingWork, equalTo( 116 ) );
    }

    [Test]
    public function update_sets_loadingWorkDone():void
    {
        _classUnderTest.addToGame( _game );
        callUpdate( 1 );

        assertThat( _progress.loadingWorkDone, equalTo( 52 ) );
    }

    [Test]
    public function update_sets_loadingWorkDone_during_successive_calls():void
    {
        _classUnderTest.addToGame( _game );
        callUpdate( 2 );

        assertThat( _progress.loadingWorkDone, equalTo( 75 ) );
    }

    [Test]
    public function update_resets_totalLoadingWork_before_summation():void
    {
        _classUnderTest.addToGame( _game );
        callUpdate( 2 );

        assertThat( _progress.totalLoadingWork, equalTo( 116 ) );
    }

    [Test]
    public function update_resets_loadingWorkDone_before_summation():void
    {
        _classUnderTest.addToGame( _game );
        callUpdate( 2 );

        assertThat( _progress.loadingWorkDone, equalTo( 75 ) );
    }

    [Test]
    public function update_ends_decodingState_when_progress_complete():void
    {
        _classUnderTest.addToGame( _game );
        callUpdate( 4 );

        assertThat( _stateMachine, received().method( "exitLoadingState" ).once() );
    }

    [Test]
    public function update_does_not_end_decodingState_unless_progress_complete():void
    {
        _classUnderTest.addToGame( _game );
        callUpdate( 2 );

        assertThat( _stateMachine, not( received().method( "exitLoadingState" ).once() ) );

    }

    [Test]
    public function update_sets_rawData_on_Entity_when_loading_complete_and_not_until():void
    {
        _classUnderTest.addToGame( _game );
        callUpdate( 3 );
        assertThat( _loaderOne, received().getter( "data" ).once() );
        assertThat( _loaderTwo, received().getter( "data" ).never());
    }

    private function callUpdate( times:int ):void
    {

        while ( times > 0 )
        {
            _classUnderTest.update( 0 );
            _game.updateComplete.dispatch();
            times--;
        }
    }

    private function stubAndAddEntities( game:Game ):void
    {
        _loaderOne = nice( Loader );
        stub( _loaderOne ).getter( "bytesTotal" ).returns( 50 );
        stub( _loaderOne ).getter( "bytesLoaded" ).returns( 23, 33, 50 );
        stub( _loaderOne ).getter( "data" ).returns( DOCUMENT_SINGLE_KEY_VALUE_PAIR_XML );
        _entityOne = new Entity();
        _entityOne.add( new URLRequest( "" ) );
        _entityOne.add( new DocumentLoader( _loaderOne ) )
        _entityOne.add( new DocumentState( _entityOne ) );
        _entityOne.add( new Progress( 0 ) );

        _loaderTwo = nice( Loader );
        stub( _loaderTwo ).getter( "bytesTotal" ).returns( 66 );
        stub( _loaderTwo ).getter( "bytesLoaded" ).returns( 29, 42, 54, 66 );
        stub( _loaderOne ).getter( "data" ).returns( DOCUMENT_FULL_SMALL_XML );
        _entityTwo = new Entity();
        _entityTwo.add( new URLRequest( "" ) );
        _entityTwo.add( new DocumentLoader( _loaderTwo ) )
        _entityTwo.add( new DocumentState( _entityTwo ) );
        _entityTwo.add( new Progress( 0 ) );

        game.addEntity( _entityOne );
        game.addEntity( _entityTwo );
    }

}
}
