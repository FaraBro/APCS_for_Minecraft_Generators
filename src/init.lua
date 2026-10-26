_G.APCSVERSION = "2.0.0"
_G.filesystem = component.proxy(computer.getBootAddress())

function _G.loadfile(file)
	local handle = assert(filesystem.open(file))
	local buffer = ""
	repeat
		local data = filesystem.read(handle, 2048)
		buffer = buffer .. (data or "")
	until not data
	filesystem.close(handle)
	
	local result, code_error = load(buffer, file)
	if result then
		return result
	else
		error(code_error or "Unkown err", 0)
	end
end

loadfile("/core/config.lua")(loadfile)
loadfile("/core/tags.lua")(loadfile)

_G.drivers = {
	gen = {},
}

for _, file in ipairs(filesystem.list("/drivers")) do
  loadfile("/drivers/" .. file)(loadfile)
end

for gen in pairs(_G.drivers.gen) do
	_G.drivers.gen[gen].get_elements()
end

_G.tags.state = "O"
local ok, result = pcall(function()
	loadfile("/main.lua")(loadfile)
end)

computer.beep(1000, 0.2)
if _G.config.reboot_with_error then
	computer.shutdown(true)
else
	error(result or "Unkown err", 0)
end
