package bigbird.configuration
{
import bigbird.components.BigBirdProgress;
import bigbird.components.SystemFactoryConfig;
import bigbird.factories.*;
import bigbird.systems.DecodeFromWordFile;
import bigbird.systems.DecodeSystem;
import bigbird.systems.DecodingProgress;
import bigbird.systems.DispatchDecodedSystem;
import bigbird.systems.LoadProgressSystem;
import bigbird.systems.SystemName;
import bigbird.systems.SystemPriority;

import net.richardlord.ash.core.System;

public function configureSingletonSystemFactory( factory:SingletonSystemFactory, bigbird:BigBird ):void
{
    const createDecodeSystem:Function = function ():System
    {
        return new DecodeSystem( new DecodeFromWordFile( bigbird.game ) );
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

    const progress:BigBirdProgress = new BigBirdProgress( bigbird.onProgress );

    const createLoadProcessSystem:Function = function ():System
    {
        return new LoadProgressSystem( progress );
    }

    const loadProcessSystemConfig:SystemFactoryConfig = new SystemFactoryConfig(
            SystemName.LOAD_PROGRESS,
            LoadProgressSystem,
            SystemPriority.PROGRESS_SYSTEM,
            createLoadProcessSystem );

    factory.register( loadProcessSystemConfig );


    const createDecodingProcessSystem:Function = function ():System
    {
        return new DecodingProgress( progress );
    }

    const decodeProcessSystemConfig:SystemFactoryConfig = new SystemFactoryConfig(
            SystemName.DECODE_PROGRESS,
            DecodingProgress,
            SystemPriority.PROGRESS_SYSTEM,
            createDecodingProcessSystem );

    factory.register( decodeProcessSystemConfig );

}

}
