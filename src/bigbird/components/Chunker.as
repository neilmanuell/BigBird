package bigbird.components
{
public class Chunker
{
    public var previousChunkingTime:Number = 0;
    public var chunkingSize:int;

    public function Chunker( chunkingSize:int = 50 )
    {
        this.chunkingSize = chunkingSize;
    }
}
}
