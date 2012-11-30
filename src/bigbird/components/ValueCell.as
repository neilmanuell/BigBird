package bigbird.components
{
import bigbird.components.utils.getComplexCellContentFromData;

public class ValueCell
{

    public var rawData:XML;
    public var content:String;

    public function ValueCell( rawData:XML, wNS:Namespace )
    {
        this.rawData = rawData;
        content = getComplexCellContentFromData( rawData, wNS );
    }

    public function toString():String
    {
        return "[ValueCell(content:" + content + ")]"
    }
}
}
