package bigbird.factories
{
import bigbird.asserts.assertExpectedComponents;
import bigbird.components.KeyCell;
import bigbird.components.KeyValuePairInfo;
import bigbird.components.ValueCell;

import flash.events.Event;

import mockolate.nice;
import mockolate.prepare;
import mockolate.received;

import net.richardlord.ash.core.Entity;
import net.richardlord.ash.core.Game;

import org.flexunit.async.Async;
import org.hamcrest.assertThat;
import org.hamcrest.object.equalTo;
import org.hamcrest.object.instanceOf;
import org.hamcrest.object.strictlyEqualTo;

import supporting.values.KEY_CELL_XML;
import supporting.values.URL_WELL_FORMED_DOCUMENT_DOCX;
import supporting.values.URL_WELL_FORMED_DOCUMENT_XML;
import supporting.values.VALUE_CELL_XML;

public class KeyValuePairFSMTest
{
    private const defaultComponents:Array = [];

    private var _game:Game;
    private var classUnderTest:KeyValuePairFactory;

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
        _game = nice( Game );
        classUnderTest = new KeyValuePairFactory( _game );
    }

    [Test]
    public function createKeyValuePair_returns_instanceOf_Entity():void
    {
        assertThat( classUnderTest.createKeyValuePair( URL_WELL_FORMED_DOCUMENT_XML, KEY_CELL_XML, VALUE_CELL_XML ), instanceOf( Entity ) );
    }

    [Test]
    public function createKeyValuePair_adds_Entity_to_Game():void
    {
        const entity:Entity = classUnderTest.createKeyValuePair( URL_WELL_FORMED_DOCUMENT_XML, KEY_CELL_XML, VALUE_CELL_XML );
        assertThat( _game, received().method( "addEntity" ).arg( entity ).once() );
    }


    [Test]
    public function entity_contains_expected_components():void
    {
        const entity:Entity = classUnderTest.createKeyValuePair( URL_WELL_FORMED_DOCUMENT_XML, KEY_CELL_XML, VALUE_CELL_XML );
        const expectedComponents:Array = defaultComponents.concat( [ KeyValuePairInfo, KeyCell, ValueCell ] );
        assertExpectedComponents( expectedComponents, entity );
    }


    [Test]
    public function keycell_has_key_cell_data():void
    {
        const entity:Entity = classUnderTest.createKeyValuePair( URL_WELL_FORMED_DOCUMENT_XML, KEY_CELL_XML, VALUE_CELL_XML );
        const xml:XML = KeyCell( entity.get( KeyCell ) ).rawData;
        assertThat( xml, strictlyEqualTo( KEY_CELL_XML ) );
    }


    [Test]
    public function testKeyCellHas_VALUE_CELL_DATA():void
    {
        const entity:Entity = classUnderTest.createKeyValuePair( URL_WELL_FORMED_DOCUMENT_XML, KEY_CELL_XML, VALUE_CELL_XML );
        const xml:XML = ValueCell( entity.get( ValueCell ) ).rawData;
        assertThat( xml, strictlyEqualTo( VALUE_CELL_XML ) );
    }


    [Test]
    public function UID_increases_with_each_call_for_same_doc_name():void
    {
        var entity:Entity = classUnderTest.createKeyValuePair( URL_WELL_FORMED_DOCUMENT_XML, KEY_CELL_XML, VALUE_CELL_XML );
        var uid:int = KeyValuePairInfo( entity.get( KeyValuePairInfo ) ).index;
        assertThat( uid, equalTo( 0 ) );

        entity = classUnderTest.createKeyValuePair( URL_WELL_FORMED_DOCUMENT_XML, KEY_CELL_XML, VALUE_CELL_XML );
        uid = KeyValuePairInfo( entity.get( KeyValuePairInfo ) ).index;
        assertThat( uid, equalTo( 1 ) );

        entity = classUnderTest.createKeyValuePair( URL_WELL_FORMED_DOCUMENT_XML, KEY_CELL_XML, VALUE_CELL_XML );
        uid = KeyValuePairInfo( entity.get( KeyValuePairInfo ) ).index;
        assertThat( uid, equalTo( 2 ) );
    }


    [Test]
    public function UID_increases_per_doc_name():void
    {
        var entity:Entity = classUnderTest.createKeyValuePair( URL_WELL_FORMED_DOCUMENT_DOCX, KEY_CELL_XML, VALUE_CELL_XML );
        var uid:int = KeyValuePairInfo( entity.get( KeyValuePairInfo ) ).index;
        assertThat( "URL_WELL_FORMED_DOCUMENT_DOCX - first call", uid, equalTo( 0 ) );

        entity = classUnderTest.createKeyValuePair( URL_WELL_FORMED_DOCUMENT_XML, KEY_CELL_XML, VALUE_CELL_XML );
        uid = KeyValuePairInfo( entity.get( KeyValuePairInfo ) ).index;
        assertThat( "URL_WELL_FORMED_DOCUMENT_XML - first call", uid, equalTo( 0 ) );

        entity = classUnderTest.createKeyValuePair( URL_WELL_FORMED_DOCUMENT_DOCX, KEY_CELL_XML, VALUE_CELL_XML );
        uid = KeyValuePairInfo( entity.get( KeyValuePairInfo ) ).index;
        assertThat( "URL_WELL_FORMED_DOCUMENT_DOCX - second call", uid, equalTo( 1 ) );

        entity = classUnderTest.createKeyValuePair( URL_WELL_FORMED_DOCUMENT_XML, KEY_CELL_XML, VALUE_CELL_XML );
        uid = KeyValuePairInfo( entity.get( KeyValuePairInfo ) ).index;
        assertThat( "URL_WELL_FORMED_DOCUMENT_XML - second call", uid, equalTo( 1 ) );

    }


}
}
