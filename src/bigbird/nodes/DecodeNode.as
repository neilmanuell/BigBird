package bigbird.nodes
{
import bigbird.components.Progress;
import bigbird.components.RawWordDocument;

import flash.net.URLRequest;

import net.richardlord.ash.core.Node;

public class DecodeNode extends Node
{
    public var document:RawWordDocument;
    public var progress:Progress;
    public var url:URLRequest;
}
}
