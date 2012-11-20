package bigbird.asserts
{
import net.richardlord.ash.core.Entity;

import org.hamcrest.assertThat;
import org.hamcrest.object.equalTo;
import org.hamcrest.object.isTrue;

public function assertExpectedComponents( expected:Array, entity:Entity ):void
{
    for each ( var classRef:Class in expected )
    {
        assertThat(
                "Entity expected to contain " + classRef + " component.",
                entity.has( classRef ),
                isTrue() );
    }

    const numReceived:int = entity.getAll().length;
    const numExpected:int = expected.length;
    assertThat( "Entity contains " + (numReceived - numExpected) + " more components than expected", numReceived, equalTo( numExpected ) );

}
}
