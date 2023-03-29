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
source $PROJ_PATH/scripts/$DESIGN/DB_script/db_init_lib_fixfanout.tcl

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
##   run TO to fix fanout
#===========================================================
run_no_fixfanout -config $PROJ_PATH/scripts/$DESIGN/iEDA_config/$FOUNDRY/no_default_config_fixfanout.json

#===========================================================
##   Save data 
#===========================================================
def_save -path $RESULT_PATH/$DESIGN.def
netlist_save -path $RESULT_PATH/$DESIGN.v -exclude_cell_names  {}

#===========================================================
##   Save report
#===========================================================
report_db -path $RPT_PATH/fixfanout_db.rpt

#===========================================================
##   Exit 
#===========================================================
flow_exit
