package bigbird.factories
{
import bigbird.asserts.assertExpectedComponents;
import bigbird.components.KeyCell;
import bigbird.components.KeyValuePairIndex;
import bigbird.components.ValueCell;
import bigbird.controller.EntityStateNames;

import flash.net.URLRequest;

import net.richardlord.ash.core.Entity;
import net.richardlord.ash.core.Game;
import net.richardlord.ash.fsm.EntityStateMachine;

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
    private const defaultComponents:Array = [EntityStateMachine];

    private var game:Game;
    private var classUnderTest:KeyValuePairFactory;

    [Before]
    public function before():void
    {
        game = new Game();
        classUnderTest = new KeyValuePairFactory( game );
    }

    [After]
    public function after():void
    {
        game = null;
        classUnderTest = null;
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
        assertThat( game.entities.length, equalTo( 1 ) )
    }

    [Test]
    public function createKeyValuePair_returns_Entity_containing_instanceOf_EntityStateMachine():void
    {
        const entity:Entity = classUnderTest.createKeyValuePair( URL_WELL_FORMED_DOCUMENT_XML, KEY_CELL_XML, VALUE_CELL_XML );
        assertThat( entity.get( EntityStateMachine ), instanceOf( EntityStateMachine ) );
    }

    [Test]
    public function preDispatch_state_is_default():void
    {
        const entity:Entity = classUnderTest.createKeyValuePair( URL_WELL_FORMED_DOCUMENT_XML, KEY_CELL_XML, VALUE_CELL_XML );
        const expectedComponents:Array = defaultComponents.concat( [ KeyCell, ValueCell, KeyValuePairIndex, URLRequest] );
        assertExpectedComponents( expectedComponents, entity );
    }

    [Test]
    public function postDispatch_state():void
    {
        const entity:Entity = classUnderTest.createKeyValuePair( URL_WELL_FORMED_DOCUMENT_XML, KEY_CELL_XML, VALUE_CELL_XML );
        const expectedComponents:Array = defaultComponents.concat( [ KeyCell, ValueCell, KeyValuePairIndex] );
        changeState( EntityStateNames.POST_DISPATCH, entity );
        assertExpectedComponents( expectedComponents, entity );
    }

    private function changeState( name:String, entity:Entity ):void
    {
        const fsm:EntityStateMachine = entity.get( EntityStateMachine );
        fsm.changeState( name );
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
        var uid:int = KeyValuePairIndex( entity.get( KeyValuePairIndex ) ).index;
        assertThat( uid, equalTo( 0 ) );

        entity = classUnderTest.createKeyValuePair( URL_WELL_FORMED_DOCUMENT_XML, KEY_CELL_XML, VALUE_CELL_XML );
        uid = KeyValuePairIndex( entity.get( KeyValuePairIndex ) ).index;
        assertThat( uid, equalTo( 1 ) );

        entity = classUnderTest.createKeyValuePair( URL_WELL_FORMED_DOCUMENT_XML, KEY_CELL_XML, VALUE_CELL_XML );
        uid = KeyValuePairIndex( entity.get( KeyValuePairIndex ) ).index;
        assertThat( uid, equalTo( 2 ) );
    }


    [Test]
    public function UID_increases_per_doc_name():void
    {
        var entity:Entity = classUnderTest.createKeyValuePair( URL_WELL_FORMED_DOCUMENT_DOCX, KEY_CELL_XML, VALUE_CELL_XML );
        var uid:int = KeyValuePairIndex( entity.get( KeyValuePairIndex ) ).index;
        assertThat( "URL_WELL_FORMED_DOCUMENT_DOCX - first call", uid, equalTo( 0 ) );

        entity = classUnderTest.createKeyValuePair( URL_WELL_FORMED_DOCUMENT_XML, KEY_CELL_XML, VALUE_CELL_XML );
        uid = KeyValuePairIndex( entity.get( KeyValuePairIndex ) ).index;
        assertThat( "URL_WELL_FORMED_DOCUMENT_XML - first call", uid, equalTo( 0 ) );

        entity = classUnderTest.createKeyValuePair( URL_WELL_FORMED_DOCUMENT_DOCX, KEY_CELL_XML, VALUE_CELL_XML );
        uid = KeyValuePairIndex( entity.get( KeyValuePairIndex ) ).index;
        assertThat( "URL_WELL_FORMED_DOCUMENT_DOCX - second call", uid, equalTo( 1 ) );

        entity = classUnderTest.createKeyValuePair( URL_WELL_FORMED_DOCUMENT_XML, KEY_CELL_XML, VALUE_CELL_XML );
        uid = KeyValuePairIndex( entity.get( KeyValuePairIndex ) ).index;
        assertThat( "URL_WELL_FORMED_DOCUMENT_XML - second call", uid, equalTo( 1 ) );

    }


}
}
