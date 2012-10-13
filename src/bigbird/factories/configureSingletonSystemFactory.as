package bigbird.factories
{
import bigbird.components.SystemFactoryConfig;
import bigbird.systems.DecodeFromRawDocument;
import bigbird.systems.DecodeSystem;
import bigbird.systems.DispatchDecodedSystem;
import bigbird.systems.SystemName;
import bigbird.systems.SystemPriority;

import net.richardlord.ash.core.System;

public function configureSingletonSystemFactory( bigbird:Bigbird ):SingletonSystemFactory
{
    const factory:SingletonSystemFactory = new SingletonSystemFactory( bigbird.game );

    const createDecodeSystem:Function = function ():System
    {
        return new DecodeSystem( new DecodeFromRawDocument( bigbird.game ) );
    }

    const decodeConfig:SystemFactoryConfig = new SystemFactoryConfig(
            SystemName.DECODE,
            DecodeSystem,
            SystemPriority.DECODE_SYSTEM,
            createDecodeSystem );

    factory.register( decodeConfig );


    const createDispatchDecodedSystem:Function = function ():System
    {
        return new DispatchDecodedSystem( bigbird.onKeyValuePairDecoded );
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
