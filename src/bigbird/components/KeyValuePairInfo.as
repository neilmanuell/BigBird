package bigbird.components
{
import flash.net.URLRequest;

public class KeyValuePairInfo
{
    public var index:int;
    public var dispatched:Boolean = false;
    public var request:URLRequest;

    public function KeyValuePairInfo( index:int, request:URLRequest )
    {
        this.index = index;
        this.request = request;
    }
}
}
