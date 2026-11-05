_G.drivers_tools = {}

local default_ext = {
	gen = {mode = _G.config.mode},
}

local auto_search = {
	gen = _G.config.auto_search_gens,
	FS = _G.config.modes_config.auto_search_FS,
	ES = _G.config.modes_config.auto_search_ES,
}

local manual_address_table = {
	gen = _G.config.manual_gens_address_table,
	FS = _G.config.modes_config.manual_FS_address_table,
	ES = _G.config.modes_config.manual_ES_address_table,
}

function _G.drivers_tools.get_components(components_type, driver_type)
	local components_list = {}
	local components_data_list = {}
	
	if auto_search[driver_type] then
		index = 1
		for address in component.list(components_type) do
			components_list[index] = component.proxy(address)
			components_data_list[index] = copy(default_ext[driver_type]) or {}
			index = index + 1
		end
	else
		for index, address, ext in ipairs(manual_address_table[driver_type]) do
			local ok, result = pcall(function(address)
				local element = component.proxy(address)
				assert(element.type == components_type, "Unvalid gen address")
				return element
			end, address)
			if ok then
				components_list[index] = result
				if type(ext) == "table" then
					components_data_list[index] = ext
				else
					components_data_list[index] = copy(default_ext[driver_type]) or {}
				end
			end
		end
	end
	
	return components_list, components_data_list
end
