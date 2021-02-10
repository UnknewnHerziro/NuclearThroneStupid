
#define init
	{
	global.lwo_data_lib = {}
	global.aryInitDir = [``, ``, 0, 0]
	
	init_part(`Head`)
		init_name(`RhinoFreak`, 24, 24)
			data_add(1, 1, 3)
	
	}

#define init_part	mcrPart = argument0
#define init_name	mcrName = argument0; mcrXos = argument1; mcrYos = argument2



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
			mcrXos, 
			mcrYos
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
			{data_add_state(self[@0], self[@1], self[@2], self[@3])}
		}
	
	with(data_lib)
		{
		if(_part!in self)
			{lq_set(self, _part, {})}
		
		with(lq_get(self, _part))
			{lq_set(self, _name, _dat)}
		}
	}

#define data_add_state(_state, _spr, _xos, _yos)
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
		
		data_offset("x", _xos, _num, sprite_get_xoffset(_spr))
		data_offset("y", _yos, _num, sprite_get_yoffset(_spr))
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



#macro	data_lib	global.lwo_data_lib
#macro	mcrState	[`idle`, `walk`, `hurt`]
#macro	mcrPart		global.aryInitDir[@0]
#macro	mcrName		global.aryInitDir[@1]
#macro	mcrXos		global.aryInitDir[@2]
#macro	mcrYos		global.aryInitDir[@3]

