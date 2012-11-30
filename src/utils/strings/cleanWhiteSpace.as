package utils.strings
{


/**
 * Removes extraneous whitespace (extra spaces, tabs, line breaks, etc) from the specified String.
 * @param value String whose extraneous whitespace will be removed
 * @returns Output String
 */
public function cleanWhiteSpace( value:String ):String
{
    return removeDoubleSpace( removeExtraWhitespace( value ) );
}
}
