package bigbird.systems.decode
{
import bigbird.nodes.DecodeNode;
import bigbird.systems.BaseSelfRemovingSystem;

public class DecodeCompleteSystem extends BaseSelfRemovingSystem
{

    public function DecodeCompleteSystem()
    {
        super( DecodeNode, updateNode );
    }


    public function updateNode( node:DecodeNode, time:Number ):void
    {
        if ( node.document.hasNext )
            confirmActivity();

        else
            destroyEntity( node.entity )
        /*if ( node.document.hasNext )
         confirmActivity();

         else
         destroyEntity( node.entity );*/

    }


}
}
