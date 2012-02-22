package bigbird.model.cells
{
public interface ICell
{
    function get colour():uint;

    function get content():String;

    function get rawData():XML;

    function decode( xml:XML, wNS:Namespace ):void;

}
}