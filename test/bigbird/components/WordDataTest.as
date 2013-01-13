package bigbird.components {
import org.hamcrest.assertThat;
import org.hamcrest.core.not;
import org.hamcrest.object.equalTo;
import org.hamcrest.object.instanceOf;
import org.hamcrest.object.isFalse;
import org.hamcrest.object.isTrue;
import org.hamcrest.object.strictlyEqualTo;

import supporting.values.xml.DOCUMENT_SINGLE_KEY_VALUE_PAIR_XML;

public class WordDataTest {
    private var _classUnderTest:WordData;

    [Before]
    public function setUp():void {
        _classUnderTest = new WordData(DOCUMENT_SINGLE_KEY_VALUE_PAIR_XML);
    }

    [After]
    public function tearDown():void {
        _classUnderTest = null;
    }

    [Test]
    public function raw_data_set_from_constructor():void {
        assertThat(_classUnderTest.rawData, strictlyEqualTo(DOCUMENT_SINGLE_KEY_VALUE_PAIR_XML));
    }

    [Test]
    public function testGetNextReturnsInstanceOfXML():void {
        assertThat(_classUnderTest.getNext(), instanceOf(XML));
    }

    [Test]
    public function testGetNextReturns_wtc_node():void {
        const node:XML = _classUnderTest.getNext();
        assertThat(node.localName(), equalTo("tc"));
    }

    [Test]
    public function testGetNextReturnsDifferentCellNodes():void {
        const nodeOne:String = _classUnderTest.getNext().toString();
        const nodeTwo:String = _classUnderTest.getNext().toString();
        assertThat(nodeOne, not(nodeTwo));
    }

    [Test]
    public function testStepBack():void {
        const nodeOne:String = _classUnderTest.getNext().toString();
        _classUnderTest.stepback();
        const nodeTwo:String = _classUnderTest.getNext().toString();
        assertThat(nodeOne, equalTo(nodeTwo));
    }

    [Test]
    public function testHasNextReturnsTrueByDefault():void {
        assertThat(_classUnderTest.hasNext, isTrue());
    }

    [Test]
    public function testHasNextReturnsFalseAfterFullIteration():void {
        _classUnderTest.getNext();
        _classUnderTest.getNext();
        assertThat(_classUnderTest.hasNext, isFalse());
    }

    [Test]
    public function testHasNextReturnsTrueAfterOneGetNext():void {
        _classUnderTest.getNext();
        assertThat(_classUnderTest.hasNext, isTrue());
    }

}
}
