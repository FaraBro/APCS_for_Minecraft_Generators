_G.tags.ES.ntm_energy_storage = {
	data = {},
	elements = {},
}
_G.drivers.ES.ntm_energy_storage = {}

function _G.drivers.ES.ntm_energy_storage.get_data(element)
	local power, max_power = _G.tags.ES.ntm_energy_storage.elements[element].getEnergyInfo()
	-- HE to RF
	_G.tags.ES.ntm_energy_storage.data[element].power = power*4
	_G.tags.ES.ntm_energy_storage.data[element].max_power = max_power*4
end

function _G.drivers.ES.ntm_energy_storage.init()
	_G.tags.ES.ntm_energy_storage.elements, _G.tags.ES.ntm_energy_storage.data = _G.drivers_tools.get_components("ntm_energy_storage", "ES")
end
