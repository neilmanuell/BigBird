package bigbird.components
{

import flash.events.Event;

import mockolate.prepare;

import org.flexunit.async.Async;

public class test
{

    [Before(order=1, async, timeout=5000)]
    public function prepareMockolates():void
    {
        Async.proceedOnEvent( this,
                prepare(),
                Event.COMPLETE );
    }

    [Before(order=2)]
    public function before():void
    {

    }

    [After]
    public function after():void
    {
    }

    [Test]
    public function test():void
    {
    }
}
}
