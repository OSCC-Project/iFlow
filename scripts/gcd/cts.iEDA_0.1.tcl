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
##   run CTS
#===========================================================
run_cts -config $PROJ_PATH/scripts/$DESIGN/iEDA_config/$FOUNDRY/cts_default_config.json

#===========================================================
##   Save data 
#===========================================================
def_save -path $RESULT_PATH/$DESIGN.def
netlist_save -path $RESULT_PATH/$DESIGN.v -exclude_cell_names  {}

#===========================================================
##   Save report 
#===========================================================
report_db -path $RPT_PATH/cts_db.rpt
cts_report -path $RPT_PATH

#===========================================================
##   Exit 
#===========================================================
flow_exit
