package bigbird.factories
{
import bigbird.components.SystemFactoryConfig;

import flash.utils.Dictionary;

import net.richardlord.ash.core.Game;

public class SingletonSystemFactory
{


    private const _systemMap:Dictionary = new Dictionary( false );

    private var _game:Game;


    public function SingletonSystemFactory( game:Game )
    {
        _game = game;
    }

    /**
     * Configures the factory with a Singleton System
     * @param config
     */
    public function register( config:SystemFactoryConfig ):void
    {
        if ( _systemMap[config.systemName] != null ) return;
        _systemMap[config.systemName] = config;
    }

    /**
     * Adds the system to the game on the next updateComplete
     * @param systemName as defined in the SystemFactoryConfig registered
     */
    public function addSystem( systemName:String ):void
    {
        if ( _systemMap[systemName] == null ) return;
        addSystemOnUpdateComplete( _systemMap[systemName] )
    }

    /**
     * Removes the system from the game on the next updateComplete
     * @param systemName as defined in the SystemFactoryConfig registered
     */
    public function removeSystem( systemName:String ):void
    {
        if ( _systemMap[systemName] == null ) return;
        removeSystemOnUpDateComplete( _systemMap[systemName] );
    }

    private function addSystemOnUpdateComplete( config:SystemFactoryConfig ):void
    {
        if ( _game.getSystem( config.systemClass ) != null )return;

        const onUpdateComplete:Function = function ():void
        {
            _game.addSystem( config.instance, config.priority );
            _game.updateComplete.remove( onUpdateComplete );
        }
        _game.updateComplete.add( onUpdateComplete );
    }

    private function removeSystemOnUpDateComplete( config:SystemFactoryConfig ):void
    {
        const onUpdateComplete:Function = function ():void
        {
            _game.removeSystem( config.instance );
            _game.updateComplete.remove( onUpdateComplete );
        }
        _game.updateComplete.add( onUpdateComplete );

    }

}
}
