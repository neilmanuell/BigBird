package bigbird.components.utils
{
import bigbird.components.EntityStateNames;
import bigbird.systems.utils.AddLoadingSystems;

public class BigBirdFSMController extends EntityFSMController
{
    [Inject]
    public var loadingSystems:AddLoadingSystems;


    public function BigBirdFSMController()
    {

        addOnEnter( EntityStateNames.LOADING, onLoading );
    }

    private function onLoading():void
    {

        loadingSystems.add();
    }
}
}
