package bigbird.factories
{
import bigbird.components.*;

import net.richardlord.ash.core.Entity;

import org.hamcrest.assertThat;
import org.hamcrest.object.equalTo;
import org.hamcrest.object.instanceOf;

import supporting.MockGame;
import supporting.values.DOCUMENT_NAME;
import supporting.values.DOCUMENT_SINGLE_KEY_VALUE_PAIR_XML;

public class DocumentFactoryTest
{
    private var _game:MockGame;
    private var _classUnderTest:EntityFactory;

    [Before]
    public function before():void
    {
        _game = new MockGame();
        _classUnderTest = new EntityFactory( _game );
    }

    [After]
    public function after():void
    {
        _game = null;
        _classUnderTest = null;
    }

    [Test]
    public function createDocument_returns_instanceOf_Entity():void
    {
        assertThat( _classUnderTest.createDocument( DOCUMENT_NAME, DOCUMENT_SINGLE_KEY_VALUE_PAIR_XML ), instanceOf( Entity ) );
    }

    [Test]
    public function createDocument_adds_Entity_to_Game():void
    {
        const entity:Entity = _classUnderTest.createDocument( DOCUMENT_NAME, DOCUMENT_SINGLE_KEY_VALUE_PAIR_XML );
        assertThat( _game.entitiesReceived.length, equalTo( 1 ) );
    }

    [Test]
    public function createDocument_returns_Entity_containing_RawWordDocument():void
    {
        const entity:Entity = _classUnderTest.createDocument( DOCUMENT_NAME, DOCUMENT_SINGLE_KEY_VALUE_PAIR_XML );
        assertThat( entity.get( RawWordDocument ), instanceOf( RawWordDocument ) );
    }

    [Test]
    public function returns_RawWordDocument_with_given_name():void
    {
        const entity:Entity = _classUnderTest.createDocument( DOCUMENT_NAME, DOCUMENT_SINGLE_KEY_VALUE_PAIR_XML );
        assertThat( entity.get( RawWordDocument ).name, equalTo( DOCUMENT_NAME ) );
    }

    [Test]
    public function returns_RawWordDocument_with_given_rawData():void
    {
        const entity:Entity = _classUnderTest.createDocument( DOCUMENT_NAME, DOCUMENT_SINGLE_KEY_VALUE_PAIR_XML );
        assertThat( entity.get( RawWordDocument ).rawData, equalTo( DOCUMENT_SINGLE_KEY_VALUE_PAIR_XML ) );
    }

    [Test]
    public function createDocument_returns_Entity_containing_instanceOf_Progress():void
    {
        const entity:Entity = _classUnderTest.createDocument( DOCUMENT_NAME, DOCUMENT_SINGLE_KEY_VALUE_PAIR_XML );
        assertThat( entity.get( Progress ), instanceOf( Progress ) );
    }

    [Test]
    public function totalWork_set_onProgress():void
    {
        const entity:Entity = _classUnderTest.createDocument( DOCUMENT_NAME, DOCUMENT_SINGLE_KEY_VALUE_PAIR_XML );
        const progress:Progress = entity.get( Progress );
        assertThat( progress.totalWork, equalTo( 2 ) );
    }


}
}
