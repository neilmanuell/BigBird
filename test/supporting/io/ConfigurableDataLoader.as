package supporting.io
{
import bigbird.components.io.DataLoader;

public class ConfigurableDataLoader implements DataLoader
{

    public function ConfigurableDataLoader( bytesLoaded:uint, bytesTotal:uint, isComplete:Boolean = false ):void
    {
        _bytesLoaded = bytesLoaded;
        _bytesTotal = bytesTotal;

        _isComplete = isComplete
    }

    private var _isComplete:Boolean;

    public function get isLoadComplete():Boolean
    {
        return _isComplete;
    }

    public function get success():Boolean
    {
        return false;
    }

    public function get data():XML
    {
        return null;
    }

    private var _bytesTotal:uint;

    public function get bytesTotal():uint
    {
        return _bytesTotal;
    }

    private var _bytesLoaded:uint;

    public function get bytesLoaded():uint
    {
        return _bytesLoaded;
    }
}
}
