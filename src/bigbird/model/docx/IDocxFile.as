package bigbird.model.docx
{
import flash.net.URLRequest;

public interface IDocxFile
{
    function getDocumentXML(  ):XML
    function get urlRequest():URLRequest;
}
}
