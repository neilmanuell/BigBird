package bigbird.components
{
public class Progress
{

    public var workDone:int;
    public var totalWork:int;
    public var previousChunkingTime:Number;
    public var chunkingSize:int = 50;

    public function Progress( totalWork:int )
    {
        this.totalWork = totalWork;
    }
}
}
