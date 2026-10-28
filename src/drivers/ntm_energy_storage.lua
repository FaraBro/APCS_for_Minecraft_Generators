_G.tags.ES.ntm_energy_storage = {
	data = {},
	elements = {},
}
_G.drivers.ES.ntm_energy_storage = {}

function _G.drivers.ES.ntm_energy_storage.get_elements()
	if _G.config.modes_config.auto_search_ES then
		index = 1
		for address in component.list("ntm_energy_storage") do
			_G.tags.ES.ntm_energy_storage.elements[index] = component.proxy(address)
			_G.tags.ES.ntm_energy_storage.data[index] = {}
			index = index + 1
		end
	else
		for index, address in ipairs(_G.config.modes_config.manual_ES_address_table) do
			local ok, result = pcall(function(address)
				local element = component.proxy(address)
				assert(element.type == "ntm_energy_storage", "Unvalid gen address")
				return element
			end, address)
			if ok then
				_G.tags.ES.ntm_energy_storage.elements[index] = result
				_G.tags.ES.ntm_energy_storage.data[index] = {}
			end
		end
	end
end

function _G.drivers.ES.ntm_energy_storage.get_data_individual(element)
	local power, max_power = _G.tags.ES.ntm_energy_storage.elements[element].getEnergyInfo()
	-- Преобразуем HE в RF
	_G.tags.ES.ntm_energy_storage.data[element].power = power*4
	_G.tags.ES.ntm_energy_storage.data[element].max_power = max_power*4
end

function _G.drivers.ES.ntm_energy_storage.get_data()
	local FS_count = #_G.tags.FS.ntm_energy_storage.elements
	if FS_count > 0 then
		for index = 1, E_count do
			_G.drivers.ES.ntm_energy_storage.get_data_individual(index)
		end
	end
end
