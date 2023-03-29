#===========================================================
##   set environment variable
#===========================================================
source ../../scripts/common/set_env.tcl

#===========================================================
##   read db config
#===========================================================
db_init -config $PROJ_PATH/scripts/$DESIGN/iEDA_config/db_default_config.json

#===========================================================
##   reset data path
#===========================================================
source $PROJ_PATH/scripts/$DESIGN/DB_script/db_path_setting.tcl

#===========================================================
##   read lef
#===========================================================
source $PROJ_PATH/scripts/$DESIGN/DB_script/db_init_lef.tcl

#===========================================================
##   read verilog
#===========================================================
verilog_init -path $PRE_RESULT_PATH/$DESIGN.v -top $DESIGN

#===========================================================
##   read def
#===========================================================
#def_init -path $PRE_RESULT_PATH/$DESIGN.def

#===========================================================
##   create floorplan
#===========================================================
create_floorplan

#===========================================================
##   init floorplan
#===========================================================
set DIE_AREA "0.0    0.0   220   220"
set CORE_AREA "1.08 1.08 219 219"
set IO_SITE ""

if { $FOUNDRY == "sky130" } {
    set PLACE_SITE   "unit"
    set DISTANCE 14
    set IOPIN_LAYER  "met5"
    if { $TRACK == "HS" } {
	set TAPCELL_MASTER "sky130_fd_sc_hs__tap_1"
	set ENDCAP_MASTER  "sky130_fd_sc_hs__fill_1"
    } elseif { $TRACK == "HD" } {
	set TAPCELL_MASTER "sky130_fd_sc_hd__tap_1"
	set ENDCAP_MASTER  "sky130_fd_sc_hd__fill_1"
    }
} elseif { $FOUNDRY == "nangate45" } {
    set PLACE_SITE   "FreePDK45_38x28_10R_NP_162NW_34O"
    set DISTANCE 120
    set IOPIN_LAYER  "metal5"
    set TAPCELL_MASTER "TAPCELL_X1"
    set ENDCAP_MASTER  "TAPCELL_X1"
} elseif { $FOUNDRY == "asap7" } {
    set PLACE_SITE   "asap7sc7p5t"
    set DISTANCE 25
    set IOPIN_LAYER  "M6"
    set TAPCELL_MASTER "TAPCELL_ASAP7_75t_R"
    set ENDCAP_MASTER  "TAPCELL_ASAP7_75t_R"
}

init_floorplan \
   -die_area $DIE_AREA \
   -core_area $CORE_AREA \
   -core_site $PLACE_SITE \
   -io_site $IO_SITE

source $PROJ_PATH/foundry/$FOUNDRY/gern_tracks.tcl

#===========================================================
##   Place IO
#===========================================================
#source $PROJ_PATH/scripts/$DESIGN/iFP_script/placeIO.tcl

#===========================================================
##   Place Macro
#===========================================================
#source $PROJ_PATH/scripts/$DESIGN/iFP_script/macro_place.tcl

#===========================================================
##   Place IO Port
#===========================================================
#source $PROJ_PATH/scripts/$DESIGN/iFP_script/place_pad_new.tcl
auto_place_pins -layer $IOPIN_LAYER -width 200 -height 200

#===========================================================
##   Add IO Filler
#===========================================================
#set IO_FILL "PFILL50W PFILL20W PFILL10W PFILL5W PFILL2W PFILL01W PFILL001W"
#placeIoFiller \
#   -filler_types $IO_FILL \
#   -prefix IOFIL

#===========================================================
##   Tap Cell
#===========================================================
tapcell \
   -tapcell $TAPCELL_MASTER \
   -distance $DISTANCE \
   -endcap $ENDCAP_MASTER

#===========================================================
##   PDN 
#===========================================================
source $PROJ_PATH/scripts/$DESIGN/iFP_script/user_pg.tcl 
#source $PROJ_PATH/scripts/$DESIGN/iFP_script/place_powerPad.tcl
source $PROJ_PATH/scripts/$DESIGN/iFP_script/addPowerStripe.tcl
#source $PROJ_PATH/scripts/$DESIGN/iFP_script/connect_power_io.tcl 

#===========================================================
##   set clock net
#===========================================================
source $PROJ_PATH/scripts/$DESIGN/iFP_script/set_clocknet.tcl

#===========================================================
##   remove pg net
#===========================================================
#source $PROJ_PATH/scripts/$DESIGN/iFP_script/clear_blockage.tcl

#===========================================================
##   Save data 
#===========================================================
def_save -path $RESULT_PATH/$DESIGN.def
netlist_save -path $RESULT_PATH/$DESIGN.v -exclude_cell_names  {}

#===========================================================
##   Save report
#===========================================================
report_db -path $RPT_PATH/fp_db.rpt 

#===========================================================
##   Exit 
#===========================================================
flow_exit
