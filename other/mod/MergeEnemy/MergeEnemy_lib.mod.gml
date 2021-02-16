
#define init
	{
	global.lwo_data_lib	= {}
	global.aryInitDir	= [``, ``, 0, 0]
	global.aryInitBody	= [noone, noone, 1]
	
	scrInitParts()
	}



#define scrInitParts
	{
	init_part(`Body`)
		{
		init_body(`RhinoFreak`, 24, 24)
			{
			data_add_body(`idle`, 9)
				{
				data_body_offset
					(`Head`, 
					[	2,	2,	2,	2,	1,	1,	1,	1,	2,	], 
					[	0,	0,	0,	0,	-1,	-1,	-1,	-1,	-1,	], 
					)
				data_body_offset
					(`ArmA`, 
					[	-8,	-8,	-8,	-8,	-9,	-9,	-9,	-9,	-8,	], 
					0, 
					)
				}
			
			data_add_body(`walk`, 10)
				{
				data_body_offset
					(`Head`, 
					[	3,	3,	3,	2,	2,	3,	3,	3,	2,	2,	], 
					[	-1,	1,	0,	0,	-1,	-1,	1,	0,	0,	-1,	], 
					)
				data_body_offset
					(`ArmA`, 
					[	-7,	-7,	-7,	-8,	-8,	-7,	-7,	-7,	-8,	-8,	], 
					[	-1,	1,	0,	0,	-1,	-1,	1,	0,	0,	-1,	], 
					)
				}
			
			data_add_body(`hurt`, 3)
				{
				data_body_offset
					(`Head`,	2,	0)
				data_body_offset
					(`ArmA`,	-8,	0)
				}
			}
		}
	
	init_part(`Head`)
		{
		init_blank()
		
		init_name(`RhinoFreak`, 26, 24)
			data_add(1, 1, 3)
		
		}
	
	init_part(`ArmA`)
		{
		init_blank()
		
		init_name(`RhinoFreak`, 16, 24)
			data_add(9, 10, 3)
		
		}
	}



#define init_part	mcrPart = argument0
#define init_name	mcrName = argument0; mcrXos = argument1; mcrYos = argument2

#define init_blank
	{
	with(data_lib)
		{
		with(lq_check(self, mcrPart))
			{lq_set(self, "blank", null)}
		}
	}



#define data_add
	{
	with([[]])
		{
		data_add_step(`idle`, argument0)
		data_add_step(`walk`, argument1)
		data_add_step(`hurt`, argument2)
		data_add_ext(mcrPart, mcrName, self)
		}
	}

#define data_add_step(_spr, _num)
	{
	/*
		_spr	[string]	: state (idle, walk, ...) 
		_num	[int]		: image_number 
		
		should be called by data_add() function. 
	*/
	array_push(self, 
		[
			`spr_${_spr}`, 
			sprite_add(`${mcrPart}/${mcrName}/${_spr}.png`, _num, mcrXos, mcrYos), 
		/*	mcrXos, 
			mcrYos, */
		])
	}

#define data_add_uni(_part, _name, _ary, _xos, _yos)
	{
	/*
		_part	[string]		: ("Head", "Body", "ArmA", "ArmB", ...) 
		_name	[string]		: 
		_ary	[array]			: include datas of each state. should be arrays in a array. ([state, sprite_index, xoffset, yoffset]) 
		_xos	[real/array]	: xoffset 
		_yos	[real/array]	: yoffset 
		
		same as data_add_ext() function but the offsets are in the same numbers. 
	*/
	var _array = []
	
	with(_ary)
		{array_push(_array, [self[@0], self[@1], _xos, _yos])}
	
	data_add_ext(_part, _name, _array)
	}

#define data_add_ext(_part, _name, _ary)
	{
	/*
		_part	[string]	: ("Head", "Body", "ArmA", "ArmB", ...) 
		_name	[string]	: 
		_ary	[array]		: include datas of each state. should be arrays in a array. ([state, sprite_index, xoffset, yoffset]) 
		
		add a new sprites data to a part of data_lib. 
	*/
	
	var _dat = {}
	
	with(_dat)
		{
		with(_ary)
			{data_add_state(self[@0], self[@1])}
		//	{data_add_state(self[@0], self[@1], self[@2], self[@3])}
		}
	
	with(data_lib)
		{
		with(lq_check(self, _part))
			{lq_set(self, _name, _dat)}
		}
	}

