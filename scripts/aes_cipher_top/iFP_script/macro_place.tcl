## tsmc 28 ##

create_inst -inst_name esd_pll_left                                                           -coord_x 289810 -coord_y 2415620    -orient R90 -type NETLIST  -cellmaster PCLAMPC_H_G -status FIXED
create_inst -inst_name esd_pll_top                                                            -coord_x 390070 -coord_y 2655100    -orient R0  -type NETLIST  -cellmaster PCLAMPC_V_G -status FIXED
place_instance -inst_name u0_rcg/u0_pll                                                          -llx 359920     -lly 2344000    -orient MX    -cellmaster PLLTS28HPMLAINT
place_instance -inst_name u0_soc_top/u0_ysyx_210539/icache/Ram_bw/ram                            -llx 596540     -lly 370000     -orient R0    -cellmaster TS5N28HPCPLVTA64X128M2FW
place_instance -inst_name u0_soc_top/u0_ysyx_210539/icache/Ram_bw_1/ram                          -llx 521000     -lly 370000     -orient R0    -cellmaster TS5N28HPCPLVTA64X128M2FW
place_instance -inst_name u0_soc_top/u0_ysyx_210539/icache/Ram_bw_2/ram                          -llx 445460     -lly 370000     -orient R0    -cellmaster TS5N28HPCPLVTA64X128M2FW
place_instance -inst_name u0_soc_top/u0_ysyx_210539/icache/Ram_bw_3/ram                          -llx 369920     -lly 370000     -orient R0    -cellmaster TS5N28HPCPLVTA64X128M2FW
place_instance -inst_name u0_soc_top/u0_ysyx_210539/dcache/Ram_bw/ram                            -llx 445460     -lly 977180     -orient R0    -cellmaster TS5N28HPCPLVTA64X128M2FW
place_instance -inst_name u0_soc_top/u0_ysyx_210539/dcache/Ram_bw_1/ram                          -llx 445460     -lly 1584360    -orient R0    -cellmaster TS5N28HPCPLVTA64X128M2FW
place_instance -inst_name u0_soc_top/u0_ysyx_210539/dcache/Ram_bw_2/ram                          -llx 369920     -lly 977180     -orient R0    -cellmaster TS5N28HPCPLVTA64X128M2FW
place_instance -inst_name u0_soc_top/u0_ysyx_210539/dcache/Ram_bw_3/ram                          -llx 369920     -lly 1584360    -orient R0    -cellmaster TS5N28HPCPLVTA64X128M2FW
place_instance -inst_name u0_soc_top/u0_ysyx_210720/coretop/ysyx_210720_ICache/dataArrayWay0     -llx 2574460    -lly 370000     -orient MY    -cellmaster TS5N28HPCPLVTA64X128M2FW
place_instance -inst_name u0_soc_top/u0_ysyx_210720/coretop/ysyx_210720_ICache/dataArrayWay1     -llx 2498920    -lly 370000     -orient MY    -cellmaster TS5N28HPCPLVTA64X128M2FW
place_instance -inst_name u0_soc_top/u0_ysyx_210720/coretop/ysyx_210720_ICache/dataArrayWay2     -llx 2423380    -lly 370000     -orient MY    -cellmaster TS5N28HPCPLVTA64X128M2FW
place_instance -inst_name u0_soc_top/u0_ysyx_210720/coretop/ysyx_210720_ICache/dataArrayWay3     -llx 2347840    -lly 370000     -orient MY    -cellmaster TS5N28HPCPLVTA64X128M2FW
place_instance -inst_name u0_soc_top/u0_ysyx_210720/coretop/ysyx_210720_DCache/dataArrayWay0     -llx 2574460    -lly 977180     -orient MY    -cellmaster TS5N28HPCPLVTA64X128M2FW
place_instance -inst_name u0_soc_top/u0_ysyx_210720/coretop/ysyx_210720_DCache/dataArrayWay1     -llx 2498920    -lly 977180     -orient MY    -cellmaster TS5N28HPCPLVTA64X128M2FW
place_instance -inst_name u0_soc_top/u0_ysyx_210720/coretop/ysyx_210720_DCache/dataArrayWay2     -llx 2574460    -lly 1584360    -orient MY    -cellmaster TS5N28HPCPLVTA64X128M2FW
place_instance -inst_name u0_soc_top/u0_ysyx_210720/coretop/ysyx_210720_DCache/dataArrayWay3     -llx 2498920    -lly 1584360    -orient MY    -cellmaster TS5N28HPCPLVTA64X128M2FW
place_instance -inst_name u0_soc_top/u0_vga_ctrl/vga/buffer11                                    -llx 2541710    -lly 2144740    -orient MY    -cellmaster TS5N28HPCPLVTA256X32M4FW
place_instance -inst_name u0_soc_top/u0_vga_ctrl/vga/buffer12                                    -llx 2443040    -lly 2144740    -orient MY    -cellmaster TS5N28HPCPLVTA256X32M4FW
place_instance -inst_name u0_soc_top/u0_vga_ctrl/vga/buffer21                                    -llx 2541710    -lly 2390160    -orient MY    -cellmaster TS5N28HPCPLVTA256X32M4FW
place_instance -inst_name u0_soc_top/u0_vga_ctrl/vga/buffer22                                    -llx 2443040    -lly 2390160    -orient MY    -cellmaster TS5N28HPCPLVTA256X32M4FW

