package bigbird.controller
{

import net.richardlord.ash.core.Entity;
import net.richardlord.ash.core.Game;
import net.richardlord.ash.core.System;

public class Removals
{
    private var _game:Game;


    public function Removals( game:Game )
    {
        _game = game;
    }

    public function removeEntity( entity:Entity ):void
    {
        _game.removeEntity( entity );
    }

    public function removeSystem( system:System ):void
    {
        _game.removeSystem( system );
    }
}
}
