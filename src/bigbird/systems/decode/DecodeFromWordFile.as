package bigbird.systems.decode {
import bigbird.components.WordData;
import bigbird.controller.EntityFSMController;
import bigbird.factories.KeyValuePairFactory;
import bigbird.systems.utils.decoding.CellPairingType;
import bigbird.systems.utils.decoding.KeyValuePairResultVO;
import bigbird.systems.utils.decoding.adjustKeyValuePairing;
import bigbird.systems.utils.decoding.testKeyValuePairing;

import flash.net.URLRequest;

import net.richardlord.ash.core.Entity;

public class DecodeFromWordFile {
    private var _factory:KeyValuePairFactory;
    private var _fsmController:EntityFSMController;

    public function DecodeFromWordFile(factory:KeyValuePairFactory, fsmController:EntityFSMController) {
        _factory = factory;
        _fsmController = fsmController;
    }

    public function decode(request:URLRequest, document:WordData):Entity {
        const first:XML = document.getNext();
        const second:XML = document.getNext();

        const keyValuePairType:CellPairingType = testKeyValuePairing(first, second, document.wNS);
        const keyValuePairResult:KeyValuePairResultVO = adjustKeyValuePairing(keyValuePairType, first, second);

        if (keyValuePairResult.isNull)
            return new Entity();

        else if (keyValuePairResult.stepback)
            document.stepback();

        return _factory.createKeyValuePair(request, keyValuePairResult.key, keyValuePairResult.value);
    }


}
}
