package bigbird.systems
{
import bigbird.nodes.DecodeNode;

import net.richardlord.ash.tools.ListIteratingSystem;

public class DecodeSystem extends ListIteratingSystem
{
    private var _decoder:Decoder;

    public function DecodeSystem( decoder:Decoder )
    {
        super( DecodeNode, updateNode );
        _decoder = decoder;
    }

    internal function updateNode( node:DecodeNode, time:Number ):void
    {
        const timeBefore:Number = new Date().time;
        var count:int = 0;
        while ( node.document.hasNext && count < node.progress.chunkingSize )
        {
            _decoder.decode( node.document );
            count++;
        }
        node.progress.previousChunkingTime = new Date().time - timeBefore;
        node.progress.workDone = node.document.position * 0.5;
    }


}
}
