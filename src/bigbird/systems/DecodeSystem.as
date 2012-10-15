package bigbird.systems
{
import bigbird.nodes.DecodeNode;

import flash.utils.getTimer;

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
        const timeBefore:Number = getTimer();
        var count:int = 0;
        while ( node.document.hasNext && count < node.progress.chunkingSize )
        {
            _decoder.decode( node.document );
            count++;
        }

        node.progress.previousChunkingTime = getTimer() - timeBefore;
        node.progress.workDone = node.document.position;
        trace( node.progress.workDone )
    }


}
}
