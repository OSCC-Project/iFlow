#===========================================================
#   set environment variable
#===========================================================
source ../../scripts/common/set_env.tcl

#===========================================================
#   set tool related parameter
#===========================================================
set MERGED_LIB_FILE         "$PROJ_PATH/foundry/$FOUNDRY/lib/merged.lib"
set BLACKBOX_V_FILE         "$PROJ_PATH/foundry/$FOUNDRY/verilog/blackbox.v" 
#set VERILOG_TOP_PARAMS      ""
set CLKGATE_MAP_FILE        "$PROJ_PATH/foundry/$FOUNDRY/verilog/cells_clkgate.v" 
set LATCH_MAP_FILE          "$PROJ_PATH/foundry/$FOUNDRY/verilog/cells_latch.v" 
set BLACKBOX_MAP_TCL        "$PROJ_PATH/foundry/$FOUNDRY/blackbox_map.tcl" 
set CLOCK_PERIOD            "20.0" 

if { $FOUNDRY == "sky130" } {
    if { $TRACK == "HS" } {
        set TIEHI_CELL_AND_PORT     "sky130_fd_sc_hs__conb_1 HI" 
        set TIELO_CELL_AND_PORT     "sky130_fd_sc_hs__conb_1 LO" 
        set MIN_BUF_CELL_AND_PORTS  "sky130_fd_sc_hs__buf_1 A X" 
    } elseif { $TRACK == "HD" } {
	set TIEHI_CELL_AND_PORT     "sky130_fd_sc_hd__conb_1 HI" 
        set TIELO_CELL_AND_PORT     "sky130_fd_sc_hd__conb_1 LO" 
        set MIN_BUF_CELL_AND_PORTS  "sky130_fd_sc_hd__buf_1 A X"
    }
} elseif { $FOUNDRY == "nangate45" } {
    set TIEHI_CELL_AND_PORT     "LOGIC1_X1 Z" 
    set TIELO_CELL_AND_PORT     "LOGIC0_X1 Z" 
    set MIN_BUF_CELL_AND_PORTS  "BUF_X1 A Z" 
} elseif { $FOUNDRY == "asap7" } {
    set TIEHI_CELL_AND_PORT     "TIEHIx1_ASAP7_75t_R H" 
    set TIELO_CELL_AND_PORT     "TIELOx1_ASAP7_75t_R L" 
    set MIN_BUF_CELL_AND_PORTS  "BUFx2_ASAP7_75t_R A Y" 
}

set VERILOG_INCLUDE_DIRS "\
"
set VERILOG_FILES " \
$RTL_PATH/uart.v \
$RTL_PATH/uart_rx.v \
$RTL_PATH/uart_tx.v \
"

#===========================================================
#   main running
#===========================================================
yosys -import

# Don't change these unless you know what you are doing
set stat_ext    "_stat.rep"
set gl_ext      "_gl.v"
set abc_script  "+read_constr,$SDC_FILE;strash;ifraig;retime,-D,{D},-M,6;strash;dch,-f;map,-p,-M,1,{D},-f;topo;dnsize;buffer,-p;upsize;"

# Setup verilog include directories
set vIdirsArgs ""
if {[info exist VERILOG_INCLUDE_DIRS]} {
    foreach dir $VERILOG_INCLUDE_DIRS {
        lappend vIdirsArgs "-I$dir"
    }
    set vIdirsArgs [join $vIdirsArgs]
}



# read verilog files
foreach file $VERILOG_FILES {
    read_verilog -sv {*}$vIdirsArgs $file
}


# Read blackbox stubs of standard/io/ip/memory cells. This allows for standard/io/ip/memory cell (or
# structural netlist support in the input verilog
read_verilog $BLACKBOX_V_FILE

# Apply toplevel parameters (if exist
if {[info exist VERILOG_TOP_PARAMS]} {
    dict for {key value} $VERILOG_TOP_PARAMS {
        chparam -set $key $value $DESIGN
    }
}


# Read platform specific mapfile for OPENROAD_CLKGATE cells
if {[info exist CLKGATE_MAP_FILE]} {
    read_verilog $CLKGATE_MAP_FILE
}

# Use hierarchy to automatically generate blackboxes for known memory macro.
# Pins are enumerated for proper mapping
if {[info exist BLACKBOX_MAP_TCL]} {
    source $BLACKBOX_MAP_TCL
}

# generic synthesis
#synth  -top $DESIGN -flatten
synth  -top $DESIGN

# Optimize the design
opt -purge  

# technology mapping of latches
if {[info exist LATCH_MAP_FILE]} {
  techmap -map $LATCH_MAP_FILE
}

# technology mapping of flip-flops
dfflibmap -liberty $MERGED_LIB_FILE
opt -undriven

# Technology mapping for cells
abc -D [expr $CLOCK_PERIOD * 1000] \
    -constr "$SDC_FILE" \
    -liberty $MERGED_LIB_FILE \
    -script $abc_script \
    -showtmp

# technology mapping of constant hi- and/or lo-drivers
hilomap -singleton \
        -hicell {*}$TIEHI_CELL_AND_PORT \
        -locell {*}$TIELO_CELL_AND_PORT

# replace undef values with defined constants
setundef -zero

# Splitting nets resolves unwanted compound assign statements in netlist (assign {..} = {..}
splitnets

# insert buffer cells for pass through wires
insbuf -buf {*}$MIN_BUF_CELL_AND_PORTS

# remove unused cells and wires
opt_clean -purge

# reports
tee -o $RPT_PATH/synth_check.txt check
tee -o $RPT_PATH/synth_stat.txt stat -liberty $MERGED_LIB_FILE

# write synthesized design
#write_verilog -norename -noattr -noexpr -nohex -nodec $RESULTS_DIR/1_1_yosys.v
write_verilog -noattr -noexpr -nohex -nodec $RESULT_PATH/$DESIGN.v















