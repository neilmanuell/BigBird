package bigbird.nodes
{
import bigbird.components.KeyCell;
import bigbird.components.KeyValuePairInfo;
import bigbird.components.ValueCell;

import net.richardlord.ash.core.Node;

public class KeyValuePairNode extends Node
{
    public var info:KeyValuePairInfo;
    public var key:KeyCell;
    public var value:ValueCell;
}
}
