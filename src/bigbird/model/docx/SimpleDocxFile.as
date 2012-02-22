package bigbird.model.docx
{
import deng.fzip.FZip;
import deng.fzip.FZipFile;

public class SimpleDocxFile implements IDocxFile
{

    public static const DOCUMENT_XML_PATH:String = "word/document.xml";

    private var _fzip:FZip;
    private var _url:String;
    public function SimpleDocxFile( fzip:FZip, url:String ):void
    {
        _fzip = fzip;
        _url = url;
    }

    public function get url():String
    {
        return _url;
    }

    public function getDocumentXML():XML
    {
        const fzipFile:FZipFile = _fzip.getFileByName( DOCUMENT_XML_PATH );
        return sliceOutDocumentElement( fzipFile.getContentAsString() );
    }

    private function sliceOutDocumentElement( script:String ):XML
    {
        XML.ignoreWhitespace = false;
        var section:String = sliceTags( script, "<w:document", "</w:document>" );
        var node:XML = new XML( section );
        var wNS:Namespace = node.namespace( "w" );
        var body:XML = node.wNS::body[0];
        body.normalize();
        XML.ignoreWhitespace = true;
        return body
    }

    private function sliceTags( value:String, openTag:String, closeTag:String ):String
    {
        var start:int = value.search( openTag );
        var end:int = value.search( closeTag );

        if ( start == -1 || end == -1 ) return null;

        return value.slice( start, end + closeTag.length );
    }




}
}
