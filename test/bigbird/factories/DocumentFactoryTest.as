package bigbird.factories
{
import bigbird.components.*;

import flash.net.URLRequest;

import net.richardlord.ash.core.Entity;

import org.hamcrest.assertThat;
import org.hamcrest.object.equalTo;
import org.hamcrest.object.instanceOf;
import org.hamcrest.object.strictlyEqualTo;

import supporting.MockGame;
import supporting.values.DOCUMENT_SINGLE_KEY_VALUE_PAIR_XML;
import supporting.values.DOCUMENT_URL;

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
        assertThat( _classUnderTest.createDocument( DOCUMENT_URL ), instanceOf( Entity ) );
    }

    [Test]
    public function createDocument_adds_Entity_to_Game():void
    {
        _classUnderTest.createDocument( DOCUMENT_URL );
        assertThat( _game.entitiesReceived.length, equalTo( 1 ) );
    }

    [Test]
    public function createDocument_returns_Entity_containing_instanceOf_Progress():void
    {
        const entity:Entity = _classUnderTest.createDocument( DOCUMENT_URL );
        assertThat( entity.get( Progress ), instanceOf( Progress ) );
    }

    [Test]
    public function createDocument_returns_Entity_containing_instanceOf_URLRequest():void
    {
        const entity:Entity = _classUnderTest.createDocument( DOCUMENT_URL );
        assertThat( entity.get( URLRequest ), instanceOf( URLRequest ) );
    }

    [Test]
    public function createDocument_returns_Entity_were_URL_has_value_set():void
    {
        const entity:Entity = _classUnderTest.createDocument( DOCUMENT_URL );
        assertThat( entity.get( URLRequest ), strictlyEqualTo( DOCUMENT_URL ) );
    }

    [Test]
    public function createDocument_returns_Entity_containing_instanceOf_DocumentAccess():void
    {
        const entity:Entity = _classUnderTest.createDocument( DOCUMENT_URL );
        assertThat( entity.get( DocumentAccess ), instanceOf( DocumentAccess ) );
    }

    [Test]
    public function createDocument_adds_Entity_to_DocumentAccess():void
    {
        const entity:Entity = _classUnderTest.createDocument( DOCUMENT_URL );
        const access:DocumentAccess = entity.get( DocumentAccess );
        access.addRawData( DOCUMENT_SINGLE_KEY_VALUE_PAIR_XML );
        assertThat( entity.get( RawWordDocument ), instanceOf( RawWordDocument ) );
    }


}
}
