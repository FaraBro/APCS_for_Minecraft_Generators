_G.modules.remote = {}
_G.tags.remote = {}

function _G.modules.remote.send(address, message, encrypt)
	encrypt = encrypt or true
	if _G.config.remote.encrypting and _G.config.remote.AES_keys[event[3]] and encrypt then
		local iv = _G.tags.remote.data_card.random(16)
		message = iv .. _G.tags.remote.data_card.encrypt(message, _G.config.remote.AES_keys[event[3]], iv)
	end
	
	_G.tags.remote.modem.send(address, _G.config.remote.controller_port, message)
end

function _G.modules.remote.process_message(event)
	local ok, result = pcall(function(event)
		local message
		
		local ok, message = pcall(function()
			if _G.config.remote.encrypting and _G.config.remote.AES_keys[event[3]] then
				local iv = string.sub(event[6], 1, 16)
				message = string.sub(event[6], 17)
				message = _G.tags.remote.data_card.decrypt(message, _G.config.remote.AES_keys[event[3]], iv)
			else
				message = event[6]
			end
			
			return message
		end)
		if not ok then _G.modules.remote.send(event[3], "Err E-201", false) return end
		
		message_gmatch = string.gmatch(message, "%S+")
		
		commands = {}
		for command in message_gmatch do
			table.insert(commands, command)
		end
		
		if commands[1] == "get_data" then
			error("HELP")
		elseif commands[1] == "set_state" then
			_G.set_state(commands[2], event[3], _G.config.remote.unauthorized_mashines_can.set_state, _G.config.remote.unauthorized_mashines_can.reset_state, _G.config.remote.authorized_mashines)
		end
	end, event)
end

function _G.modules.remote.init()
	_G.config.remote.authorized_mashines = _G.set_value_for_every_element(_G.config.remote.authorized_mashines, true)
	
	if _G.config.remote.encrypting then
		local data
		
		for address in component.list("data") do
			data = component.proxy(address)
			if data.encrypt then
				_G.tags.remote.data_card = data
				break
			end
		end
		assert(_G.tags.remote.data_card, {"ERR E-110: Data Card hasn't been searched, but encrypting is enabled", 110})
		
		for addr in pairs(_G.config.remote.AES_keys) do
			_G.config.remote.AES_keys[addr] = _G.tags.remote.data_card.decode64(_G.config.remote.AES_keys[addr])
			assert(#_G.config.remote.AES_keys[addr] == 16, {"Err E-112:\n  addr: " .. addr, 112})
		end
	end
	
	local function inspect_port(port)
		assert(port > 0 and port < 65536, {"ERR E-111: Unvalid Port", 111})
	end
	
	inspect_port(_G.config.remote.control_port)
	inspect_port(_G.config.remote.controller_port)
	
	-- DEV
	-- TODO: Make Modems Driver
	modem = component.proxy(component.list("modem")())
	if modem then modem.open(_G.config.remote.control_port) end
end
