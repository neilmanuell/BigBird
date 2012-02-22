package bigbird.model.cells
{
public interface IKeyValue
{
    function get label():String;

    function get colour():uint;

    function get value():String;

    function get keyRawData():XML;

    function get valueRawData():XML;

}
}