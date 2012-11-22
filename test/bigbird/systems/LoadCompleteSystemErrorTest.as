package bigbird.systems
{
import bigbird.components.io.DataLoader;
import bigbird.core.WordDataSignal;
import bigbird.core.vos.DataLoaderVO;
import bigbird.factories.WordEntityFactory;

import flash.net.URLRequest;

import net.richardlord.ash.core.Entity;
import net.richardlord.ash.core.Game;

import org.hamcrest.assertThat;
import org.hamcrest.object.equalTo;

import supporting.io.AngryDataLoader;
import supporting.io.GrumpyDataLoader;
import supporting.io.HappyDataLoader;
import supporting.values.URL_WELL_FORMED_DOCUMENT_XML;

public class LoadCompleteSystemErrorTest
{

    private var _game:Game;
    private var _classUnderTest:LoadCompleteSystem;
    private var _factory:WordEntityFactory;
    private var _onLoaded:WordDataSignal;
    private var _recieved:Array = [];


    [Before]
    public function before():void
    {
        _game = new Game();
        _onLoaded = new WordDataSignal();
        _classUnderTest = new LoadCompleteSystem( _onLoaded );
        _game.addSystem( _classUnderTest, 0 );
        _factory = new WordEntityFactory( _game );
    }

    [After]
    public function after():void
    {
        _game = null;
        _factory = null;
        _classUnderTest = null;
        _recieved = null;
    }


    [Test]
    public function onLoad_dispatched_on_error():void
    {
        const entity:Entity = createEntity( true, false );
        _onLoaded.addOnce( onLoaded );
        update();
        assertThat( _recieved.length, equalTo( 1 ) );
    }

    [Test]
    public function onLoad_dispatched_error_message():void
    {
        const entity:Entity = createEntity( true, false );
        _onLoaded.addOnce( onLoaded );
        update();
        assertThat( _recieved[0].data.message, equalTo( "AngryDataLoader" ) );
    }

    [Test]
    public function entity_removed_on_error():void
    {
        const entity:Entity = createEntity( true, false );
        _onLoaded.addOnce( onLoaded );
        update();
        assertThat( _game.entities.length, equalTo( 0 ) );
    }


    private function update():void
    {
        _game.update( 0 );
    }

    private function createEntity( isComplete:Boolean, success:Boolean = true ):Entity
    {
        const dataLoaderFactory:Function = function ( request:URLRequest ):DataLoader
        {
            if ( !success )
                return new AngryDataLoader( request );
            else if ( isComplete )
                return new HappyDataLoader( request );
            else
                return new GrumpyDataLoader( request );
        };

        return _factory.createWordFileEntity( URL_WELL_FORMED_DOCUMENT_XML, dataLoaderFactory );
    }

    private function onLoaded( wordData:DataLoaderVO ):void
    {
        _recieved.push( wordData )
    }


}
}
