package bigbird.systems.utils.removal
{
public interface SelfRemovingSystem
{
    function get flaggedForRemove():Boolean;

    function cancelRemoval():void;


}
}
