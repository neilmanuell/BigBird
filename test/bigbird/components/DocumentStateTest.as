package bigbird.components
{
import bigbird.io.Loader;

import flash.events.Event;

import mockolate.nice;

import mockolate.prepare;
import mockolate.received;
import mockolate.stub;

import net.richardlord.ash.core.Entity;

import org.flexunit.async.Async;

import org.hamcrest.assertThat;
import org.hamcrest.object.equalTo;
import org.hamcrest.object.instanceOf;
import org.hamcrest.object.nullValue;
import org.hamcrest.text.re;

import supporting.values.DOCUMENT_SINGLE_KEY_VALUE_PAIR_XML;
import supporting.values.DOCUMENT_URL;

public class DocumentStateTest
{
    private var _entity:Entity;
    private var _classUnderTest:DocumentState;

    [Before(order=1, async, timeout=5000)]
    public function prepareMockolates():void
    {
        Async.proceedOnEvent( this,
                prepare(Loader),
                Event.COMPLETE );
    }

    [Before(order=2)]
    public function setUp():void
    {
        _entity = new Entity();
        _classUnderTest = new DocumentState( _entity );
    }

    [After]
    public function tearDown():void
    {
        _classUnderTest = null;
        _entity = null;
    }

    [Test]
    public function addRawData_returns_Entity_containing_RawWordDocument():void
    {
        _classUnderTest.addRawData( DOCUMENT_SINGLE_KEY_VALUE_PAIR_XML );
        assertThat( _entity.get( RawWordDocument ), instanceOf( RawWordDocument ) );
    }


    [Test]
    public function returns_RawWordDocument_with_given_rawData():void
    {
        _classUnderTest.addRawData( DOCUMENT_SINGLE_KEY_VALUE_PAIR_XML );
        assertThat( _entity.get( RawWordDocument ).rawData, equalTo( DOCUMENT_SINGLE_KEY_VALUE_PAIR_XML ) );
    }

    [Test]
    public function addURL_returns_Entity_containing_DocumentLoader():void
    {
        _classUnderTest.addURL( DOCUMENT_URL );
        assertThat( _entity.get( DocumentLoader ), instanceOf( DocumentLoader ) );
    }

    [Test]
    public function addRawData_applies_data_To_RawWordDocument():void
    {
        _classUnderTest.addRawData( DOCUMENT_SINGLE_KEY_VALUE_PAIR_XML );
        assertThat( _entity.get( RawWordDocument ).rawData, equalTo( DOCUMENT_SINGLE_KEY_VALUE_PAIR_XML ) );
    }

    [Test]
    public function enterDecodingState_removes_DocumentLoader():void
    {
        addStubbedLoader();
        _classUnderTest.enterDecodingState();

        assertThat( _entity.get( DocumentLoader ), nullValue() );
    }

    [Test]
    public function enterDecodingState_retrieves_data_from_loader():void
    {
        var loader:Loader = addStubbedLoader();
        _classUnderTest.enterDecodingState();

        assertThat( loader, received().getter("data" ).once() );
    }

    [Test]
    public function enterDecodingState_applies_data_To_RawWordDocument():void
    {
        addStubbedLoader(DOCUMENT_SINGLE_KEY_VALUE_PAIR_XML);
        _classUnderTest.enterDecodingState(  );
        assertThat( _entity.get( RawWordDocument ).rawData, equalTo( DOCUMENT_SINGLE_KEY_VALUE_PAIR_XML ) );
    }

    private function addStubbedLoader(data:XML = null):Loader
    {
        const loader:Loader = nice( Loader );
        stub(loader ).getter("data" ).returns(data)
        _entity.add( new DocumentLoader( loader ) );
        return loader;
    }
}

}

