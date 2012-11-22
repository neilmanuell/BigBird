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
import org.hamcrest.core.not;
import org.hamcrest.object.equalTo;

import supporting.io.AngryDataLoader;
import supporting.io.GrumpyDataLoader;
import supporting.io.HappyDataLoader;
import supporting.values.DOCUMENT_SINGLE_KEY_VALUE_PAIR_XML;
import supporting.values.URL_WELL_FORMED_DOCUMENT_XML;

public class LoadCompleteSystemDispatchTest
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
    public function onLoad_dispatched_on_complete():void
    {
        _onLoaded.addOnce( onLoaded );
        update();
        assertThat( _recieved.length, equalTo( 1 ) );
    }

    [Test]
    public function onLoad_url_dispatched_on_complete():void
    {
        _onLoaded.addOnce( onLoaded );
        update();
        assertThat( _recieved[0].url, equalTo( URL_WELL_FORMED_DOCUMENT_XML.url ) );
    }

    [Test]
    public function onLoad_data_dispatched_on_complete():void
    {
        _onLoaded.addOnce( onLoaded );
        update();
        assertThat( _recieved[0].data.toString() ), equalTo( DOCUMENT_SINGLE_KEY_VALUE_PAIR_XML.toString() );
    }

    [Test]
    public function onLoad_data_is_copy():void
    {
        _onLoaded.addOnce( onLoaded );
        update();
        assertThat( _recieved[0].data ), not( DOCUMENT_SINGLE_KEY_VALUE_PAIR_XML );
    }


    private function update():void
    {
        _game.update( 0 );
    }

    private function createEntity( isComplete:Boolean, success:Boolean = true ):Entity
    {
        const dataLoaderFactory:Function = function ( request:URLRequest ):DataLoader
        {
            if ( success )
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
