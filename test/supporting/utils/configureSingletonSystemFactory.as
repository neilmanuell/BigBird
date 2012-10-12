package supporting.utils
{
import bigbird.components.SystemFactoryConfig;
import bigbird.factories.SingletonSystemFactory;
import bigbird.systems.DecodeFromRawDocument;
import bigbird.systems.DecodeSystem;
import bigbird.systems.DispatchDecodedSystem;
import bigbird.systems.SystemName;
import bigbird.systems.SystemPriority;

import net.richardlord.ash.core.Game;
import net.richardlord.ash.core.System;

public function configureSingletonSystemFactory( game:Game ):SingletonSystemFactory
{
    const factory:SingletonSystemFactory = new SingletonSystemFactory( game );

    const createDecodeSystem:Function = function ():System
    {
        return new DecodeSystem( new DecodeFromRawDocument( game ) );
    }

    const decodeConfig:SystemFactoryConfig = new SystemFactoryConfig(
            SystemName.DECODE,
            DecodeSystem,
            SystemPriority.DECODE_SYSTEM,
            createDecodeSystem );

    factory.register( decodeConfig );


    const createDispatchDecodedSystem:Function = function ():System
    {
        return new DispatchDecodedSystem( null );
    }

    const dispatchDecodedConfig:SystemFactoryConfig = new SystemFactoryConfig(
            SystemName.DISPATCH_DECODED,
            DispatchDecodedSystem,
            SystemPriority.DISPATCH_DECODED_SYSTEM,
            createDispatchDecodedSystem );

    factory.register( dispatchDecodedConfig );

    return factory;
}

}
