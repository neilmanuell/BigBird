package bigbird.nodes
{
import bigbird.components.KeyCell;
import bigbird.components.KeyValuePairIndex;
import bigbird.components.ValueCell;

import flash.net.URLRequest;

import net.richardlord.ash.core.Node;

public class KeyValuePairNode extends Node
{
    public var uid:KeyValuePairIndex;
    public var request:URLRequest;
    public var key:KeyCell;
    public var value:ValueCell;
}
}
