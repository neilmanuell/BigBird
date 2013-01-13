package bigbird.systems.utils.decoding {
public class CellPairingType {

    public static const KEY_AND_VALUE_PASSED:CellPairingType = new CellPairingType("KEY_AND_VALUE_PASSED");
    public static const VALUE_AND_KEY_PASSED:CellPairingType = new CellPairingType("VALUE_AND_KEY_PASSED");
    public static const KEY_AND_KEY_PASSED:CellPairingType = new CellPairingType("KEY_AND_KEY_PASSED");
    public static const VALUE_AND_VALUE_PASSED:CellPairingType = new CellPairingType("VALUE_AND_VALUE_PASSED");
    public static const KEY_AND_NULL_PASSED:CellPairingType = new CellPairingType("KEY_AND_NULL_PASSED");
    public static const VALUE_AND_NULL_PASSED:CellPairingType = new CellPairingType("VALUE_AND_NULL_PASSED");
    public static const NULL_PASSED:CellPairingType = new CellPairingType("NULL_PASSED");
    public static const UNDEFINED_COMBINATION:CellPairingType = new CellPairingType("UNDEFINED_COMBINATION");

    public function CellPairingType(type:String) {
        _type = type;
    }

    private var _type:String;

    public function get type():String {
        return _type;
    }
}
}
