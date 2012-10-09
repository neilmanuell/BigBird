package bigbird.components.utils
{
import org.hamcrest.assertThat;
import org.hamcrest.object.equalTo;

import supporting.values.KEY_CELL_XML;
import supporting.values.VALUE_CELL_XML;

public class UtilTests
{

    [Test]
    public function testReturnsCellContentsFromKeyCell():void
    {
        const content:String = getSimpleCellContentFromData( KEY_CELL_XML, KEY_CELL_XML.namespace( "w" ) );
        assertThat( content, equalTo( "Activity Type" ) );
    }

    [Test]
    public function testReturnsCellContentsFromValueCell():void
    {
        const content:String = getSimpleCellContentFromData( VALUE_CELL_XML, VALUE_CELL_XML.namespace( "w" ) );
        assertThat( content, equalTo( "QAA" ) );
    }

    [Test]
    public function testReturnsCellColourFromKeyCell():void
    {
        const colour:uint = getCellColourFromData( KEY_CELL_XML, KEY_CELL_XML.namespace( "w" ) );
        assertThat( colour, equalTo( 0x92D050 ) );
    }

    [Test]
    public function testReturnsCellColourFromValueCell():void
    {
        const colour:uint = getCellColourFromData( VALUE_CELL_XML, VALUE_CELL_XML.namespace( "w" ) );
        assertThat( colour, equalTo( 0 ) );
    }


}
}
