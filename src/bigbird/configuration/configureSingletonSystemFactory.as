package bigbird.configuration
{
import bigbird.components.BigBirdProgress;
import bigbird.components.SystemFactoryConfig;
import bigbird.factories.*;
import bigbird.systems.DecodeFromRawDocument;
import bigbird.systems.DecodeSystem;
import bigbird.systems.DispatchDecodedSystem;
import bigbird.systems.ProgressSystem;
import bigbird.systems.SystemName;
import bigbird.systems.SystemPriority;

import net.richardlord.ash.core.System;

public function configureSingletonSystemFactory( factory:SingletonSystemFactory, bigbird:BigBird ):void
{
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
        return new DispatchDecodedSystem( bigbird.onDecoded );
    }

    const dispatchDecodedConfig:SystemFactoryConfig = new SystemFactoryConfig(
            SystemName.DISPATCH_DECODED,
            DispatchDecodedSystem,
            SystemPriority.DISPATCH_DECODED_SYSTEM,
            createDispatchDecodedSystem );

    factory.register( dispatchDecodedConfig );


    const createProcessSystem:Function = function ():System
    {
        const progress:BigBirdProgress = new BigBirdProgress( bigbird.onProgress );
        return new ProgressSystem( progress, bigbird.stateMachine );
    }

    const processSystemConfig:SystemFactoryConfig = new SystemFactoryConfig(
            SystemName.PROGRESS,
            ProgressSystem,
            SystemPriority.PROGRESS_SYSTEM,
            createProcessSystem );

    factory.register( processSystemConfig );

}

}
