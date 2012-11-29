package bigbird.systems.decode
{
import bigbird.nodes.DecodeNode;
import bigbird.systems.BaseSelfRemovingSystem;

import flash.utils.getTimer;

public class DecodeSystem extends BaseSelfRemovingSystem
{
    private var _decoder:DecodeFromWordFile;


    public function DecodeSystem( decoder:DecodeFromWordFile )
    {
        super( DecodeNode, updateNode );
        _decoder = decoder;
    }

    internal function updateNode( node:DecodeNode, time:Number ):void
    {
        const timeBefore:Number = getTimer();
        var count:int = 0;

        while ( node.document.hasNext && count < node.chunker.chunkingSize )
        {
            _decoder.decode( node.request, node.document );
            count++;
        }

        node.chunker.previousChunkingTime = getTimer() - timeBefore;
        confirmActivity();
    }
}
}
