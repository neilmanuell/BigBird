package bigbird.nodes
{
import bigbird.components.Progress;
import bigbird.components.WordData;

import flash.net.URLRequest;

import net.richardlord.ash.core.Node;

public class DecodeNode extends Node
{
    public var document:WordData;
    public var progress:Progress;
    public var url:URLRequest;
}
}
