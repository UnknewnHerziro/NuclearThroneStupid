
#define area_transit
	{
	if("nts_lastarea"!in self)
		{
		nts_lastarea = area
		nts_lastsubarea = subarea
		}
//	if(scrCanGo(3, 2, 3, 3, "market")){areaM = 3; areaMs = 3}
//	if(scrCanGo(7, 2, 7, 3, "market")){areaM = 7; areaMs = 3}
	if(nts_CustomArea)
		{scrGoWhere()}
	nts_lastarea = area
	nts_lastsubarea = subarea
	
	scrUnlock()
	}



#define scrGoWhere
	{
	scrCanGo(1, 3, 2, 1, "dungeon")
	
	if(mod_exists("mod", "NT3D"))
		{
		
		}
	else{
		scrCanGo(103, 1, 3, 3, "mansion")
		}
	
	if(mod_exists("mod", "ntte"))
		{
		scrCanGo("pizza", 1, 3, 1, "ruins")
		//scrCanGo("lair", 1, 3, 1, "ruins")
		}
	else{
		if(mod_exists("mod", "NT3D"))
			{
			
			}
		else{
			if(GameCont.loops == 0)
				{
				scrCanGo(101, 1, 3, 3, "parad")
				scrCanGo(105, 1, 6, 1, "grove")
				}
			else{
				
				}
			scrCanGo(5, 3, 6, 1, "outlab")
			}
		scrCanGo(102, 1, 3, 1, "ruins")
		}
	}

#define scrCanGo(la, lsa, a, sa, na)
	{
	if(nts_lastarea==la && nts_lastsubarea==lsa && area==a && subarea==sa)
		{
		area = na
		subarea = 1
		return true
		}
	else{return false}
	}



#define scrUnlock
	{
	if(area == 102)
		{mod_script_call("mod", "ntsCont", "scrCharUnlock", "Coward")}
	}
