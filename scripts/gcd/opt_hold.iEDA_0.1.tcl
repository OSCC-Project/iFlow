#===========================================================
##   set environment variable
#===========================================================
source ../../scripts/common/set_env.tcl

#===========================================================
##   read db config
#===========================================================
db_init -config $PROJ_PATH/scripts/$DESIGN/iEDA_config/$FOUNDRY/db_default_config.json

#===========================================================
##   reset data path
#===========================================================
source $PROJ_PATH/scripts/$DESIGN/DB_script/db_path_setting.tcl

#===========================================================
##   reset lib
#===========================================================
source $PROJ_PATH/scripts/$DESIGN/DB_script/db_init_lib_hold.tcl

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
##   run TO to fix_drv，opt_hold, opt_setup
#===========================================================
run_to_hold -config $PROJ_PATH/scripts/$DESIGN/iEDA_config/$FOUNDRY/to_default_config_hold.json

#===========================================================
##   Save data 
#===========================================================
def_save -path $RESULT_PATH/$DESIGN.def
netlist_save -path $RESULT_PATH/$DESIGN.v -exclude_cell_names {}

#===========================================================
##   Save report
#===========================================================
report_db -path $RPT_PATH/hold_db.rpt

#===========================================================
##   Exit 
#===========================================================
flow_exit
