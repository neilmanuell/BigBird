package bigbird.systems.utils
{
import net.richardlord.ash.core.Game;

import org.hamcrest.assertThat;
import org.hamcrest.object.equalTo;
import org.hamcrest.object.isFalse;
import org.hamcrest.object.isTrue;
import org.hamcrest.object.notNullValue;
import org.swiftsuspenders.Injector;

import supporting.systems.FlaggedSelfRemovingSystem;
import supporting.systems.UnflaggedSelfRemovingSystem;

public class SystemAdditionTest
{
    private var _classUnderTest:SystemAddition;
    private var _injector:Injector;
    private var _game:Game;

    [Before]
    public function before():void
    {
        _injector = new Injector();
        _game = new Game();
        _injector.map( Injector ).toValue( _injector );
        _injector.map( Game ).toValue( _game );
        _injector.map( SystemAddition );
        _injector.map( FlaggedSelfRemovingSystem );
        _injector.map( UnflaggedSelfRemovingSystem );

        _classUnderTest = _injector.getInstance( SystemAddition );

    }

    [After]
    public function after():void
    {
        _classUnderTest = null;
        _injector = null;
    }

    [Test]
    public function adding_System():void
    {
        _classUnderTest.addSystem( UnflaggedSelfRemovingSystem, 0 );
        assertThat( _game.getSystem( UnflaggedSelfRemovingSystem ), notNullValue() );
    }

    [Test]
    public function added_systems_are_not_duplicated():void
    {
        _game.addSystem( new UnflaggedSelfRemovingSystem(), 0 )
        _classUnderTest.addSystem( UnflaggedSelfRemovingSystem, 0 );
        assertThat( _game.systems.length, equalTo( 1 ) );
    }

    [Test]
    public function existing_flagged_System_calls_cancelRemoval():void
    {
        const existing:FlaggedSelfRemovingSystem = new FlaggedSelfRemovingSystem()
        _game.addSystem( existing, 0 )
        _classUnderTest.addSystem( FlaggedSelfRemovingSystem, 0 );
        assertThat( existing.removalCancelled, isTrue() );
    }

    [Test]
    public function existing_unflagged_System_does_not_call_cancelRemoval():void
    {
        const existing:UnflaggedSelfRemovingSystem = new UnflaggedSelfRemovingSystem()
        _game.addSystem( existing, 0 )
        _classUnderTest.addSystem( UnflaggedSelfRemovingSystem, 0 );
        assertThat( existing.removalCancelled, isFalse() );
    }
}
}
