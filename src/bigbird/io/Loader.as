package bigbird.io
{
public interface Loader
{
    function get bytesLoaded():uint
    function  get bytesTotal():uint
    function get data():XML
}
}
