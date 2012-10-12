package bigbird.nodes
{
import bigbird.components.KeyCell;
import bigbird.components.KeyValuePairState;
import bigbird.components.KeyValuePairUID;
import bigbird.components.ValueCell;

import net.richardlord.ash.core.Node;

public class KeyValuePairNode extends Node
{
    public var uid:KeyValuePairUID;
    public var state:KeyValuePairState;
    public var key:KeyCell;
    public var value:ValueCell;
}
}