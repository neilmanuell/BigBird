package bigbird.systems
{
import bigbird.components.Progress;
import bigbird.nodes.LoadingNode;

import supporting.values.DOCUMENT_URL;

public class LoadingSystemTest
{
    private var _node:LoadingNode;


    [Before]
    public function before():void
    {
        _node = new LoadingNode();
        _node.url = DOCUMENT_URL
        _node.progress = new Progress( 0 );

    }

    [After]
    public function after():void
    {
        _node = null;
    }


    [Test]
    public function test():void
    {

    }

    internal function updateNode( node:LoadingNode, time:Number ):void
    {
    }
}
}
