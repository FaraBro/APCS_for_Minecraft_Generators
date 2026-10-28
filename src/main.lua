-- Pre-Cycle Actions

-- Назначаем переменные
local mode
local elements_count
local all_storage
local all_max_storage
local all_storage_for_gen
local all_max_storage_for_gen

-- Main Cycle

while true do
	if _G.config.mode == 1 then
		all_storage = {}
		all_max_storage = {}
		for FS_driver in pairs(_G.drivers.FS) do
			FS_count = #_G.tags.FS[FS_driver].elements
			if FS_count > 0 then
				for FS_index = 1, FS_count do
					_G.drivers.FS[FS_driver].get_data_individual(FS_index)
					all_max_storage[_G.tags.FS[FS_driver].data[FS_index].fluid_type] = all_max_storage[_G.tags.FS[FS_driver].data[FS_index].fluid_type] or 0 + _G.tags.FS[FS_driver].data[FS_index].max_fluid
					all_storage[_G.tags.FS[FS_driver].data[FS_index].fluid_type] = all_storage[_G.tags.FS[FS_driver].data[FS_index].fluid_type] or 0 + _G.tags.FS[FS_driver].data[FS_index].fluid
				end
			end
		end
	elseif _G.config.mode == 2 then
		all_storage = 0
		all_max_storage = 0
		for ES_driver in pairs(_G.drivers.ES) do
			ES_count = #_G.tags.ES[ES_driver].elements
			if ES_count > 0 then
				for ES_index = 1, ES_count do
					_G.drivers.ES[ES_driver].get_data_individual(ES_index)
					all_max_storage = all_max_storage + _G.tags.ES[ES_driver].data[ES_index].max_power
					all_storage = all_storage + _G.tags.ES[ES_driver].data[ES_index].power
				end
			end
		end
	end
	
	for gen_diver in pairs(_G.drivers.gen) do
		elements_count = #_G.tags.gen[gen_diver].elements
		if elements_count > 0 then
			for gen_index = 1, elements_count do
				_G.drivers.gen[gen_diver].get_data_individual(gen_index)
				
				mode = _G.tags.gen[gen_diver].data[gen_index].mode or _G.config.mode
				if mode == 1 then
					all_storage_for_gen = all_storage[_G.tags.gen[gen_diver].data[gen_index].fluid_type]
					all_max_storage_for_gen = all_max_storage[_G.tags.gen[gen_diver].data[gen_index].fluid_type]
				elseif mode == 2 then
					all_storage_for_gen = all_storage
					all_max_storage_for_gen = all_max_storage
				end
				
				_G.modules.pid.control[mode](gen_diver, gen_index, all_storage_for_gen, all_max_storage_for_gen)
			end
		end
	end
	
	computer.pullSignal(_G.config.time_sleep)
end
