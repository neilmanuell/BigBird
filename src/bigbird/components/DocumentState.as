package bigbird.components
{
import bigbird.io.Loader;
import bigbird.io.XMLLoader;

import flash.net.URLRequest;

import net.richardlord.ash.core.Entity;

public class DocumentState
{
    private var _entity:Entity;

    public function DocumentState( entity:Entity )
    {
        _entity = entity;
    }

    public function enterLoadingState():void
    {

    }

    public function enterDecodingState():void
    {
        const loader:DocumentLoader = _entity.get(DocumentLoader);
        addRawData( loader.data )
        _entity.remove( DocumentLoader );
    }

    public function addRawData( rawData:XML ):void
    {
        _entity.add( new RawWordDocument( rawData ) );
    }

    public function addURL( request:URLRequest ):void
    {
        const loader:Loader = new XMLLoader( request );
        _entity.add( new DocumentLoader( loader ) );
        _entity.add( request );
    }


}
}
