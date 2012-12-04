package bigbird.systems.load
{
import bigbird.controller.StartWordFileDecode;
import bigbird.api.signals.OnLoaded;
import bigbird.nodes.LoadingNode;
import bigbird.systems.BaseSelfRemovingSystem;

public class LoadCompleteSystem extends BaseSelfRemovingSystem
{


    private var _onLoaded:OnLoaded;
    private var _wordFileDecode:StartWordFileDecode;

    public function LoadCompleteSystem( onLoaded:OnLoaded, decode:StartWordFileDecode )
    {
        super( LoadingNode, updateNode );
        _onLoaded = onLoaded;
        _wordFileDecode = decode;
    }


    public function updateNode( node:LoadingNode, time:Number ):void
    {
        if ( node.loader.isLoadComplete )
        {
            _onLoaded.dispatchWordData( node.loader );

            if ( node.loader.success )
            {
                _wordFileDecode.decode( node );
            }
            else
            {
                destroyEntity( node.entity );
            }
        }
        else
        {
            confirmActivity();
        }


    }


}
}
