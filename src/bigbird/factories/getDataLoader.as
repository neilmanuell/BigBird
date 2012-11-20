package bigbird.factories
{

import bigbird.components.io.DOCXLoader;
import bigbird.components.io.DataLoader;
import bigbird.components.io.NullLoader;
import bigbird.components.io.XMLLoader;

import flash.net.URLRequest;

public function getDataLoader( request:URLRequest ):DataLoader
{
    const split:Array = request.url.toLowerCase().split( "." );
    const extension:String = split[split.length - 1];
    if ( extension == "xml" )return new XMLLoader( request );
    if ( extension == "docx" )return new DOCXLoader( request );
    return new NullLoader( request );
}

}
