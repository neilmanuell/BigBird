package bigbird.controller
{
import bigbird.nodes.LoadingNode;

public class StartWordFileDecode
{

    [Inject]
    public var fsmController:BigBirdFSMController;


    public function decode( node:LoadingNode ):void
    {
        node.wordData.setData( node.loader.data );
        fsmController.changeState( EntityStateNames.DECODING, node.entity );
    }


}
}
