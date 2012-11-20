package bigbird.factories
{
import flash.events.Event;

import mockolate.nice;
import mockolate.prepare;
import mockolate.received;

import net.richardlord.ash.core.Entity;
import net.richardlord.ash.core.Game;
import net.richardlord.ash.fsm.EntityStateMachine;

import org.flexunit.async.Async;
import org.hamcrest.assertThat;
import org.hamcrest.object.instanceOf;
import org.hamcrest.object.strictlyEqualTo;

import supporting.values.DOCUMENT_URL;
import supporting.values.KEY_CELL_XML;
import supporting.values.VALUE_CELL_XML;

public class KeyValuePairFactoryTest
{

    private var game:Game;
    private var classUnderTest:KeyValuePairFactory

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
        assertThat( classUnderTest.createKeyValuePair( DOCUMENT_URL, KEY_CELL_XML, VALUE_CELL_XML ), instanceOf( Entity ) );
    }

    [Test]
    public function createKeyValuePair_adds_Entity_to_Game():void
    {
        const entity:Entity = classUnderTest.createKeyValuePair( DOCUMENT_URL, KEY_CELL_XML, VALUE_CELL_XML );
        assertThat( game, received().method( "addEntity" ).arg( strictlyEqualTo( entity ) ).once() )
    }

    [Test]
    public function createKeyValuePair_returns_Entity_containing_instanceOf_EntityStateMachine():void
    {
        const entity:Entity = classUnderTest.createKeyValuePair( DOCUMENT_URL, KEY_CELL_XML, VALUE_CELL_XML );
        assertThat( entity.get( EntityStateMachine ), instanceOf( EntityStateMachine ) );
    }

    /* [Test]



     [Test]
     public function testKeyCellHas_KEY_CELL_DATA():void
     {
     const entity:Entity = classUnderTest.createKeyValuePair( DOCUMENT_NAME, KEY_CELL_XML, VALUE_CELL_XML );
     const xml:XML = KeyCell( entity.get( KeyCell ) ).rawData;
     assertThat( xml, strictlyEqualTo( KEY_CELL_XML ) );
     }

     [Test]
     public function testKeyCellHas_VALUE_CELL_DATA():void
     {
     const entity:Entity = classUnderTest.createKeyValuePair( DOCUMENT_NAME, KEY_CELL_XML, VALUE_CELL_XML );
     const xml:XML = ValueCell( entity.get( ValueCell ) ).rawData;
     assertThat( xml, strictlyEqualTo( VALUE_CELL_XML ) );
     }



     [Test]
     public function UID_increases_with_each_call_for_same_doc_name():void
     {
     var entity:Entity = classUnderTest.createKeyValuePair( DOCUMENT_NAME, KEY_CELL_XML, VALUE_CELL_XML );
     var uid:int = KeyValuePairUID( entity.get( KeyValuePairUID ) ).index;
     assertThat( uid, equalTo( 0 ) );

     entity = classUnderTest.createKeyValuePair( DOCUMENT_NAME, KEY_CELL_XML, VALUE_CELL_XML );
     uid = KeyValuePairUID( entity.get( KeyValuePairUID ) ).index;
     assertThat( uid, equalTo( 1 ) );

     entity = classUnderTest.createKeyValuePair( DOCUMENT_NAME, KEY_CELL_XML, VALUE_CELL_XML );
     uid = KeyValuePairUID( entity.get( KeyValuePairUID ) ).index;
     assertThat( uid, equalTo( 2 ) );
     }

     [Test]
     public function UID_increases_per_doc_name():void
     {
     var entity:Entity = classUnderTest.createKeyValuePair( "name 1", KEY_CELL_XML, VALUE_CELL_XML );
     var uid:int = KeyValuePairUID( entity.get( KeyValuePairUID ) ).index;
     assertThat( "name 1 - first call", uid, equalTo( 0 ) );

     entity = classUnderTest.createKeyValuePair( "name 2", KEY_CELL_XML, VALUE_CELL_XML );
     uid = KeyValuePairUID( entity.get( KeyValuePairUID ) ).index;
     assertThat( "name 2 - first call", uid, equalTo( 0 ) );

     entity = classUnderTest.createKeyValuePair( "name 1", KEY_CELL_XML, VALUE_CELL_XML );
     uid = KeyValuePairUID( entity.get( KeyValuePairUID ) ).index;
     assertThat( "name 1 - second call", uid, equalTo( 1 ) );

     entity = classUnderTest.createKeyValuePair( "name 2", KEY_CELL_XML, VALUE_CELL_XML );
     uid = KeyValuePairUID( entity.get( KeyValuePairUID ) ).index;
     assertThat( "name 2 - second call", uid, equalTo( 1 ) );


     }


     [Test]
     public function groupID_set_on_KeyValuePairUID():void
     {
     var entity:Entity = classUnderTest.createKeyValuePair( DOCUMENT_NAME, KEY_CELL_XML, VALUE_CELL_XML );
     var groupID:String = KeyValuePairUID( entity.get( KeyValuePairUID ) ).groupID;
     assertThat( groupID, equalTo( DOCUMENT_NAME ) );


     }

     [Test]
     public function testEntityIsAddedToGame():void
     {
     const entity:Entity = classUnderTest.createKeyValuePair( DOCUMENT_NAME, KEY_CELL_XML, VALUE_CELL_XML );
     assertThat( game, received().method( "addEntity" ).arg( strictlyEqualTo( entity ) ).once() )
     }*/


}
}
