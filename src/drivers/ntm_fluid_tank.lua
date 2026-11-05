_G.tags.FS.ntm_fluid_tank = {
	data = {},
	elements = {},
}
_G.drivers.FS.ntm_fluid_tank = {}

function _G.drivers.FS.ntm_fluid_tank.get_data(element)
	_G.tags.FS.ntm_fluid_tank.data[element].fluid = _G.tags.FS.ntm_fluid_tank.elements[element].getFluidStored()
	_G.tags.FS.ntm_fluid_tank.data[element].max_fluid = _G.tags.FS.ntm_fluid_tank.elements[element].getMaxStored()
	_G.tags.FS.ntm_fluid_tank.data[element].fluid_type = _G.tags.FS.ntm_fluid_tank.elements[element].getTypeStored()
end

function _G.drivers.FS.ntm_fluid_tank.init()
	_G.tags.FS.ntm_fluid_tank.elements, _G.tags.FS.ntm_fluid_tank.data = _G.drivers_tools.get_components("ntm_fluid_tank", "FS")
end
