package bigbird.nodes
{
import bigbird.components.DocumentAccess;
import bigbird.components.Progress;

import flash.net.URLRequest;

import net.richardlord.ash.core.Node;

public class LoadNode extends Node
{
    public var url:URLRequest;
    public var self:DocumentAccess;
    public var progress:Progress;
}
}
