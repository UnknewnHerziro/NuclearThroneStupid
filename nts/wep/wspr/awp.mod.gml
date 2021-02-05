#define init
global.sprr = sprite_add("awp.png",0,14,11)
global.aa = [1,1,1,1]
#define step
if(instance_exists(Player))
{
if(Player.gunangle > 90 && Player.gunangle < 270)
{
    global.aa = -1;
}
else
{
   global. aa = 1;
}
}
#define draw

if(instance_exists(Player))
{
for(i = 0;i < 4;i++)
{
    with (instances_matching(Player,"index",i))
    {
        if(wep == "killfeed")
        {
            
            with instance_create(x,y,CustomObject)
            {
                depth = 11
                draw_sprite_ext(global.sprr,0,other.x + lengthdir_x(-other.wkick, other.gunangle),
                other.y + lengthdir_y(- other.wkick, other.gunangle),1,other.right, other.gunangle,c_white,1)
                instance_destroy();
            }
        }
		/*
        if(bwep == "killfeed")
        {
            
            with instance_create(x,y,CustomObject)
            {
                depth = other.depth-0.01
                draw_sprite_ext(global.sprr,0, other.x, other.y,1,other.right,75,c_gray,1)
                instance_destroy();
            }
        }
		*/
       
    }
}    

    }


with(instances_matching(WepPickup,"wep","killfeed"))
	{draw_sprite_ext(global.sprr,0, x, y,1,1,45,c_white,1)}