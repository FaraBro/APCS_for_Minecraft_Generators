_G.tags.gen.ntm_gas_turbine = {
	data = {},
	elements = {},
}
_G.drivers.gen.ntm_gas_turbine = {}

function _G.drivers.gen.ntm_gas_turbine.get_elements()
	local defalut_ext = {
		mode = _G.config.mode,
	}
	if _G.config.auto_search_gens then
		index = 1
		for address in component.list("ntm_gas_turbine") do
			_G.tags.gen.ntm_gas_turbine.elements[index] = component.proxy(address)
			_G.tags.gen.ntm_gas_turbine.data[index] = defalut_ext
			index = index + 1
		end
	else
		for index, address, ext in ipairs(_G.config.manual_gens_address_table) do
			local ok, result = pcall(function(address)
				local element = component.proxy(address)
				assert(element.type == "ntm_gas_turbine", "Unvalid gen address")
				return element
			end, address)
			if ok then
				_G.tags.gen.ntm_gas_turbine.elements[index] = result
				if type(ext) == "table" then
					_G.tags.gen.ntm_gas_turbine.data[index] = ext
				else
					_G.tags.gen.ntm_gas_turbine.data[index] = defalut_ext
				end
			end
		end
	end
end

function _G.drivers.gen.ntm_gas_turbine.get_data_individual(element)
	_G.tags.gen.ntm_gas_turbine.data[element].fluid, _G.tags.gen.ntm_gas_turbine.data[element].max_fluid = _G.tags.gen.ntm_gas_turbine.elements[element].getFluid()
	_G.tags.gen.ntm_gas_turbine.data[element].fluid_type = _G.tags.gen.ntm_gas_turbine.elements[element].getType()
	_G.tags.gen.ntm_gas_turbine.data[element].working = _G.tags.gen.ntm_gas_turbine.elements[element].getState() == 1 or true and false
	_G.tags.gen.ntm_gas_turbine.data[element].throttle = _G.tags.gen.ntm_gas_turbine.elements[element].getThrottle()
end

function _G.drivers.gen.ntm_gas_turbine.get_data()
	local elements_count = #_G.tags.gen.ntm_gas_turbine.elements
	if elements_count > 0 then
		for index = 1, elements_count do
			_G.drivers.gen.ntm_gas_turbine.get_data_individual(index)
		end
	end
end

function _G.drivers.gen.ntm_gas_turbine.set_throttle_individual(element, throttle)
	_G.tags.gen.ntm_gas_turbine.elements[element].setThrottle(throttle)
end

function _G.drivers.gen.ntm_gas_turbine.set_throttle(throttle)
	local elements_count = #_G.tags.gen.ntm_gas_turbine.elements
	if elements_count > 0 then
		for index = 1, elements_count do
			_G.drivers.gen.ntm_gas_turbine.set_throttle_individual(element, throttle)
		end
	end
end

function _G.drivers.gen.ntm_gas_turbine.start_individual(element)
	_G.tags.gen.ntm_gas_turbine.elements[element].start()
end

function _G.drivers.gen.ntm_gas_turbine.start()
	local elements_count = #_G.tags.gen.ntm_gas_turbine.elements
	if elements_count > 0 then
		for index = 1, elements_count do
			_G.drivers.gen.ntm_gas_turbine.start_individual(index)
		end
	end
end

function _G.drivers.gen.ntm_gas_turbine.stop_individual(element)
	_G.tags.gen.ntm_gas_turbine.elements[element].stop()
end

function _G.drivers.gen.ntm_gas_turbine.stop()
	local elements_count = #_G.tags.gen.ntm_gas_turbine.elements
	if elements_count > 0 then
		for index = 1, elements_count do
			_G.drivers.gen.ntm_gas_turbine.stop_individual(index)
		end
	end
end
