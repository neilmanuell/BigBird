package bigbird.model.cells
{
public class MissingCell implements ICell
{
    public static const VALUE:String = "!MISSING!";
    public static const COLOUR:uint = 0xff0000;

    public function get colour():uint
    {
        return COLOUR;
    }

    public function get content():String
    {
        return  VALUE;
    }

    public function get rawData():XML
    {
        return new XML();
    }


    public function decode( xml:XML, wNS:Namespace ):void
    {
    }
}
}