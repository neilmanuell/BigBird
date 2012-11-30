package utils.strings
{

public function naturallyJoin( paras:Array ):String
{
    if ( paras.length == 0 ) return   "";
    else if ( paras.length == 1 ) return cleanWhiteSpace( paras[0] );

    var s:String = "";
    var head:String = "";
    var tail:String = "";

    for each( var phrase:String in paras )
    {
        tail = s.charAt( s.length - 1 )
        head = phrase.charAt( 0 );
        if ( head == "" ) continue;
        else if ( head == "." || head == " " || head == "/" ) s = s + phrase;
        else s = s + " " + phrase
    }


    return cleanWhiteSpace( s )
}
}
