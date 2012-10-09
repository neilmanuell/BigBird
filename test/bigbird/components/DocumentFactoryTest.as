package bigbird.components
{
import flash.events.Event;

import mockolate.nice;
import mockolate.prepare;

import net.richardlord.ash.core.Entity;
import net.richardlord.ash.core.Game;

import org.flexunit.async.Async;
import org.hamcrest.assertThat;
import org.hamcrest.object.equalTo;
import org.hamcrest.object.instanceOf;

import supporting.values.DOCUMENT_NAME;
import supporting.values.DOCUMENT_SINGLE_KEY_VALUE_PAIR_XML;

use namespace DOCUMENT_NAME;

public class DocumentFactoryTest
{
    // todo:unfinished
    private var game:Game;

    [Before(order=1, async, timeout=5000)]
    public function prepareMockolates():void
    {
        Async.proceedOnEvent( this,
                prepare( Game ),
                Event.COMPLETE );
    }

    [Before(order=2)]
    public function before():void
    {
        game = nice( Game );

    }

    [After]
    public function after():void
    {
        game = null;
        //classUnderTest = null;
    }

    [Test]
    public function testReturnsInstanceOfEntity():void
    {
        assertThat( createDocument( DOCUMENT_NAME, DOCUMENT_SINGLE_KEY_VALUE_PAIR_XML ), instanceOf( Entity ) );
    }

    [Test]
    public function testReturnsEntityWithRawDocumentInstance():void
    {
        const entity:Entity = createDocument( DOCUMENT_NAME, DOCUMENT_SINGLE_KEY_VALUE_PAIR_XML );
        assertThat( entity.get( RawWordDocument ), instanceOf( RawWordDocument ) );
    }

    [Test]
    public function testReturnsRawDocumentWithGivenName():void
    {
        const entity:Entity = createDocument( DOCUMENT_NAME, DOCUMENT_SINGLE_KEY_VALUE_PAIR_XML );
        assertThat( entity.get( RawWordDocument ).name, equalTo( DOCUMENT_NAME ) );
    }

    [Test]
    public function testReturnsRawDocumentWithGivenRawData():void
    {
        const entity:Entity = createDocument( DOCUMENT_NAME, DOCUMENT_SINGLE_KEY_VALUE_PAIR_XML );
        assertThat( entity.get( RawWordDocument ).rawData, equalTo( DOCUMENT_SINGLE_KEY_VALUE_PAIR_XML ) );
    }

    [Test]
    public function testReturnsEntityWithProgressInstance():void
    {
        const entity:Entity = createDocument( DOCUMENT_NAME, DOCUMENT_SINGLE_KEY_VALUE_PAIR_XML );
        assertThat( entity.get( Progress ), instanceOf( Progress ) );
    }

    [Test]
    public function totalWork_set_onProgress():void
    {
        const entity:Entity = createDocument( DOCUMENT_NAME, DOCUMENT_SINGLE_KEY_VALUE_PAIR_XML );
        const progress:Progress = entity.get( Progress );
        assertThat( progress.totalWork, equalTo( 2 ) );
    }


    private function createDocument( name:String, rawData:XML ):Entity
    {
        const entity:Entity = new Entity();
        const document:RawWordDocument = new RawWordDocument( name, rawData )
        const progress:Progress = new Progress( document.length );
        entity.add( document );
        entity.add( progress );
        return entity;
    }


}
}
