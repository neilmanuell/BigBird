package bigbird.components
{
import net.richardlord.ash.core.Entity;

import org.hamcrest.assertThat;
import org.hamcrest.object.equalTo;
import org.hamcrest.object.instanceOf;

import supporting.values.DOCUMENT_SINGLE_KEY_VALUE_PAIR_XML;

public class DocumentWrapperTest
{
    private var _entity:Entity;
    private var _classUnderTest:DocumentAccess;


    [Before]
    public function setUp():void
    {
        _entity = new Entity();
        _classUnderTest = new DocumentAccess( _entity );
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


}
}
