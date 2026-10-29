local ok, result = pcall(function()
	_G.APCSVERSION = "2.0.0"
	_G.filesystem = component.proxy(computer.getBootAddress())

	function _G.loadfile(file)
		local handle = assert(filesystem.open(file))
		local buffer = ""
		repeat
			local data = filesystem.read(handle, 2048)
			buffer = buffer .. (data or "")
		until not data
		filesystem.close(handle)
		
		local result, code_error = load(buffer, file)
		if result then
			return result
		else
			error(code_error or "Unkown err", 0)
		end
	end

	loadfile("/core/config.lua")(loadfile)
	loadfile("/core/tags.lua")(loadfile)
	
	for su_index, su in ipairs(_G.config.su) do
		_G.config.su[su] = true
		table.remove(_G.config.su, 1)
	end

	_G.drivers = {
		gen = {},
		FS = {},
		ES = {},
	}
	_G.libs = {}
	_G.modules = {}

	local function do_dir(path)
		for _, file in ipairs(filesystem.list(path)) do
		  loadfile(path .. "/" .. file)(loadfile)
		end
	end

	do_dir("/drivers")
	do_dir("/libs")
	do_dir("/modules")
	
	for _, driver_type in ipairs({"gen", "FS", "ES"}) do
		for driver_name in pairs(_G.drivers[driver_type]) do
			_G.drivers[driver_type][driver_name].get_elements()
		end
	end

	for APCS_module in pairs(modules) do
		_G.modules[APCS_module].init()
	end

	_G.tags.state = "O"
	local ok, result = pcall(function()
		loadfile("/main.lua")(loadfile)
	end)
	
	if not ok then
		computer.beep(1000, 0.2)
		if _G.config.reboot_with_error then
			computer.shutdown(true)
		else
			local err = {}
			if type(result) == "table" then
				err = result
			else
				err[1] = "ERR E-000: Unkown ERR (" .. tostring(result) .. ")"
				err[2] = 000
			end
			
			error({err[1], err[2]}, 0)
		end
	end
end)
if not ok then
	computer.beep(500, 0.2)
	
	local err = {}
	if type(result) == "table" then
		err = result
	else
		err[1] = "ERR E-000: Unkown ERR (" .. tostring(result) .. ")"
		err[2] = 000
	end
	
	error(err[1], 0)
else
	computer.shutdown()
end
