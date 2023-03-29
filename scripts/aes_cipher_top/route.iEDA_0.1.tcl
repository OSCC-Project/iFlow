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
##   reset lib
#===========================================================
source $PROJ_PATH/scripts/$DESIGN/DB_script/db_init_lib.tcl

#===========================================================
##   reset sdc
#===========================================================
source $PROJ_PATH/scripts/$DESIGN/DB_script/db_init_sdc.tcl

#===========================================================
##   read lef
#===========================================================
source $PROJ_PATH/scripts/$DESIGN/DB_script/db_init_lef.tcl

#===========================================================
##   read def
#===========================================================
def_init -path $PRE_RESULT_PATH/$DESIGN.def

#===========================================================
##   route para config
#===========================================================
if { $FOUNDRY == "sky130" } {
    set BOTTOM_ROUTE_LAYER  "met2"
    set TOP_ROUTE_LAYER     "met4"
} elseif { $FOUNDRY == "nangate45" } {
    set BOTTOM_ROUTE_LAYER  "metal2"
    set TOP_ROUTE_LAYER     "metal6"
} elseif { $FOUNDRY == "asap7" } {
    set BOTTOM_ROUTE_LAYER  "M2"
    set TOP_ROUTE_LAYER     "M7"
}

#===========================================================
##   run Router
#===========================================================
init_rt -output_def_file_path $RESULT_PATH/$DESIGN.def \
        -temp_directory_path $RESULT_PATH \
        -log_level 0 \
        -thread_number 8 \
        -bottom_routing_layer $BOTTOM_ROUTE_LAYER \
        -top_routing_layer $TOP_ROUTE_LAYER

run_rt
destroy_rt

run_router -config $PROJ_PATH/scripts/$DESIGN/iEDA_config/$FOUNDRY/rt_default_config.json

#===========================================================
##   Save data 
#===========================================================
def_save -path $RESULT_PATH/$DESIGN.def
netlist_save -path $RESULT_PATH/$DESIGN.v -exclude_cell_names {}

#===========================================================
##   Save report
#===========================================================
report_db -path $RPT_PATH/rt_db.rpt

#===========================================================
##   Exit 
#===========================================================
flow_exit
