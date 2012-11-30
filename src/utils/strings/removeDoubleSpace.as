package utils.strings
{


/**
 * Removes extraneous whitespace (extra spaces, tabs, line breaks, etc) from the specified String.
 * @param value String whose extraneous whitespace will be removed
 * @returns Output String
 */
public function removeDoubleSpace( value:String ):String
{
    var out:String = value;

    while ( out.indexOf( "  " ) != -1 )
    {
        out = out.replace( "  ", " " );
    }

    return out;
}
}
