package bigbird.controller
{
import bigbird.factories.WordEntityFactory;

import flash.net.URLRequest;

public class StartWordFileLoad
{
    [Inject]
    public var factory:WordEntityFactory


    [Inject]
    public var fsmController:BigBirdFSMController


    public function load( request:URLRequest ):void
    {

        fsmController.changeState( EntityStateNames.LOADING, factory.createWordFileEntity( request ) )
    }


}
}
