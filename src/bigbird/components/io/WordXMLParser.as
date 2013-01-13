/**
 * Created with IntelliJ IDEA.
 * User: revisual.co.uk
 * Date: 12/01/13
 * Time: 10:56
 * To change this template use File | Settings | File Templates.
 */
package bigbird.components.io {
public class WordXMLParser {


    private var _data:XML;

    public function get data():XML {
        if (_data == null)
            return new XML();
        else
            return _data;
    }

    public function convert(data:String):XML {
        XML.ignoreWhitespace = false;
        _data = new XML(data);
        const wNS:Namespace = _data.namespace("w");
        if (wNS == null)
            throw new WordNamespaceError();
        _data.normalize();
        XML.ignoreWhitespace = true;
        return _data;

    }
}
}
