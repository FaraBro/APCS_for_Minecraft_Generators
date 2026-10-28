_G.tags.FS.ntm_fluid_tank = {
	data = {},
	elements = {},
}
_G.drivers.FS.ntm_fluid_tank = {}

function _G.drivers.FS.ntm_fluid_tank.get_elements()
	if _G.config.modes_config.auto_search_FS then
		index = 1
		for address in component.list("ntm_fluid_tank") do
			_G.tags.FS.ntm_fluid_tank.elements[index] = component.proxy(address)
			_G.tags.FS.ntm_fluid_tank.data[index] = {}
			index = index + 1
		end
	else
		for index, address in ipairs(_G.config.modes_config.manual_FS_address_table) do
			local ok, result = pcall(function(address)
				local element = component.proxy(address)
				assert(element.type == "ntm_fluid_tank", "Unvalid gen address")
				return element
			end, address)
			if ok then
				_G.tags.FS.ntm_fluid_tank.elements[index] = result
				_G.tags.FS.ntm_fluid_tank.data[index] = {}
			end
		end
	end
end

function _G.drivers.FS.ntm_fluid_tank.get_data_individual(element)
	_G.tags.FS.ntm_fluid_tank.data[element].fluid = _G.tags.FS.ntm_fluid_tank.elements[element].getFluidStored()
	_G.tags.FS.ntm_fluid_tank.data[element].max_fluid = _G.tags.FS.ntm_fluid_tank.elements[element].getMaxStored()
	_G.tags.FS.ntm_fluid_tank.data[element].fluid_type = _G.tags.FS.ntm_fluid_tank.elements[element].getTypeStored()
end

function _G.drivers.FS.ntm_fluid_tank.get_data()
	local FS_count = #_G.tags.FS.ntm_fluid_tank.elements
	if FS_count > 0 then
		for index = 1, FS_count do
			_G.drivers.FS.ntm_fluid_tank.get_data_individual(index)
		end
	end
end
