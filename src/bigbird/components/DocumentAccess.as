package bigbird.components
{
import net.richardlord.ash.core.Entity;

public class DocumentAccess
{
    private var _entity:Entity;

    public function DocumentAccess( entity:Entity )
    {
        _entity = entity;
    }

    public function addRawData( rawData:XML ):void
    {
        _entity.add( new RawWordDocument( rawData ) );
    }


}
}
