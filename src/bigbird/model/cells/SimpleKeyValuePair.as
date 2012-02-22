package bigbird.model.cells
{
public class SimpleKeyValuePair implements IKeyValue
{
    private var _keyCell:ICell;
    private var _valueCell:ICell;

    public function SimpleKeyValuePair( keyCell:ICell=null, valueCell:ICell=null ):void
    {
        setCells(keyCell, valueCell);
    }
    public function setCells( keyCell:ICell, valueCell:ICell ):void
    {
        _keyCell = keyCell;
        _valueCell = valueCell;
    }

    public function get label():String
    {
        return _keyCell.content;
    }

    public function get colour():uint
    {
        return _keyCell.colour;
    }

    public function get value():String
    {
        return _valueCell.content;
    }

    public function get keyRawData():XML
    {
        return _keyCell.rawData;
    }

    public function get valueRawData():XML
    {
        return _valueCell.rawData;
    }

}
}