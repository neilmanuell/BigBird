package bigbird.controller
{
import bigbird.systems.utils.removal.AddDecodingSystems;
import bigbird.systems.utils.removal.AddLoadingSystems;

public class BigBirdFSMController extends EntityFSMController
{
    [Inject]
    public var loadingSystems:AddLoadingSystems;

    [Inject]
    public var decodingSystems:AddDecodingSystems;


    public function BigBirdFSMController()
    {
        addOnEnter( EntityStateNames.LOADING, onLoading );
        addOnEnter( EntityStateNames.DECODING, onDecoding );
    }

    private function onLoading():void
    {

        loadingSystems.add();
    }

    private function onDecoding():void
    {

        decodingSystems.add();
    }
}
}
