package bigbird.systems
{
import bigbird.components.BigBirdProgress;
import bigbird.factories.EntityFactory;
import bigbird.nodes.DecodeNode;

import flash.events.Event;

import mockolate.nice;
import mockolate.prepare;
import mockolate.received;

import net.richardlord.ash.core.NodeList;

import org.flexunit.async.Async;
import org.hamcrest.assertThat;
import org.hamcrest.core.not;
import org.hamcrest.object.equalTo;

import supporting.MockGame;
import supporting.values.DOCUMENT_FULL_XML;

public class Decoding_ProgressSystemTest
{
    private var _game:MockGame;
    private var _stateMachine:StateMachine;
    private var _decodeNodes:NodeList;
    private var _progress:BigBirdProgress;
    private var _classUnderTest:ProgressSystem;

    [Before(order=1, async, timeout=5000)]
    public function prepareMockolates():void
    {
        Async.proceedOnEvent( this,
                prepare( StateMachine ),
                Event.COMPLETE );
    }

    [Before(order=2)]
    public function before():void
    {
        _stateMachine = nice( StateMachine );
        _game = new MockGame();
        //todo: add progress signal here;
        _progress = new BigBirdProgress( null );
        const factory:EntityFactory = new EntityFactory( _game );
        factory.createWordDocument( DOCUMENT_FULL_XML );
        factory.createWordDocument( DOCUMENT_FULL_XML );
        factory.createWordDocument( DOCUMENT_FULL_XML );

        _decodeNodes = _game.getNodeList( DecodeNode );
        _classUnderTest = new ProgressSystem( _progress, _stateMachine );
    }

    [After]
    public function after():void
    {
        _game = null;
        _progress = null;
    }

    [Test]
    public function update_sets_totalDecodingWork():void
    {
        _classUnderTest.addToGame( _game );
        _classUnderTest.update( 0 );

        assertThat( _progress.totalDecodingWork, equalTo( 1014 ) );
    }

    [Test]
    public function update_resets_totalDecodingWork_before_summation():void
    {
        _classUnderTest.addToGame( _game );
        _classUnderTest.update( 0 );
        _classUnderTest.update( 0 );

        assertThat( _progress.totalDecodingWork, equalTo( 1014 ) );
    }

    [Test]
    public function update_sets_decodingWorkDone():void
    {
        _classUnderTest.addToGame( _game );
        prepareSomeProgress();
        _classUnderTest.update( 0 );

        assertThat( _progress.decodingWorkDone, equalTo( 6 ) );
    }

    [Test]
    public function update_resets_decodingWorkDone_before_summation():void
    {
        _classUnderTest.addToGame( _game );
        prepareSomeProgress();
        _classUnderTest.update( 0 );
        _classUnderTest.update( 0 );

        assertThat( _progress.decodingWorkDone, equalTo( 6 ) );
    }

    [Test]
    public function update_ends_decodingState_when_progress_complete():void
    {
        _classUnderTest.addToGame( _game );
        prepareCompletedProgress();
        _classUnderTest.update( 0 );

        assertThat( _stateMachine, received().method( "exitDecodingState" ).once() );
    }

    [Test]
    public function update_does_not_end_decodingState_unless_progress_complete():void
    {
        _classUnderTest.addToGame( _game );
        prepareSomeProgress();
        _classUnderTest.update( 0 );

        assertThat( _stateMachine, not( received().method( "exitDecodingState" ).once() ) );

    }

    private function prepareSomeProgress():void
    {
        var count:int = 0;
        for ( var node:DecodeNode = _decodeNodes.head; node; node = node.next )
        {
            node.progress.workDone += ++count;
        }
    }

    private function prepareCompletedProgress():void
    {
        for ( var node:DecodeNode = _decodeNodes.head; node; node = node.next )
        {
            node.progress.workDone = node.progress.totalWork;
        }
    }
}
}
