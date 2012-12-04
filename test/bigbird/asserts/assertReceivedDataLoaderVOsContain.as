package bigbird.asserts
{
import bigbird.api.vos.WordScriptVO;

import org.hamcrest.assertThat;
import org.hamcrest.number.greaterThan;
import org.hamcrest.number.lessThan;

public function assertReceivedDataLoaderVOsContain( url:String, data:String, recieved:Vector.<WordScriptVO>, isError:Boolean = false ):void
{
    var numberContains:int = 0;
    var dataLoaderData:String;

    for each ( var vo:WordScriptVO in recieved )
    {
        if ( isError )
        {
            dataLoaderData = vo.data.type.text()
        }

        else
        {
            dataLoaderData = vo.data.toString()
        }

        if ( vo.url == url && dataLoaderData == data )
        {
            numberContains++;
        }

    }

    assertThat( "No DataLoaderVO contains url:" + url + " or its expected data content", numberContains, greaterThan( 0 ) );
    assertThat( numberContains + " instances of DataLoaderVO containing url:" + url + " and its expected data content. 1 expected", numberContains, lessThan( 2 ) );

}
}
