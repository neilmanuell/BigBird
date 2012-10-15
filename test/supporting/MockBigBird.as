package supporting
{
import flash.events.Event;

public class MockBigBird extends BigBird
{
    public var isActive:Boolean;


    override public function start():void
    {
        isActive = true;
        super.start();
    }

    override public function stop():void
    {
        dispatchEvent( new Event( Event.COMPLETE ) );
        super.stop();
    }
}
}
