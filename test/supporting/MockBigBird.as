package supporting
{
import flash.events.Event;

public class MockBigBird extends BigBird
{

    override protected function stop():void
    {
        super.stop();
        dispatchEvent( new Event( Event.COMPLETE ) );
    }
}
}
