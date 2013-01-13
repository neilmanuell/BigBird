package bigbird.systems.utils.decoding {
import bigbird.components.utils.getCellColourFromData;

public function testKeyValuePairing(firstCell:XML, secondCell:XML, wNS:Namespace):CellPairingType {
    if (firstCell == null) return CellPairingType.NULL_PASSED;

    const firstCellColour:uint = getCellColourFromData(firstCell, wNS);
    if (secondCell == null && firstCellColour != 0) return CellPairingType.KEY_AND_NULL_PASSED;
    if (secondCell == null && firstCellColour == 0) return CellPairingType.VALUE_AND_NULL_PASSED;

    const secondCellColour:uint = getCellColourFromData(secondCell, wNS);
    if (firstCellColour != 0 && secondCellColour == 0) return CellPairingType.KEY_AND_VALUE_PASSED;
    if (firstCellColour == 0 && secondCellColour != 0) return CellPairingType.VALUE_AND_KEY_PASSED;
    if (firstCellColour != 0 && secondCellColour != 0) return CellPairingType.KEY_AND_KEY_PASSED;
    if (firstCellColour == 0 && secondCellColour == 0) return CellPairingType.VALUE_AND_VALUE_PASSED;

    return CellPairingType.UNDEFINED_COMBINATION;
}

}
