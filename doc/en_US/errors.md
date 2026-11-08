# Errors

## Error Codes
Error or Err have codes (ID) (if they caused by APCS via `assert` or `error`). They are have 3-digit code where the first digit indicates how it can be fixed (i.e., the reason for it), while the remaining digits constitute a unique code

- **000** -- Unknown error


- **1xx** -- CONFIG ERRORs. With inspect [config](/src/config.lua) ([doc](/doc/en_US/config.md)) an error occurred. This errors are incorrigible and requires fix [config](/src/config.lua)
	- *101* -- Occurs when gen_start = gen_stop at [config](/src/config.lua), which is unacceptable, because with start gen we stop its
	- *102* -- Occurs when Y_max or Y_min at [config](/src/config.lua) more 100, which is unacceptable, because we don't want overload
	- *103* -- Occurs when Y_max or Y_min at [config](/src/config.lua) less 0, which is unacceptable, because will be negative power
	- *104* -- Occurs when Y_max = Y_min at [config](/src/config.lua), which is unacceptable, because the universe will collapse (figuratively)
	- *105* -- Occurs when APCS in mode 1, and Y_max < Y_min, which is unacceptable, because will be PF
	- *106* -- Occurs when APCS in mode 1, and gen_start < gen_stop, which is unacceptable, because will be PF
	- *107* -- Occurs when APCS in mode 2, and Y_max > Y_min, which is unacceptable, because will be PF
	- *108* -- Occurs when APCS in mode 2, and gen_start > gen_stop, which is unacceptable, because will be PF
	- *109* -- Occurs when APCS in unknown mode
	- *110* -- Occurs when for remote module APCS in [config](/src/config.lua) encrypting is enabled, but Data Card hasn't been searched. If you have Data Card make sure that its support encrypting (have func encrypt at its proxy). For OpenComp usually requires Data Card 2+ level for encrypting
	- *111* -- Occurs when для remote module APCS in [config](/src/config.lua) applied port that isn't at range 1-65535
	- *112* -- Occurs when для remote module APCS in [config](/src/config.lua) encrypting is enabled, but in one of encryption key isn't 128 bit

- **2xx** -- Errors of module REMOTE if you contact with its. This errors don't reboot or shutdown APCS anyway
	- *200* -- Occurs when during processing message an error occurred
	- *201* -- Occurs when decrypt has error


- **3xx** -- Reserved


- **4xx** -- Reserved


- **5xx** -- Reserved


- **6xx** -- Reserved


- **7xx** -- Reserved


- **8xx** -- Reserved


- **9xx** -- Reserved
