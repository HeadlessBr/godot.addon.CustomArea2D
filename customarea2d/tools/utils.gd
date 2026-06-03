

@tool
	#########/////////////////// ARRAY
static func array_has_any( arr_a, arr_b ) -> bool:
	for a_val in arr_a :
		if arr_b.has( a_val ) :
			return true
	return false
static var array_abbreviate_names_length : int = 3
static func array_abbreviate_names( arr_a : Array[String] ) :
	var r_arr : Array = []
	
	for a_val : String in arr_a:
		r_arr.append( a_val.substr(0, array_abbreviate_names_length ) )
		
	return r_arr 
