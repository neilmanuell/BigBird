package bigbird.systems.decode
{
import bigbird.asserts.assertKeyValuePairs;
import bigbird.components.WordData;
import bigbird.controller.EntityFSMController;
import bigbird.factories.KeyValuePairFactory;

import flash.events.Event;

import mockolate.nice;
import mockolate.prepare;
import mockolate.received;

import net.richardlord.ash.core.Entity;
import net.richardlord.ash.core.Game;

import org.flexunit.async.Async;
import org.hamcrest.assertThat;
import org.hamcrest.object.isTrue;

import supporting.values.requests.URL_WELL_FORMED_DOCUMENT_DOCX;
import supporting.values.xml.DOCUMENT_KEY_KEY_DUPLICATION_XML;
import supporting.values.xml.DOCUMENT_NO_CELLS_XML;
import supporting.values.xml.DOCUMENT_ORPHAN_KEY_XML;
import supporting.values.xml.DOCUMENT_ORPHAN_VALUE_XML;
import supporting.values.xml.DOCUMENT_SINGLE_KEY_VALUE_PAIR_XML;
import supporting.values.xml.DOCUMENT_VALUE_KEY_REVERSE_PAIR_XML;
import supporting.values.xml.DOCUMENT_VALUE_VALUE_DUPLICATION_XML;

public class DecodeFromWordFileTest
{
    private var _document:WordData;
    private var _classUnderTest:DecodeFromWordFile;
    private var _factory:KeyValuePairFactory;
    private var _entityFSMController:EntityFSMController;
    private var _game:Game;


    [Before(order=1, async, timeout=5000)]
    public function prepareMockolates():void
    {
        Async.proceedOnEvent( this,
                prepare( Game, EntityFSMController, KeyValuePairFactory ),
                Event.COMPLETE );
    }

    [Before(order=2)]
    public function before():void
    {
        _game = nice( Game );
        _factory = new KeyValuePairFactory( _game );
        _entityFSMController = nice( EntityFSMController );
        _classUnderTest = new DecodeFromWordFile( _factory, _entityFSMController );
    }

    public function prepareDocument( documentData:XML = null ):void
    {
        _document = new WordData( documentData || DOCUMENT_SINGLE_KEY_VALUE_PAIR_XML );
    }

    [Test]
    public function only_one_entity_created():void
    {
        prepareDocument();
        const entity:Entity = _classUnderTest.decode( URL_WELL_FORMED_DOCUMENT_DOCX, _document )
        assertThat( _game, received().method( "addEntity" ).arg( entity ).once() );
    }

    [Test]
    public function valid_key_value_data_decoded_correctly():void
    {
        prepareDocument();
        const expected:Array = [
            "[KeyCell(colour:0x92D050,label:Activity Type)]",
            "[ValueCell(content:QAA)]"
        ];

        const entity:Entity = _classUnderTest.decode( URL_WELL_FORMED_DOCUMENT_DOCX, _document );
        assertKeyValuePairs( entity, expected );
    }

    [Test]
    public function null_key_null_value_no_Entity_added():void
    {
        prepareDocument( DOCUMENT_NO_CELLS_XML );

        _classUnderTest.decode( URL_WELL_FORMED_DOCUMENT_DOCX, _document );
        assertThat( _game, received().method( "addEntity" ).never() );
    }

    [Test]
    public function orphan_key_gets_missing_value_cell_added():void
    {
        prepareDocument( DOCUMENT_ORPHAN_KEY_XML )
        const expected:Array = [
            "[KeyCell(colour:0x92D050,label:Activity Type)]",
            "[ValueCell(content:*MISSING*)]"
        ];

        const entity:Entity = _classUnderTest.decode( URL_WELL_FORMED_DOCUMENT_DOCX, _document );
        assertKeyValuePairs( entity, expected );
    }

    [Test]
    public function orphan_value_gets_missing_value_cell_added():void
    {
        prepareDocument( DOCUMENT_ORPHAN_VALUE_XML );
        const expected:Array = [
            "[KeyCell(colour:0xFF0000,label:*MISSING*)]",
            "[ValueCell(content:QAA)]"
        ];

        const entity:Entity = _classUnderTest.decode( URL_WELL_FORMED_DOCUMENT_DOCX, _document );
        assertKeyValuePairs( entity, expected );
    }

    [Test]
    public function value_key_reverse_pair_missing_key_added():void
    {
        prepareDocument( DOCUMENT_VALUE_KEY_REVERSE_PAIR_XML );
        const expected:Array = [
            "[KeyCell(colour:0xFF0000,label:*MISSING*)]",
            "[ValueCell(content:QAA)]"
        ];

        const entity:Entity = _classUnderTest.decode( URL_WELL_FORMED_DOCUMENT_DOCX, _document );
        assertKeyValuePairs( entity, expected );
    }

    [Test]
    public function value_key_reverse_pair_stepped_back():void
    {
        prepareDocument( DOCUMENT_VALUE_KEY_REVERSE_PAIR_XML );
        _classUnderTest.decode( URL_WELL_FORMED_DOCUMENT_DOCX, _document );
        assertThat( _document.hasNext, isTrue() );
    }


    [Test]
    public function key_key_duplication_missing_value_added():void
    {
        prepareDocument( DOCUMENT_KEY_KEY_DUPLICATION_XML );
        const expected:Array = [
            "[KeyCell(colour:0x92D050,label:Activity)]",
            "[ValueCell(content:*MISSING*)]"
        ];

        const entity:Entity = _classUnderTest.decode( URL_WELL_FORMED_DOCUMENT_DOCX, _document );
        assertKeyValuePairs( entity, expected );
    }


    [Test]
    public function key_key_duplication_stepped_back():void
    {
        prepareDocument( DOCUMENT_KEY_KEY_DUPLICATION_XML );
        _classUnderTest.decode( URL_WELL_FORMED_DOCUMENT_DOCX, _document );
        assertThat( _document.hasNext, isTrue() );
    }


    [Test]
    public function value_value_duplication_missing_key_added():void
    {
        prepareDocument( DOCUMENT_VALUE_VALUE_DUPLICATION_XML );
        const expected:Array = [
            "[KeyCell(colour:0xFF0000,label:*MISSING*)]",
            "[ValueCell(content:MCQ)]"
        ];

        const entity:Entity = _classUnderTest.decode( URL_WELL_FORMED_DOCUMENT_DOCX, _document );
        assertKeyValuePairs( entity, expected );
    }


    [Test]
    public function value_value_duplication_stepped_back():void
    {
        prepareDocument( DOCUMENT_VALUE_VALUE_DUPLICATION_XML );
        _classUnderTest.decode( URL_WELL_FORMED_DOCUMENT_DOCX, _document );
        assertThat( _document.hasNext, isTrue() );
    }

}
}
