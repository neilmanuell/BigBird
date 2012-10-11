package bigbird.data
{
import net.richardlord.signals.Signal2;

import org.hamcrest.assertThat;
import org.hamcrest.collection.array;
import org.hamcrest.object.equalTo;
import org.hamcrest.object.instanceOf;
import org.hamcrest.object.isFalse;
import org.hamcrest.object.isTrue;
import org.hamcrest.object.nullValue;
import org.hamcrest.object.strictlyEqualTo;

public class CollectionTest
{

    [Before]

    public function before():void
    {
    }

    [After]
    public function after():void
    {
    }

    [Test]
    public function length_by_default_equals_ZERO():void
    {
        assertThat( length, equalTo( 0 ) );
    }

    [Test]
    public function add_increases_length_by_one():void
    {
        add( {} );
        assertThat( length, equalTo( 1 ) );
    }

    [Test]
    public function add_registers_item():void
    {
        const item:Object = {}
        add( item );
        assertThat( has( item ), isTrue() );
    }

    [Test]
    public function get_returns_item_at_given_index():void
    {
        const item:Object = {}
        add( item );
        assertThat( get( 0 ), strictlyEqualTo( item ) );
    }

    [Test]
    public function get_returns_last_item_if_index_greaterThan_length():void
    {
        const item:Object = {}
        add( item );
        assertThat( get( 10 ), strictlyEqualTo( item ) );
    }

    [Test]
    public function get_returns_last_item_if_index_lessThan_ZERO():void
    {
        const item:Object = {}
        add( item );
        assertThat( get( -1 ), strictlyEqualTo( item ) );
    }

    [Test]
    public function remove_unregisters_item():void
    {
        const item:Object = {}
        add( item );
        remove( item );
        assertThat( has( item ), isFalse() );
    }

    [Test]
    public function remove_unregisterd_item_returns_null():void
    {
        add( {} );
        assertThat( remove( {} ), nullValue() );
    }

    [Test]
    public function indexOf_returns_correct_index():void
    {
        const item:Object = {}
        add( item );
        assertThat( indexOf( item ), equalTo( 0 ) );
    }

    [Test]
    public function indexOf_returns_MINUS_ONE_if_item_not_registered():void
    {
        const item:Object = {}
        add( item );
        assertThat( indexOf( {} ), equalTo( -1 ) );
    }

    [Test]
    public function flush_removes_all_items():void
    {
        add( {} );
        add( {} );
        add( {} );
        flush();
        assertThat( length, equalTo( 0 ) );
    }

    [Test]
    public function onChange_dispatches_on_add():void
    {
        const onChangedCalled:Array = [];

        const changeHandler:Function = function ( item:*, type:String ):void
        {
            onChangedCalled.push( true );
        }
        onChange.add( changeHandler );

        const addedItem:* = {}
        add( addedItem );
        remove( addedItem );
        flush();
        assertThat( onChangedCalled.length, equalTo( 3 ) );
    }

    [Test]
    public function onChange_dispatches_item_on_add():void
    {
        const recievedItems:Array = [];

        const changeHandler:Function = function ( item:*, type:String ):void
        {
            recievedItems.push( item );
        }
        onChange.add( changeHandler );

        const addedItem:* = {};
        add( addedItem );
        remove( addedItem );
        flush();
        assertThat( recievedItems, array( strictlyEqualTo( addedItem ), strictlyEqualTo( addedItem ), instanceOf( Array ) ) );
    }

    [Test]
    public function onChange_dispatches_type_on_add():void
    {
        const recievedTypes:Array = [];

        const changeHandler:Function = function ( item:*, type:String ):void
        {
            recievedTypes.push( type );
        }
        onChange.add( changeHandler );

        const addedItem:* = {}
        add( addedItem );
        remove( addedItem );
        flush();
        assertThat( recievedTypes, array( ADD, REMOVE, FLUSH ) );
    }


    public static const ADD:String = "add";
    public static const REMOVE:String = "remove";
    public static const FLUSH:String = "flush";

    private const _onChange:Signal2 = new Signal2( Object, String );
    private const _map:Array = [];

    public function get onChange():Signal2
    {
        return _onChange;
    }

    public function has( item:* ):Boolean
    {
        return (_map.indexOf( item ) != -1);
    }

    public function get( index:int ):*
    {
        index = Math.min( _map.length - 1, index );
        index = Math.max( 0, index );
        return _map[index];
    }

    public function add( item:* ):void
    {
        _map.push( item );
        _onChange.dispatch( item, ADD );
    }

    public function remove( item:* ):*
    {
        const index:int = _map.indexOf( item );
        if ( index == -1 )return null;
        _onChange.dispatch( item, REMOVE );
        return _map.splice( index, 1 );
    }

    public function flush():void
    {
        _onChange.dispatch( _map.slice(), FLUSH );
        _map.length = 0;
    }

    public function indexOf( item:* ):int
    {
        return _map.indexOf( item );
    }

    public function get length():int
    {
        return _map.length;
    }
}
}
