package bigbird.systems
{
import bigbird.asserts.assertKeyValuePairs;
import bigbird.components.RawWordDocument;

import org.hamcrest.assertThat;
import org.hamcrest.object.equalTo;
import org.hamcrest.object.isTrue;

import supporting.MockGame;
import supporting.values.*;

public class DecodeFromRawDocumentTest
{
    private var _document:RawWordDocument;
    private var _mockGame:MockGame;
    private var _classUnderTest:DecodeFromRawDocument;

    [Before]
    public function before():void
    {
        _mockGame = new MockGame();

        _classUnderTest = new DecodeFromRawDocument( _mockGame );
    }

    public function prepareDocument( documentData:XML = null ):void
    {
        _document = new RawWordDocument( documentData || DOCUMENT_SINGLE_KEY_VALUE_PAIR_XML );
    }

    [After]
    public function after():void
    {
        _document = null;
        _classUnderTest = null;
    }

    [Test]
    public function mockGameByDefaultReceivedZEROEntities():void
    {
        assertThat( _mockGame.entitiesReceived.length, equalTo( 0 ) );
    }

    [Test]
    public function testOnlyOneEntityCreated():void
    {
        prepareDocument();
        _classUnderTest.decode( _document )
        assertThat( _mockGame.entitiesReceived.length, equalTo( 1 ) );
    }

    [Test]
    public function testValidKeyValueDataDecodedCorrectly():void
    {
        prepareDocument();
        const expected:Array = [
            "[KeyCell(colour:0x92D050,label:Activity Type)]",
            "[ValueCell(content:QAA)]"
        ];

        _classUnderTest.decode( _document );
        assertKeyValuePairs( _mockGame.entitiesReceived, expected );
    }

    [Test]
    public function testNullNullPassedAborts():void
    {
        prepareDocument( DOCUMENT_NO_CELLS_XML )
        const expected:Array = [ ];

        _classUnderTest.decode( _document );
        assertKeyValuePairs( _mockGame.entitiesReceived, expected );
    }

    [Test]
    public function testOrphanKeyGetsMissingValueCellAdded():void
    {
        prepareDocument( DOCUMENT_ORPHAN_KEY_XML )
        const expected:Array = [
            "[KeyCell(colour:0x92D050,label:Activity Type)]",
            "[ValueCell(content:*MISSING*)]"
        ];

        _classUnderTest.decode( _document );
        assertKeyValuePairs( _mockGame.entitiesReceived, expected );
    }


    [Test]
    public function testOrphanValueGetsMissingValueCellAdded():void
    {
        prepareDocument( DOCUMENT_ORPHAN_VALUE_XML );
        const expected:Array = [
            "[KeyCell(colour:0xFF0000,label:*MISSING*)]",
            "[ValueCell(content:QAA)]"
        ];

        _classUnderTest.decode( _document );
        assertKeyValuePairs( _mockGame.entitiesReceived, expected );
    }

    [Test]
    public function testValueKeyReversePairMissingKeyAdded():void
    {
        prepareDocument( DOCUMENT_VALUE_KEY_REVERSE_PAIR_XML );
        const expected:Array = [
            "[KeyCell(colour:0xFF0000,label:*MISSING*)]",
            "[ValueCell(content:QAA)]"
        ];

        _classUnderTest.decode( _document );
        assertKeyValuePairs( _mockGame.entitiesReceived, expected );
    }

    [Test]
    public function testValueKeyReversePairSteppedBack():void
    {
        prepareDocument( DOCUMENT_VALUE_KEY_REVERSE_PAIR_XML );
        _classUnderTest.decode( _document );
        assertThat( _document.hasNext, isTrue() );
    }

    [Test]
    public function testKeyKeyDuplicationMissingValueAdded():void
    {
        prepareDocument( DOCUMENT_KEY_KEY_DUPLICATION_XML );
        const expected:Array = [
            "[KeyCell(colour:0x92D050,label:Activity)]",
            "[ValueCell(content:*MISSING*)]"
        ];

        _classUnderTest.decode( _document );
        assertKeyValuePairs( _mockGame.entitiesReceived, expected );
    }

    [Test]
    public function testKeyKeyDuplicationSteppedBack():void
    {
        prepareDocument( DOCUMENT_KEY_KEY_DUPLICATION_XML );
        _classUnderTest.decode( _document );
        assertThat( _document.hasNext, isTrue() );
    }

    [Test]
    public function testValueValueDuplicationMissingKeyAdded():void
    {
        prepareDocument( DOCUMENT_VALUE_VALUE_DUPLICATION_XML );
        const expected:Array = [
            "[KeyCell(colour:0xFF0000,label:*MISSING*)]",
            "[ValueCell(content:MCQ)]"
        ];

        _classUnderTest.decode( _document );
        assertKeyValuePairs( _mockGame.entitiesReceived, expected );
    }

    [Test]
    public function testValueValueDuplicationSteppedBack():void
    {
        prepareDocument( DOCUMENT_VALUE_VALUE_DUPLICATION_XML );
        _classUnderTest.decode( _document );
        assertThat( _document.hasNext, isTrue() );
    }


}
}
