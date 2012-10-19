package bigbird.components
{
import bigbird.core.ProgressSignal;
import bigbird.io.Loader;

public class DocumentLoader
{
    public var loader:Loader;

    public function DocumentLoader(loader:Loader )
    {
        this.loader = loader;
    }

    public function get data(  ):XML
    {
      return  loader.data;
    }
}
}
