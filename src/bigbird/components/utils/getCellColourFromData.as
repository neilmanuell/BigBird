package bigbird.components.utils
{
public function getCellColourFromData( cellData:XML, wNS:Namespace ):uint
{
    var c:String = cellData.wNS::tcPr.wNS::shd.@wNS::color;
    if ( c == "auto" )c = cellData.wNS::tcPr.wNS::shd.@wNS::fill;
    return uint( "0x" + c );
}

}
