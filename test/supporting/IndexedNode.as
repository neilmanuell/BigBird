package supporting
{
import net.richardlord.ash.core.Node;

public class IndexedNode extends Node
{
    public var index:int;
    public var group:String;

    public function IndexedNode( index:int, group:String )
    {
        this.index = index;
        this.group = group;
    }
}
}
