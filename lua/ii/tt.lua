do return
{ module_name  = 'Teletype'
, manufacturer = 'Monome'
, i2c_address  = {0x80, 0x81, 0x82}
, lua_name     = 'tt' -- NB: must match the file name. tt.lua -> 'tt'
, commands     =
  { { name = 'script'
    , cmd  = 0x0
    , docs = 'Run script *script*'
    , args = { 'script', u8 }
		}
  , { name = 'script_i'
    , cmd  = 0x1
    , docs = 'Run script *script* with I set to *i*'
    , args = { { 'script', u8 }
						 , { 'i', s16 } }
		}
	, { name = 'script_v'
		, cmd  = 0x2
		, docs = 'Run script *script* with I set to *i* in "Teletype volts"'
		, args = { { 'script', u8 }
						 , { 'i', s16V } }
		}
  }
, pickle = -- zero-index the script & send to multiple devices for script >= 10
--void pickle( uint8_t* address, uint8_t* data, uint8_t* byte_count );
[[

uint8_t script = data[1] - 1; // zero-index the script number
data[1]   = script % 10;      // wrap command for subsequent devices
*address += script / 10;     // increment address for subsequent devices

]]
}
end
