package bigbird.systems
{
import bigbird.asserts.assertKeyValuePairs;
import bigbird.components.WordData;
import bigbird.factories.KeyValuePairFactory;

import net.richardlord.ash.core.Game;

import org.hamcrest.assertThat;
import org.hamcrest.object.equalTo;
import org.hamcrest.object.isTrue;

import supporting.values.*;

public class DecodeFromWordFileTest
{
    private var _document:WordData;
    private var _game:Game;
    private var _classUnderTest:DecodeFromWordFile;

    [Before]
    public function before():void
    {
        _game = new Game();

        _classUnderTest = new DecodeFromWordFile( new KeyValuePairFactory( _game ) );
    }

    public function prepareDocument( documentData:XML = null ):void
    {
        _document = new WordData( documentData || DOCUMENT_SINGLE_KEY_VALUE_PAIR_XML );
    }

    [After]
    public function after():void
    {
        _document = null;
        _classUnderTest = null;
    }

    [Test]
    public function game_by_default_received_zero_entities():void
    {
        assertThat( _game.entities.length, equalTo( 0 ) );
    }

    [Test]
    public function only_one_entity_created():void
    {
        prepareDocument();
        _classUnderTest.decode( _document )
        assertThat( _game.entities.length, equalTo( 1 ) );
    }

    [Test]
    public function valid_key_value_data_decoded_correctly():void
    {
        prepareDocument();
        const expected:Array = [
            "[KeyCell(colour:0x92D050,label:Activity Type)]",
            "[ValueCell(content:QAA)]"
        ];

        _classUnderTest.decode( _document );
        assertKeyValuePairs( _game.entities, expected );
    }

    [Test]
    public function null_key_null_value_no_Entity_added():void
    {
        prepareDocument( DOCUMENT_NO_CELLS_XML )
        const expected:Array = [ ];

        _classUnderTest.decode( _document );
        assertKeyValuePairs( _game.entities, expected );
    }

    [Test]
    public function orphan_key_gets_missing_value_cell_added():void
    {
        prepareDocument( DOCUMENT_ORPHAN_KEY_XML )
        const expected:Array = [
            "[KeyCell(colour:0x92D050,label:Activity Type)]",
            "[ValueCell(content:*MISSING*)]"
        ];

        _classUnderTest.decode( _document );
        assertKeyValuePairs( _game.entities, expected );
    }


    [Test]
    public function orphan_value_gets_missing_value_cell_added():void
    {
        prepareDocument( DOCUMENT_ORPHAN_VALUE_XML );
        const expected:Array = [
            "[KeyCell(colour:0xFF0000,label:*MISSING*)]",
            "[ValueCell(content:QAA)]"
        ];

        _classUnderTest.decode( _document );
        assertKeyValuePairs( _game.entities, expected );
    }

    [Test]
    public function value_key_reverse_pair_missing_key_added():void
    {
        prepareDocument( DOCUMENT_VALUE_KEY_REVERSE_PAIR_XML );
        const expected:Array = [
            "[KeyCell(colour:0xFF0000,label:*MISSING*)]",
            "[ValueCell(content:QAA)]"
        ];

        _classUnderTest.decode( _document );
        assertKeyValuePairs( _game.entities, expected );
    }

    [Test]
    public function value_key_reverse_pair_stepped_back():void
    {
        prepareDocument( DOCUMENT_VALUE_KEY_REVERSE_PAIR_XML );
        _classUnderTest.decode( _document );
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

        _classUnderTest.decode( _document );
        assertKeyValuePairs( _game.entities, expected );
    }

    [Test]
    public function key_key_duplication_stepped_back():void
    {
        prepareDocument( DOCUMENT_KEY_KEY_DUPLICATION_XML );
        _classUnderTest.decode( _document );
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

        _classUnderTest.decode( _document );
        assertKeyValuePairs( _game.entities, expected );
    }

    [Test]
    public function value_value_duplication_stepped_back():void
    {
        prepareDocument( DOCUMENT_VALUE_VALUE_DUPLICATION_XML );
        _classUnderTest.decode( _document );
        assertThat( _document.hasNext, isTrue() );
    }


}
}
