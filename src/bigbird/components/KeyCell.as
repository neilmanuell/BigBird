package bigbird.components
{
import bigbird.components.utils.getCellColourFromData;
import bigbird.components.utils.getComplexCellContentFromData;

public class KeyCell
{

    public var rawData:XML;
    public var colour:uint;
    public var label:String;

    public function KeyCell( rawData:XML, wNS:Namespace )
    {
        this.rawData = rawData;
        colour = getCellColourFromData( rawData, wNS );
        label = getComplexCellContentFromData( rawData, wNS );
    }

    public function toString():String
    {
        return "[KeyCell(colour:0x" + colour.toString( 16 ).toUpperCase() + ",label:" + label + ")]"
    }
}
}
