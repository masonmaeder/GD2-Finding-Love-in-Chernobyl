if ( !collision_line( x, y, obj_player.x, obj_player.y, obj_wall, false, false ) )
{
    // Line of sight is not obstructed by a wall
	game_restart()
}