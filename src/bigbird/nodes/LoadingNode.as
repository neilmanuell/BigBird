package bigbird.nodes
{
import bigbird.components.DocumentState;
import bigbird.components.DocumentLoader;
import bigbird.components.Progress;

import flash.net.URLRequest;

import net.richardlord.ash.core.Node;

public class LoadingNode extends Node
{
    public var url:URLRequest;
    public var loader:DocumentLoader;
    public var state:DocumentState;
    public var progress:Progress;
}
}
