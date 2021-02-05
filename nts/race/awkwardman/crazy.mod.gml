#define step
with(instances_matching(Player,"race","awkwardman"))
{
if(GameCont.loops >= 3)
{
    with (enemy) { if ("my_health"in self)   
    {
       if(my_health <= 0 && object_index != PopoFreak && object_index != Freak)
        {
            if(object_index == EliteShielder){instance_create(x,y,Shielder)};
            if(object_index == GoldSnowTank)
            {instance_create(x,y,SnowTank)
            };
            if(object_index == DogGuardian){instance_create(x,y,ExploGuardian);};
            if(irandom(30 + GameCont.loops*2) == 0)
            {
                instance_create(x,y,WantVan);
                a = instance_create(x,y,PopupText);
                a.mytext = "SPECIAL DELIVERY";
                
            }
            if(irandom(10+ GameCont.loops*3) == 0)
            {
                GameCont.hard +=1;
                with projectile speed +=1;
                a = instance_create(x,y,PopupText);
                a.mytext = "REVENGE";
                
            }
            if(irandom(12) == 0)
            {
                repeat(irandom_range(12,25))
                {
                    with instance_create(x,y,EnemyBullet1)
                    {
                        speed = 4;
                        direction =irandom(360);
                        image_angle = direction;
                        team = other.team;
                        creator=object_index;
                        dup = 1;
                    }
                }
            }
        }
        if("buff" not in self)
        {
            if(irandom(15) == 0)
            {
                my_health *=2;
                image_xscale = 1.25;
                image_yscale = 1.25;
            }
            buff = 1;
        }
        if("spawn" not in self && object_index != Freak && object_index != PopoFreak)
        {
            if(irandom(15) == 0)
            {
                a = instance_create(x,y,choose(EliteShielder,DogGuardian,GoldSnowTank));
                a.spawn = 1;
            }
            spawn = 1;
        }
       
    }}
    with (projectile)
    {
        if("acc" not in self){speed += 2; acc = 1;}
        if("dup" not in self && team == 1)
        {
            if(irandom(5) == 0)
            {
                with instance_create(x,y,EnemyBullet1)
				{
					speed += (other.speed+random_range(0,1))
					direction =irandom(360);
					image_angle = direction;
					team = other.team;
					creator=other.creator;
					dup = 1;
				}
            }
            dup = 1;
        }
    }
}
}