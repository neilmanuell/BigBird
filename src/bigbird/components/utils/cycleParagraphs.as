package bigbird.components.utils
{

internal function cycleParagraphs( xmllist:XMLList, wNS:Namespace ):String
{
    var s:String = "";
    const t:XMLList = xmllist.wNS::t;
    for each( var node:XML in t )
    {
        var text:String = node.text();
        if ( node.attributes().toString().indexOf( "preserve" ) != -1 )
            text = text + " ";
        s += text;
    }
    if ( s.charAt( s.length - 1 ) != " " )
        s += " ";
    return s;
}

}
