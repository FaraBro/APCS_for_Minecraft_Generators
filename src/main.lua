-- Pre-Cycle Actions

-- Var
local mode
local elements_count
local all_storage
local all_max_storage
local all_storage_for_gen
local all_max_storage_for_gen
local event = {}
local reset_M
local keys = {
	[18] = "E",
	[24] = "O",
	[46] = "C",
	[50] = "M",
}

-- Func

function _G.stop_all_gens()
	for gen_driver in pairs(_G.drivers.gen) do
		local elements_count = #_G.tags.gen[gen_driver].elements
		for gen_index = 1, elements_count do
			_G.drivers.gen[gen_driver].set_throttle(gen_index, 0)
			_G.drivers.gen[gen_driver].stop(gen_index)
			_G.tags.gen[gen_driver].data[gen_index].state = "S"
		end
	end
end

function _G.check_perms(doing, user, perm_table, su_table)
	if su_table[user] then
		return true
	else
		return perm_table[doing]
	end
end

function _G.set_state(state, user, perm_table, perm_reset_table, su_table)
	if _G.tags.state ~= "E" then
		if state == "E" and _G.check_perms("E", user, perm_table, su_table) then
			_G.tags.state = "E"
			_G.stop_all_gens()
			computer.beep(500)
		elseif state == "M" and _G.tags.state ~= "M" and _G.check_perms("M", user, perm_table, su_table) then
			_G.tags.state = "M"
			computer.beep(1000)
		elseif state == "C" and _G.check_perms("C", user, perm_table, su_table) then
			_G.stop_all_gens()
			computer.beep(1000, 0.2)
			computer.shutdown()
		end
	end
	if state == "O" and _G.check_perms(_G.tags.state, user, perm_reset_table, su_table) then
		_G.tags.state = "O"
		reset_M = true
		computer.beep(1500)
	end
end

-- Main Cycle

while true do
	reset_M = false
	if event.n then
		if event[1] == "key_up" then
			_G.set_state(keys[event[4]], event[5], _G.config.users_can_use, _G.config.users_can_use.O, _G.config.su)
		elseif event[1] == "modem_message" then
			_G.modules.remote.process_message(event)
		end
	end
	
	if _G.config.mode == 1 then
		all_storage = {}
		all_max_storage = {}
		for FS_driver in pairs(_G.drivers.FS) do
			FS_count = #_G.tags.FS[FS_driver].elements
			if FS_count > 0 then
				for FS_index = 1, FS_count do
					_G.drivers.FS[FS_driver].get_data(FS_index)
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
					_G.drivers.ES[ES_driver].get_data(ES_index)
					all_max_storage = all_max_storage + _G.tags.ES[ES_driver].data[ES_index].max_power
					all_storage = all_storage + _G.tags.ES[ES_driver].data[ES_index].power
				end
			end
		end
	end
	
	for gen_driver in pairs(_G.drivers.gen) do
		elements_count = #_G.tags.gen[gen_driver].elements
		if elements_count > 0 then
			for gen_index = 1, elements_count do
				_G.drivers.gen[gen_driver].get_data(gen_index)
				
				if _G.tags.state == "E" then
					_G.drivers.gen[gen_driver].stop(gen_index)
					_G.tags.gen[gen_driver].data[gen_index].state = "S"
				else
					-- Generator State
					if _G.tags.gen[gen_driver].data[gen_index].state or reset_M then
						if _G.tags.gen[gen_driver].data[gen_index].working then
							_G.tags.gen[gen_driver].data[gen_index].state = "W"
						else
							_G.tags.gen[gen_driver].data[gen_index].state = "S"
						end
					elseif _G.tags.gen[gen_driver].data[gen_index].working and _G.tags.gen[gen_driver].data[gen_index].state == "S" or not _G.tags.gen[gen_driver].data[gen_index].working and _G.tags.gen[gen_driver].data[gen_index].state == "W" then
						_G.tags.gen[gen_driver].data[gen_index].state = "M"
					end
					
					if _G.tags.gen[gen_driver].data[gen_index].state ~= "M" and _G.tags.state ~= "M" then
						-- PID Mode
						mode = _G.tags.gen[gen_driver].data[gen_index].mode or _G.config.mode
						if mode == 1 then
							all_storage_for_gen = all_storage[_G.tags.gen[gen_driver].data[gen_index].fluid_type]
							all_max_storage_for_gen = all_max_storage[_G.tags.gen[gen_driver].data[gen_index].fluid_type]
						elseif mode == 2 then
							all_storage_for_gen = all_storage
							all_max_storage_for_gen = all_max_storage
						end
						
						-- PID
						err = _G.modules.pid.control[mode](gen_driver, gen_index, all_storage_for_gen, all_max_storage_for_gen)
					end
				end
			end
		end
	end
	
	event = table.pack(computer.pullSignal(_G.config.time_sleep))
end
