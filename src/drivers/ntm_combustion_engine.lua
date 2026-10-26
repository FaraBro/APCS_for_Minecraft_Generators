_G.tags.gen.ntm_combustion_engine = {
	data = {},
	elements = {},
}
_G.drivers.gen.ntm_combustion_engine = {}

function _G.drivers.gen.ntm_combustion_engine.get_elements()
	local defalut_ext = {
		mode = _G.config.mode,
	}
	if _G.config.auto_search_gens then
		index = 1
		for address in component.list("ntm_combustion_engine") do
			_G.tags.gen.ntm_combustion_engine.elements[index] = component.proxy(address)
			_G.tags.gen.ntm_combustion_engine.data[index] = defalut_ext
			index = index + 1
		end
	else
		for index, address, ext in ipairs(_G.config.manual_gens_address_table) do
			local ok, result = pcall(function(address)
				local element = component.proxy(address)
				assert(element.type == "ntm_combustion_engine", "Unvalid gen address")
				return element
			end, address)
			if ok then
				_G.tags.gen.ntm_combustion_engine.elements[index] = result
				if type(ext) == "table" then
					_G.tags.gen.ntm_combustion_engine.data[index] = ext
				else
					_G.tags.gen.ntm_combustion_engine.data[index] = defalut_ext
				end
			end
		end
	end
end

function _G.drivers.gen.ntm_combustion_engine.get_data()
	for index, element in ipairs(_G.tags.gen.ntm_combustion_engine.elements) do
		_G.tags.gen.ntm_combustion_engine.data[index].max_fluid, _G.tags.gen.ntm_combustion_engine.data[index].fluid = element.getFluid()
		_G.tags.gen.ntm_combustion_engine.data[index].working = element.getState()
		_G.tags.gen.ntm_combustion_engine.data[index].throttle = element.getThrottle()*10//3
	end
end

function _G.drivers.gen.ntm_combustion_engine.set_throttle(throttle)
	for element in pairs(_G.tags.gen.ntm_combustion_engine.elements) do
		_G.tags.gen.ntm_combustion_engine.elements[element].setThrottle(throttle//10*3)
	end
end

function _G.drivers.gen.ntm_combustion_engine.start()
	for element in pairs(_G.tags.gen.ntm_combustion_engine.elements) do
		_G.tags.gen.ntm_combustion_engine.elements[element].start()
	end
end

function _G.drivers.gen.ntm_combustion_engine.stop()
	for element in pairs(_G.tags.gen.ntm_combustion_engine.elements) do
		_G.tags.gen.ntm_combustion_engine.elements[element].stop()
	end
end
