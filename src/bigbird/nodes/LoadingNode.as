package bigbird.nodes
{
import bigbird.components.WordData;
import bigbird.components.io.Loader;

import net.richardlord.ash.core.Node;
import net.richardlord.ash.fsm.EntityStateMachine;

public class LoadingNode extends Node
{
    public var loader:Loader;
    public var wordData:WordData;
    public var fsm:EntityStateMachine;

}
}