#define data_add_state(_state, _spr)
	{
	/*
		_state	[string]		: (spr_idle, spr_walk, ...) 
		_spr	[int]			: sprite_index 
		_xos	[real/array]	: xoffset 
		_yos	[real/array]	: yoffset 
		
		set state to a new lightweight-object( _dat) with sprite_index and offsets. 
		
		should be called by arrays in a data array. 
		other should be a lightweight-object about one enemy sprite data. 
	*/
	
	var _dat = {sprite_index: _spr}
	
	with(_dat)
		{
		var _num	= sprite_get_number(_spr)
		
	//	data_offset("x", _xos, _num, sprite_get_xoffset(_spr))
	//	data_offset("y", _yos, _num, sprite_get_yoffset(_spr))
		}
	
	lq_set(other, _state, _dat)
	}

#define data_offset(_typ, _os, _num, _osb)
	{
	/*
		_typ	[string]		: x or y 
		_os		[real/array]	: offset number 
		_num	[int]			: image_number 
		_osb	[real]			: default offset 
		
		set offset to one part. 
		if it's a real number, just set offset to the number. 
		if it's an array and its length is right the sprite_number, set offset to the array. 
		otherwise( something wrong here), set offset to default offset. 
		
		should be called in data_add_state() function. 
	*/
	
	if(is_real(_os))
		{
		lq_set(self, `${_typ}offset`, _os)
		lq_set(self, `${_typ}offary`, false)
		exit
		}
	if(array_length(_os) == _num)
		{
		lq_set(self, `${_typ}offset`, _os)
		lq_set(self, `${_typ}offary`, true)
		exit
		}
	
	lq_set(self, `${_typ}offset`, _osb)
	lq_set(self, `${_typ}offary`, false)
	}



#define init_body
	{
	/*
		create a new body. 
		set the name of init. 
	*/
	init_name(argument0, argument1, argument2)
	
	with(data_lib)
		{
		with(lq_check(self, mcrPart))
			{
			with(lq_check(self, mcrName))
				{mcrBody = self}
			}
		}
	}

#define data_add_body(_state, _num)
	{
	/*
		_state	[string]	: (idle, walk, ...) 
		_num	[int]		: image_number 
		
		add a new sprites data to a body of data_lib. 
	*/
	with(mcrBody)
		{
		with(lq_check(self, `spr_${_state}`))
			{
			sprite_index = sprite_add(`${mcrPart}/${mcrName}/${_state}.png`, _num, mcrXos, mcrYos)
			
		//	data_offset("x", mcrXos, _num, mcrXos)
		//	data_offset("y", mcrYos, _num, mcrYos)
			
			mcrState	= self
			mcrNum		= _num
			}
		}
	}

#define data_body_offset(_part, _xos, _yos)
	{
	/*
		_part	[string]	: ("Head", "ArmA", "ArmB", ...) 
		_xos	[real/array]	: xoffset 
		_yos	[real/array]	: yoffset 
		
		set offsets to a part in a body of data_lib, 
		to change offsets when the given part on the given body. 
	*/
	with(mcrState)
		{
		var _spr = sprite_index
		with(lq_check(self, "Pos"))
			{
			with(lq_check(self, _part))
				{
				data_offset("x", _xos, mcrNum, sprite_get_xoffset(_spr))
				data_offset("y", _yos, mcrNum, sprite_get_yoffset(_spr))
				}
			}
		}
	}



#define lq_check	if(argument1!in argument0){lq_set(argument0, argument1, {})}; return lq_get(argument0, argument1)



#macro	data_lib	global.lwo_data_lib

#macro	mcrPart		global.aryInitDir[@0]
#macro	mcrName		global.aryInitDir[@1]
#macro	mcrXos		global.aryInitDir[@2]
#macro	mcrYos		global.aryInitDir[@3]

#macro	mcrBody		global.aryInitBody[@0]
#macro	mcrState	global.aryInitBody[@1]
#macro	mcrNum		global.aryInitBody[@2]

