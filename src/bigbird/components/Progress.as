package bigbird.components
{
public class Progress
{

    public var workDone:int;
    public var totalWork:int;
    public var previousChunkingTime:Number;
    public var chunkingSize:int = 100;

    public function Progress( totalWork:int )
    {
        this.totalWork = totalWork;
    }
}
}
