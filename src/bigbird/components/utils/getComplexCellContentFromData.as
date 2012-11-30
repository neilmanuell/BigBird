package bigbird.components.utils
{
import utils.strings.cleanWhiteSpace;

public function getComplexCellContentFromData( xml:XML, wNS:Namespace ):String
{
    var s:String = "";
    const paras:Array = [];
    var p:XMLList = xml.wNS::p;
    for each( var node:XML in p )
    {
        paras.push( cycleParagraphs( node.*, wNS ) );
    }

    return cleanWhiteSpace( paras.join( "" ) );
}

}
