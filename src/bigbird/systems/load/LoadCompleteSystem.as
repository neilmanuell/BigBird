package bigbird.systems.load
{
import bigbird.controller.StartWordFileDecode;
import bigbird.core.WordDataSignal;
import bigbird.nodes.LoadingNode;
import bigbird.systems.BaseSelfRemovingSystem;

public class LoadCompleteSystem extends BaseSelfRemovingSystem
{


    private var _onLoaded:WordDataSignal;
    private var _wordFileDecode:StartWordFileDecode;

    public function LoadCompleteSystem( onLoaded:WordDataSignal, decode:StartWordFileDecode )
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
