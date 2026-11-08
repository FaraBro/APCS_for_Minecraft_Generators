**mode** -- APCS mode. Number (Integer). [Ext](#mode)

**modes_config** -- Mode settings. Table
- General
	- **Y_max** -- At what fuel/charge level—expressed as a percentage of the maximum capacity—will the gen reach its maximum power output? Number
	- **Y_min** -- At what fuel/charge level—expressed as a percentage of the maximum capacity—will the gen reach its minimum power output? Number
	- **gen_start** -- At what fuel/charge level—expressed as a percentage of the maximum capacity—will the gen will start? Number
	- **gen_stop** -- At what fuel/charge level—expressed as a percentage of the maximum capacity—will the gen will stop? Number
- mode 1
	- **auto_search_FS** -- Should It automatically search for FS? Bool
	- **manual_FS_address_table** - FS addr-s table. Table with string value without keys. Ignored if auto_search_FS == true
- mode 2
	- **auto_search_ES** -- Should It automatically search for ES? Bool
	- **manual_ES_address_table** -- ES addr-s table. Table with string value without keys. Ignored if auto_search_ES == true

**auto_search_gens** -- Should It automatically search for gens? Bool

**manual_gens_address_table** -- gens addr-s table. Table with string value without keys. Ignored if auto_search_gens == true

**reboot_with_err** -- Should the system reboot if an error occurs in main cycle? Bool. It is recommended to install true if you are not developer. If value == false, when an error occurs will BSoD

**time_sleep** -- Sleep time between cycles. Number

**output** -- Should it output info in screen? Bool

**lang** -- Lang. Number (lang ID). For en_US must install 1. [About langs](/doc/en_US/lang.md)

**su** -- super users. Table with string value without keys. Write APCS administators nicknames

**users_can_use** -- What user can do. Table. O where for, reset gen in M state. [More about actions](/doc/en_US/keyboard.md). [More about users](/doc/en_US/users.md)

**remote** -- REMOTE module settings. Table
- **encrypting** -- Should we use [AES encrypting](https://en.wikipedia.org/wiki/Advanced_Encryption_Standard)? Bool
- **AES_Keys** -- Table of addr-s mashines and them encryption keys. Table with keys -- addr-s and value -- encryption keys in [base64](https://en.wikipedia.org/wiki/Base64) (key len is 128 bit at standart OpenComp)
- **control_port** -- Network port, that will be opened for APCS remote control. Number, from 1 to 65535
- **controller_port** -- Network port, that will be used for feedback to APCS remote controller. Number, from 1 to 65535
- **authorized_mashines** -- Addr-s table of authorized, legitimate remote-mashines. Table with keys -- addr-s without values. They like su may do anything.
- **unauthorized_mashines_can** -- Table of what unauthorized mashines can do. Table
	- **get_data** -- May unauthorized mashines get APCS data? Bool
	- **set_state** -- May unauthorized mashines set n APCS state? Table with key -- state and with value "can do" (Bool). Like users_can_use
	- **reset_state** -- May unauthorized mashines reset APCS state from n state? Table with key -- state and with value "can do" (Bool). Like users_can_use.O


## mode
There are several modes for this APCS.

### Первый режим (1)
Just burns fuel if it exists.

The power is calculated using a formula that is dynamically generated before the start of the main cycle, based on data from the settings:

`y = k * x - b`, where y -- throttle; x -- FS Fuel count in percentage of the maximum capacity—will; k = `100 / (Y_max - Y_min)`; b = `Y_min * k`. Y_max < Y_min

### Второй режим (2)
The power is calculated using a formula that is dynamically generated before the start of the main cycle, based on data from the settings:

`y = k * x - b`, where y -- throttle; x -- ES Power count in percentage of the maximum capacity—will; k = `100 / (Y_max - Y_min)`; b = `Y_min * k`. Y_max < Y_min