# blockage
add_placement_blockage -box "339920 2324000 667920 2652000"
add_placement_halo -inst_name u0_soc_top/u0_vga_ctrl/vga/buffer11 -distance "2000 2000 2000 2000"
add_placement_halo -inst_name u0_soc_top/u0_vga_ctrl/vga/buffer12 -distance "2000 2000 2000 2000"
add_placement_halo -inst_name u0_soc_top/u0_vga_ctrl/vga/buffer21 -distance "2000 2000 2000 2000"
add_placement_halo -inst_name u0_soc_top/u0_vga_ctrl/vga/buffer22 -distance "2000 2000 2000 2000"
add_placement_halo -inst_name u0_soc_top/u0_ysyx_210539/dcache/Ram_bw/ram -distance "2000 2000 2000 2000"
add_placement_halo -inst_name u0_soc_top/u0_ysyx_210539/dcache/Ram_bw_1/ram -distance "2000 2000 2000 2000"
add_placement_halo -inst_name u0_soc_top/u0_ysyx_210539/dcache/Ram_bw_2/ram -distance "2000 2000 2000 2000"
add_placement_halo -inst_name u0_soc_top/u0_ysyx_210539/dcache/Ram_bw_3/ram -distance "2000 2000 2000 2000"
add_placement_halo -inst_name u0_soc_top/u0_ysyx_210539/icache/Ram_bw/ram -distance "2000 2000 2000 2000"
add_placement_halo -inst_name u0_soc_top/u0_ysyx_210539/icache/Ram_bw_1/ram -distance "2000 2000 2000 2000"
add_placement_halo -inst_name u0_soc_top/u0_ysyx_210539/icache/Ram_bw_2/ram -distance "2000 2000 2000 2000"
add_placement_halo -inst_name u0_soc_top/u0_ysyx_210539/icache/Ram_bw_3/ram -distance "2000 2000 2000 2000"
add_placement_halo -inst_name u0_soc_top/u0_ysyx_210720/coretop/ysyx_210720_ICache/dataArrayWay0 -distance "2000 2000 2000 2000"
add_placement_halo -inst_name u0_soc_top/u0_ysyx_210720/coretop/ysyx_210720_ICache/dataArrayWay1 -distance "2000 2000 2000 2000"
add_placement_halo -inst_name u0_soc_top/u0_ysyx_210720/coretop/ysyx_210720_ICache/dataArrayWay2 -distance "2000 2000 2000 2000"
add_placement_halo -inst_name u0_soc_top/u0_ysyx_210720/coretop/ysyx_210720_ICache/dataArrayWay3 -distance "2000 2000 2000 2000"
add_placement_halo -inst_name u0_soc_top/u0_ysyx_210720/coretop/ysyx_210720_DCache/dataArrayWay0 -distance "2000 2000 2000 2000"
add_placement_halo -inst_name u0_soc_top/u0_ysyx_210720/coretop/ysyx_210720_DCache/dataArrayWay1 -distance "2000 2000 2000 2000"
add_placement_halo -inst_name u0_soc_top/u0_ysyx_210720/coretop/ysyx_210720_DCache/dataArrayWay2 -distance "2000 2000 2000 2000"
add_placement_halo -inst_name u0_soc_top/u0_ysyx_210720/coretop/ysyx_210720_DCache/dataArrayWay3 -distance "2000 2000 2000 2000"

