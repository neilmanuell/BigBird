package bigbird.nodes
{
import bigbird.components.Chunker;
import bigbird.components.WordData;

import net.richardlord.ash.core.Node;

public class DecodeNode extends Node
{
    public var document:WordData;
    public var chunker:Chunker;
}
}
