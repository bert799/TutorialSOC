set_global_assignment -entity "PLL75_50" -library "lib_PLL75_50" -name IP_TOOL_NAME "altera_pll"
set_global_assignment -entity "PLL75_50" -library "lib_PLL75_50" -name IP_TOOL_VERSION "18.1"
set_global_assignment -entity "PLL75_50" -library "lib_PLL75_50" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_PLL75_50" -name SPD_FILE [file join $::quartus(sip_path) "PLL75_50.spd"]

set_global_assignment -library "lib_PLL75_50" -name MISC_FILE [file join $::quartus(sip_path) "PLL75_50_sim/PLL75_50.vo"]
