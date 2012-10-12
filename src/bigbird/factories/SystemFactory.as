package bigbird.factories
{
import bigbird.components.SystemFactoryConfig;
import bigbird.systems.DecodeFromRawDocument;
import bigbird.systems.DecodeSystem;

import flash.utils.Dictionary;

import net.richardlord.ash.core.Game;
import net.richardlord.ash.core.System;

public class SystemFactory
{


    private const _systemMap:Dictionary = new Dictionary( false );

    private var _game:Game;


    public function SystemFactory( game:Game )
    {
        _game = game;
    }

    public function register( config:SystemFactoryConfig ):void
    {
        if ( _systemMap[config.systemName] != null ) return;
        _systemMap[config.systemName] = config;
    }

    public function addSystem( systemName:String ):void
    {
        if ( _systemMap[systemName] == null ) return;
        addSystemOnUpdateComplete( _systemMap[systemName] )
    }

    public function removeSystem( systemName:String ):void
    {
        if ( _systemMap[systemName] == null ) return;
        removeSystemOnUpDateComplete( _systemMap[systemName] );
    }

    internal function addSystemOnUpdateComplete( config:SystemFactoryConfig ):void
    {
        if ( _game.getSystem( config.systemClass ) != null )return;

        const onUpdateComplete:Function = function ():void
        {
            _game.addSystem( config.instance, config.priority );
            _game.updateComplete.remove( onUpdateComplete );
        }
        _game.updateComplete.add( onUpdateComplete );
    }

    internal function removeSystemOnUpDateComplete( config:SystemFactoryConfig ):void
    {
        const onUpdateComplete:Function = function ():void
        {
            _game.removeSystem( config.instance );
            _game.updateComplete.remove( onUpdateComplete );
        }
        _game.updateComplete.add( onUpdateComplete );

    }

    private function decodeSystemFactoryMethod():System
    {
        return new DecodeSystem( new DecodeFromRawDocument( _game ) );
    }


}
}
