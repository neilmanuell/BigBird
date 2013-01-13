package bigbird.systems.utils.decoding {
import bigbird.values.MISSING_CELL_XML;

public function adjustKeyValuePairing(keyValuePairType:CellPairingType, first:XML, second:XML):KeyValuePairResultVO {
    var keyCellData:XML;
    var valueCellData:XML;
    var stepback:Boolean = false;


    if (keyValuePairType == CellPairingType.NULL_PASSED)
        return new KeyValuePairResultVO(null, null, false, true);

    else if (keyValuePairType == CellPairingType.KEY_AND_VALUE_PASSED) {
        keyCellData = first;
        valueCellData = second;
    }

    else if (keyValuePairType == CellPairingType.VALUE_AND_KEY_PASSED || keyValuePairType == CellPairingType.VALUE_AND_VALUE_PASSED) {
        keyCellData = MISSING_CELL_XML;
        valueCellData = first;
        stepback = true;
    }

    else if (keyValuePairType == CellPairingType.KEY_AND_KEY_PASSED) {
        keyCellData = first;
        valueCellData = MISSING_CELL_XML;
        stepback = true;
    }

    else if (keyValuePairType == CellPairingType.KEY_AND_NULL_PASSED) {
        keyCellData = first;
        valueCellData = MISSING_CELL_XML;
    }

    else if (keyValuePairType == CellPairingType.VALUE_AND_NULL_PASSED) {
        keyCellData = MISSING_CELL_XML;
        valueCellData = first;
    }

    return new KeyValuePairResultVO(keyCellData, valueCellData, stepback);
}

}
