_G.config = {
	mode = 1, -- Режим работы APCS (Общий)
	modes_config = { -- Настройки режима работы APCS
		-- Общий
		-- anything settings [IN DEV]
		
		-- Режим работы 1
		-- anything settings [IN DEV]
		
		-- Режим работы 2
		auto_search_ES = true, -- Искать ли адреса автоматически (это имеет приоритет выше таблицы поиска)
		manual_ES_address_table = {
			"00000000-0000-0000-0000-000000000000", -- Адрес ES
		},
	},
	
	auto_search_gens = true, -- Искать ли генераторы автоматически
	manual_gens_address_table = {
		"00000000-0000-0000-0000-000000000000",
	},
	
	reboot_with_err = false,
	time_sleep = 2.5,
}
