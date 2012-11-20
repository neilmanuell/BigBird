package bigbird.systems
{
import bigbird.components.WordData;
import bigbird.components.utils.getCellColourFromData;
import bigbird.factories.KeyValuePairFactory;
import bigbird.values.MISSING_CELL_XML;

import net.richardlord.ash.core.Game;

public class DecodeFromWordFile implements Decoder
{
    private static const KEY_AND_VALUE_PASSED:uint = 0;
    private static const VALUE_AND_KEY_PASSED:uint = 1;
    private static const KEY_AND_KEY_PASSED:uint = 2;
    private static const VALUE_AND_VALUE_PASSED:uint = 3;
    private static const KEY_AND_NULL_PASSED:uint = 4;
    private static const VALUE_AND_NULL_PASSED:uint = 5;
    private static const NULL_PASSED:uint = 10;
    private static const UNDEFINED_COMBINATION:uint = 20

    private var _factory:KeyValuePairFactory;

    public function DecodeFromWordFile( game:Game )
    {
        _factory = new KeyValuePairFactory( game );
    }

    public function decode( value:* ):void
    {
        var keyCellData:XML;
        var valueCellData:XML;

        const document:WordData = value;
        const first:XML = document.getNext();
        const second:XML = document.getNext();

        const result:uint = testKeyValuePairing( first, second, document.wNS );

        if ( result == NULL_PASSED )
            return;

        else if ( result == KEY_AND_VALUE_PASSED )
        {
            keyCellData = first;
            valueCellData = second;
        }

        else if ( result == VALUE_AND_KEY_PASSED || result == VALUE_AND_VALUE_PASSED )
        {
            keyCellData = MISSING_CELL_XML;
            valueCellData = first;
            document.stepback();
        }

        else if ( result == KEY_AND_KEY_PASSED )
        {
            keyCellData = first;
            valueCellData = MISSING_CELL_XML;
            document.stepback();
        }

        else if ( result == KEY_AND_NULL_PASSED )
        {
            keyCellData = first;
            valueCellData = MISSING_CELL_XML;
        }

        else if ( result == VALUE_AND_NULL_PASSED )
        {
            keyCellData = MISSING_CELL_XML;
            valueCellData = first;
        }
        _factory.createKeyValuePair( null, keyCellData, valueCellData );
    }

    private static function testKeyValuePairing( firstCell:XML, secondCell:XML, wNS:Namespace ):uint
    {
        if ( firstCell == null ) return NULL_PASSED;

        const firstCellColour:uint = getCellColourFromData( firstCell, wNS );
        if ( secondCell == null && firstCellColour != 0 ) return KEY_AND_NULL_PASSED;
        if ( secondCell == null && firstCellColour == 0 ) return VALUE_AND_NULL_PASSED;

        const secondCellColour:uint = getCellColourFromData( secondCell, wNS );
        if ( firstCellColour != 0 && secondCellColour == 0 ) return KEY_AND_VALUE_PASSED;
        if ( firstCellColour == 0 && secondCellColour != 0 ) return VALUE_AND_KEY_PASSED;
        if ( firstCellColour != 0 && secondCellColour != 0 ) return KEY_AND_KEY_PASSED;
        if ( firstCellColour == 0 && secondCellColour == 0 ) return VALUE_AND_VALUE_PASSED;

        return UNDEFINED_COMBINATION;
    }


}
}
