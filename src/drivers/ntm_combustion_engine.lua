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

function _G.drivers.gen.ntm_combustion_engine.get_data_individual(element)
	_G.tags.gen.ntm_combustion_engine.data[element].fluid, _G.tags.gen.ntm_combustion_engine.data[element].max_fluid = _G.tags.gen.ntm_combustion_engine.elements[element].getFluid()
	_G.tags.gen.ntm_combustion_engine.data[element].fluid_type = _G.tags.gen.ntm_combustion_engine.elements[element].getType()
	_G.tags.gen.ntm_combustion_engine.data[element].working = _G.tags.gen.ntm_combustion_engine.elements[element].getState()
	_G.tags.gen.ntm_combustion_engine.data[element].throttle = _G.tags.gen.ntm_combustion_engine.elements[element].getThrottle()*10//3
end

function _G.drivers.gen.ntm_combustion_engine.get_data()
	local elements_count = #_G.tags.gen.ntm_combustion_engine.elements
	if elements_count > 0 then
		for index = 1, elements_count do
			_G.drivers.gen.ntm_combustion_engine.get_data_individual(index)
		end
	end
end

function _G.drivers.gen.ntm_combustion_engine.set_throttle_individual(element, throttle)
	_G.tags.gen.ntm_combustion_engine.elements[element].setThrottle(throttle//10*3)
end

function _G.drivers.gen.ntm_combustion_engine.set_throttle(throttle)
	local elements_count = #_G.tags.gen.ntm_combustion_engine.elements
	if elements_count > 0 then
		for index = 1, elements_count do
			_G.drivers.gen.ntm_combustion_engine.set_throttle_individual(index, throttle)
		end
	end
end

function _G.drivers.gen.ntm_combustion_engine.start_individual(element)
	_G.tags.gen.ntm_combustion_engine.elements[element].start()
end

function _G.drivers.gen.ntm_combustion_engine.start()
	local elements_count = #_G.tags.gen.ntm_combustion_engine.elements
	if elements_count > 0 then
		for index = 1, elements_count do
			_G.drivers.gen.ntm_combustion_engine.start_individual(index)
		end
	end
end

function _G.drivers.gen.ntm_combustion_engine.stop_individual(element)
	_G.tags.gen.ntm_combustion_engine.elements[element].stop()
end

function _G.drivers.gen.ntm_combustion_engine.stop()
	local elements_count = #_G.tags.gen.ntm_combustion_engine.elements
	if elements_count > 0 then
		for index = 1, elements_count do
			_G.drivers.gen.ntm_combustion_engine.stop_individual(index)
		end
	end
end
