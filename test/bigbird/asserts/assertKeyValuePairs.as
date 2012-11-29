package bigbird.asserts
{
import bigbird.components.KeyCell;
import bigbird.components.ValueCell;

import net.richardlord.ash.core.Entity;

import org.hamcrest.assertThat;
import org.hamcrest.object.equalTo;

public function assertKeyValuePairs( entity:Entity, expected:Array ):void
{
    const got:Array = [];

    got.push( entity.get( KeyCell ).toString() );
    got.push( entity.get( ValueCell ).toString() );

    assertThat( got.join( "," ), equalTo( expected.join( "," ) ) );
}
}
