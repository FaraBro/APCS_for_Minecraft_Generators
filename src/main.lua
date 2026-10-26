-- IN DEV

while true do
	computer.beep(2000, 0.2)
	
	for gen_diver in pairs(_G.drivers.gen) do
		_G.drivers.gen[gen_diver].get_data()
		_G.drivers.gen[gen_diver].start()
		_G.drivers.gen[gen_diver].set_throttle(100)
	end
	
	computer.pullSignal(_G.config.time_sleep)
end
