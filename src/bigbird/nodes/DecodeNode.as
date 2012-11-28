package bigbird.nodes
{
import bigbird.components.Chunker;
import bigbird.components.WordData;

import flash.net.URLRequest;

import net.richardlord.ash.core.Node;

public class DecodeNode extends Node
{
    public var request:URLRequest;
    public var document:WordData;
    public var chunker:Chunker;
}
}
