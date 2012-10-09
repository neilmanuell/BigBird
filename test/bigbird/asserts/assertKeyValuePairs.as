package bigbird.asserts
{
import bigbird.components.KeyCell;
import bigbird.components.ValueCell;

import net.richardlord.ash.core.Entity;

import org.hamcrest.assertThat;
import org.hamcrest.object.equalTo;

public function assertKeyValuePairs( entities:Array, expected:Array ):void
{
    const got:Array = [];
    for each ( var entity:Entity in entities )
    {
        got.push( entity.get( KeyCell ).toString() );
        got.push( entity.get( ValueCell ).toString() );
    }
    assertThat( got.join( "," ), equalTo( expected.join( "," ) ) );
}
}
