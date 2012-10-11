package bigbird.asserts
{
import net.richardlord.ash.core.Node;
import net.richardlord.ash.core.NodeList;

import org.hamcrest.assertThat;
import org.hamcrest.object.equalTo;

public function assertNodeListLength( list:NodeList, expected:int ):void
{
    var length:int = 0;
    for ( var node:Node = list.head; node; node = node.next )
    {
        length++;
    }
    assertThat( length, equalTo( expected ) );
}
}
