package supporting.io
{
import bigbird.components.io.DataLoader;

import supporting.values.DOCUMENT_SINGLE_KEY_VALUE_PAIR_XML;

public class HappyDataLoader implements DataLoader
{

    public function get isLoadComplete():Boolean
    {
        return true;
    }

    public function get data():XML
    {
        return DOCUMENT_SINGLE_KEY_VALUE_PAIR_XML;
    }

    public function get bytesLoaded():uint
    {
        return 0;
    }

    public function get bytesTotal():uint
    {
        return 0;
    }

    public function get success():Boolean
    {
        return false;
    }
}
}