add_routing_halo -inst_name u0_soc_top/u0_vga_ctrl/vga/buffer11 -layer "M1 M2 M3 M4 M5 M6 M7" -distance "2000 2000 2000 2000"
add_routing_halo -inst_name u0_soc_top/u0_vga_ctrl/vga/buffer12 -layer "M1 M2 M3 M4 M5 M6 M7" -distance "2000 2000 2000 2000"
add_routing_halo -inst_name u0_soc_top/u0_vga_ctrl/vga/buffer21 -layer "M1 M2 M3 M4 M5 M6 M7" -distance "2000 2000 2000 2000"
add_routing_halo -inst_name u0_soc_top/u0_vga_ctrl/vga/buffer22 -layer "M1 M2 M3 M4 M5 M6 M7" -distance "2000 2000 2000 2000"
add_routing_halo -inst_name u0_soc_top/u0_ysyx_210539/dcache/Ram_bw/ram -layer "M1 M2 M3 M4 M5 M6 M7" -distance "2000 2000 2000 2000"
add_routing_halo -inst_name u0_soc_top/u0_ysyx_210539/dcache/Ram_bw_1/ram -layer "M1 M2 M3 M4 M5 M6 M7" -distance "2000 2000 2000 2000"
add_routing_halo -inst_name u0_soc_top/u0_ysyx_210539/dcache/Ram_bw_2/ram -layer "M1 M2 M3 M4 M5 M6 M7" -distance "2000 2000 2000 2000"
add_routing_halo -inst_name u0_soc_top/u0_ysyx_210539/dcache/Ram_bw_3/ram -layer "M1 M2 M3 M4 M5 M6 M7" -distance "2000 2000 2000 2000"
add_routing_halo -inst_name u0_soc_top/u0_ysyx_210539/icache/Ram_bw/ram -layer "M1 M2 M3 M4 M5 M6 M7" -distance "2000 2000 2000 2000"
add_routing_halo -inst_name u0_soc_top/u0_ysyx_210539/icache/Ram_bw_1/ram -layer "M1 M2 M3 M4 M5 M6 M7" -distance "2000 2000 2000 2000"
add_routing_halo -inst_name u0_soc_top/u0_ysyx_210539/icache/Ram_bw_2/ram -layer "M1 M2 M3 M4 M5 M6 M7" -distance "2000 2000 2000 2000"
add_routing_halo -inst_name u0_soc_top/u0_ysyx_210539/icache/Ram_bw_3/ram -layer "M1 M2 M3 M4 M5 M6 M7" -distance "2000 2000 2000 2000"
add_routing_halo -inst_name u0_soc_top/u0_ysyx_210720/coretop/ysyx_210720_ICache/dataArrayWay0 -layer "M1 M2 M3 M4 M5 M6 M7" -distance "2000 2000 2000 2000"
add_routing_halo -inst_name u0_soc_top/u0_ysyx_210720/coretop/ysyx_210720_ICache/dataArrayWay1 -layer "M1 M2 M3 M4 M5 M6 M7" -distance "2000 2000 2000 2000"
add_routing_halo -inst_name u0_soc_top/u0_ysyx_210720/coretop/ysyx_210720_ICache/dataArrayWay2 -layer "M1 M2 M3 M4 M5 M6 M7" -distance "2000 2000 2000 2000"
add_routing_halo -inst_name u0_soc_top/u0_ysyx_210720/coretop/ysyx_210720_ICache/dataArrayWay3 -layer "M1 M2 M3 M4 M5 M6 M7" -distance "2000 2000 2000 2000"
add_routing_halo -inst_name u0_soc_top/u0_ysyx_210720/coretop/ysyx_210720_DCache/dataArrayWay0 -layer "M1 M2 M3 M4 M5 M6 M7" -distance "2000 2000 2000 2000"
add_routing_halo -inst_name u0_soc_top/u0_ysyx_210720/coretop/ysyx_210720_DCache/dataArrayWay1 -layer "M1 M2 M3 M4 M5 M6 M7" -distance "2000 2000 2000 2000"
add_routing_halo -inst_name u0_soc_top/u0_ysyx_210720/coretop/ysyx_210720_DCache/dataArrayWay2 -layer "M1 M2 M3 M4 M5 M6 M7" -distance "2000 2000 2000 2000"
add_routing_halo -inst_name u0_soc_top/u0_ysyx_210720/coretop/ysyx_210720_DCache/dataArrayWay3 -layer "M1 M2 M3 M4 M5 M6 M7" -distance "2000 2000 2000 2000"

add_routing_blockage -layer "M1 M2 M3 M4 M5 M6 M7 M8 M9 AP" -box "339920 2324000 667920 2652000"
# add_routing_halo -inst_name all -layer "M1 M2 M3 M4 M5 M6 M7" -distance "6000 6000 6000 6000"
