package bigbird.systems.decode
{
import bigbird.components.WordData;
import bigbird.factories.KeyValuePairFactory;
import bigbird.systems.utils.decoding.KeyValuePairResultVO;
import bigbird.systems.utils.decoding.adjustKeyValuePairing;
import bigbird.systems.utils.decoding.testKeyValuePairing;

import flash.net.URLRequest;

public class DecodeFromWordFile
{

    private var _factory:KeyValuePairFactory;

    public function DecodeFromWordFile( factory:KeyValuePairFactory )
    {
        _factory = factory;
    }

    public function decode( request:URLRequest, document:WordData ):void
    {
        const first:XML = document.getNext();
        const second:XML = document.getNext();

        const keyValuePairType:uint = testKeyValuePairing( first, second, document.wNS );
        const keyValuePairResult:KeyValuePairResultVO = adjustKeyValuePairing( keyValuePairType, first, second );
        if ( keyValuePairResult.isNull )return;
        else if ( keyValuePairResult.stepback )document.stepback();
        _factory.createKeyValuePair( request, keyValuePairResult.key, keyValuePairResult.value );
    }


}
}
