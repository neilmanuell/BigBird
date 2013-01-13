/**
 * Created with IntelliJ IDEA.
 * User: revisual.co.uk
 * Date: 11/01/13
 * Time: 14:50
 * To change this template use File | Settings | File Templates.
 */
package bigbird.components.io {
public class WordNamespaceError extends Error {

    public function WordNamespaceError() {
        super("data does not declare the Word 'w' namespace")
    }
}
}
