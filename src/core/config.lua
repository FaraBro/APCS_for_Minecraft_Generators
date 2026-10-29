_G.config = {
	mode = 1,
	modes_config = {
		Y_max = 60,
		Y_min = 45,
		gen_start = 60,
		gen_stop = 45,
		
		auto_search_FS = true,
		manual_FS_address_table = {},
		
		auto_search_ES = true,
		manual_ES_address_table = {},
	},
	
	auto_search_gens = true,
	manual_gens_address_table = {},
	
	reboot_with_err = true,
	time_sleep = 2.5,
	
	su = {"FaraBro"},
	users_can_use = {
		E = true,
		M = true,
		C = false,
		P = {
			E = false,
			M = true,
			O = true,
		},
	},
}
