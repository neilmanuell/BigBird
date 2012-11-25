package bigbird.systems.utils
{
public interface SelfRemovingSystem
{
    function get flaggedForRemove():Boolean;

    function cancelRemoval():void;


}
}
