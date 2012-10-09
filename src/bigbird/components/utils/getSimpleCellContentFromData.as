package bigbird.components.utils
{
public function getSimpleCellContentFromData( cellData:XML, wNS:Namespace ):String
{
    return  cellData..wNS::t.text();
}

}
