create_grid -layer_name met1 -net_name_power VDD -net_name_ground VSS -width 0.48 

create_stripe -layer_name met4 -net_name_power VDD -net_name_ground VSS -width 1.6 -pitch 27.14 -offset 13.57
create_stripe -layer_name met5 -net_name_power VDD -net_name_ground VSS -width 1.6 -pitch 27.20 -offset 13.6

set connect1 "met1 met4"
set connect2 "met4 met5"
connect_two_layer -layers [concat $connect1 $connect2]

# marco power connect
connect_macro_pdn -pin_layer "met3" -pdn_layer "met4" -power_pins "vdd" -ground_pins "gnd" -orient "R0 R180 MX MY"
