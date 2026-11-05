_G.tags.gen.ntm_combustion_engine = {
	data = {},
	elements = {},
}
_G.drivers.gen.ntm_combustion_engine = {}

function _G.drivers.gen.ntm_combustion_engine.get_data(element)
	_G.tags.gen.ntm_combustion_engine.data[element].fluid, _G.tags.gen.ntm_combustion_engine.data[element].max_fluid = _G.tags.gen.ntm_combustion_engine.elements[element].getFluid()
	_G.tags.gen.ntm_combustion_engine.data[element].fluid_type = _G.tags.gen.ntm_combustion_engine.elements[element].getType()
	_G.tags.gen.ntm_combustion_engine.data[element].working = _G.tags.gen.ntm_combustion_engine.elements[element].getState()
	_G.tags.gen.ntm_combustion_engine.data[element].throttle = _G.tags.gen.ntm_combustion_engine.elements[element].getThrottle()*10//3
end

function _G.drivers.gen.ntm_combustion_engine.set_throttle(element, throttle)
	_G.tags.gen.ntm_combustion_engine.elements[element].setThrottle(throttle//10*3)
end

function _G.drivers.gen.ntm_combustion_engine.start(element)
	_G.tags.gen.ntm_combustion_engine.elements[element].start()
end


function _G.drivers.gen.ntm_combustion_engine.stop(element)
	_G.tags.gen.ntm_combustion_engine.elements[element].stop()
end

function _G.drivers.gen.ntm_combustion_engine.init()
	_G.tags.gen.ntm_combustion_engine.elements, _G.tags.gen.ntm_combustion_engine.data = _G.drivers_tools.get_components("ntm_combustion_engine", "gen")
end
