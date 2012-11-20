package bigbird.components.io
{
public interface DataLoader

{

    function get bytesLoaded():uint

    function  get bytesTotal():uint

    function get isLoadComplete():Boolean

    function get success():Boolean

    function get data():XML


}
}
