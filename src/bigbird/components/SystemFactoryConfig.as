package bigbird.components
{
import net.richardlord.ash.core.System;

public class SystemFactoryConfig
{
    public var priority:int;
    public var systemName:String;
    public var instance:System;
    public var systemClass:Class;
    public var isActive:Boolean;

    public function SystemFactoryConfig( systemName:String, systemClass:Class, priority:int, factoryMethod:Function = null )
    {
        this.systemName = systemName;
        this.systemClass = systemClass;
        this.priority = priority;
        this.instance = (factoryMethod == null) ? new systemClass : factoryMethod();

    }


}
}
