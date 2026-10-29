-- Pre-Cycle Actions

-- Назначаем переменные
local mode
local elements_count
local all_storage
local all_max_storage
local all_storage_for_gen
local all_max_storage_for_gen
local event = {}
local reset_M

-- Main Cycle

local function stop_all_gens()
	for gen_driver in pairs(_G.drivers.gen) do
		local elements_count = #_G.tags.gen[gen_driver].elements
		for gen_index = 1, elements_count do
			_G.drivers.gen[gen_driver].set_throttle(gen_index, 0)
			_G.drivers.gen[gen_driver].stop(gen_index)
			_G.tags.gen[gen_driver].data[gen_index].state = "S"
		end
	end
end

local function check_user_perms(doing, user, perm_table)
	local perm_table = perm_table or _G.config.users_can_use
	if _G.config.su[user] then
		return true
	else
		return _G.config.users_can_use[doing]
	end
end

while true do
	reset_M = false
	if event.n then
		if event.n == 5 then
			if event[1] == "key_down" then
				if _G.tags.state ~= "E" then
					if event[3] == 101 and event[4] == 18 and check_user_perms("E", event[5]) then
						_G.tags.state = "E"
						stop_all_gens()
						computer.beep(500)
					elseif event[3] == 109 and event[4] == 50 and _G.tags.state ~= "M" and check_user_perms("M", event[5]) then
						_G.tags.state = "M"
						computer.beep(1000)
					elseif event[3] == 99 and event[4] == 46 and check_user_perms("C", event[5]) then
						stop_all_gens()
						computer.beep(1000, 0.2)
						break
					end
				end
				if event[3] == 111 and event[4] == 24 and check_user_perms(_G.tags.state, event[5], _G.config.users_can_use.P) then
					_G.tags.state = "O"
					reset_M = true
					computer.beep(1500)
				end
			end
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
