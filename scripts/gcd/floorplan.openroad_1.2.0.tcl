#===========================================================
#   set environment variable
#===========================================================
source ../../scripts/common/set_env.tcl

#===========================================================
#   set tool related parameter
#===========================================================
#set DIE_AREA            "0 0 16.2 16.2" 
#set CORE_AREA           "1.08 1.08 15.12 15.12" 
set DIE_AREA            "0 0 220.2 220.2" 
set CORE_AREA           "1.08 1.08 219.12 219.12" 

set TRACKS_INFO_FILE    "$PROJ_PATH/foundry/$FOUNDRY/tracks_1.2.0.info" 

if { $FOUNDRY == "sky130" } {      
    set PLACE_SITE   "unit"
    set IO_H_LAYER   "met3"
    set IO_V_LAYER   "met2"
} elseif { $FOUNDRY == "nangate45" } {
    set PLACE_SITE   "FreePDK45_38x28_10R_NP_162NW_34O"
    set IO_H_LAYER   "metal3"
    set IO_V_LAYER   "metal2"
} elseif { $FOUNDRY == "asap7" } {
    set PLACE_SITE   "asap7sc7p5t"
    set IO_H_LAYER   "M4"
    set IO_V_LAYER   "M5"
}

#set IP_GLOBAL_CFG       "$PROJ_PATH/scripts/$DESIGN/IP_global.cfg"

#===========================================================
#   main running
#===========================================================
# Read lef
foreach lef $LEF_FILES {
    read_lef $lef
}

# Read liberty files
foreach libFile $LIB_FILES {
    read_liberty $libFile
}

# Read verilog
read_verilog $PRE_RESULT_PATH/$DESIGN.v

link_design $DESIGN
read_sdc $SDC_FILE

proc placeInst {inst_name ptx pty orient {lib_cell ""}} {
    set db [::ord::get_db]
    set tech [$db getTech]
    set block [[$db getChip] getBlock]
    if {[set inst [$block findInst $inst_name]] == "NULL"} {
        set inst [odb::dbInst_create $block [$db findMaster $lib_cell] $inst_name]
    }

    $inst setOrigin $ptx $pty
    $inst setOrient $orient
    $inst setPlacementStatus "FIRM"
}

proc placePort {port_name bd_box metal} {
    set db [::ord::get_db]
    set tech [$db getTech]
    set block [[$db getChip] getBlock]
    set layer [$tech findLayer $metal]
    set term [$block findBTerm $port_name]
    set pin [odb::dbBPin_create $term]
    odb::dbBox_create $pin $layer [lindex $bd_box 0] \
                                  [lindex $bd_box 1] \
                                  [lindex $bd_box 2] \
                                  [lindex $bd_box 3]
    $pin setPlacementStatus "FIRM"
}

proc placePadcell {port_name metal inst_pad_name ptx pty orient } {
    set db    [::ord::get_db]
    set tech  [$db getTech]
    set block [[$db getChip] getBlock]
    set layer [$tech findLayer $metal]
    set inst_name [regsub {/\w+\s*$} $inst_pad_name ""]
    set pad_name  [regsub {.*/} $inst_pad_name ""]
    if {[set term [$block findBTerm $port_name]] == "NULL"} {
        puts "Error: cannot find port : $port_name!\n"
        return
    }
    if {[set inst [$block findInst $inst_name]] == "NULL"} {
        puts "Error: cannot find inst : $inst_name!\n"
        return
    }
    set net [$term getNet]
    foreach iterm [$net getITerms] {
        $iterm setSpecial
    }
    $term setSpecial
    $net setSpecial

    set pin [odb::dbBPin_create $term]
    $inst setOrigin $ptx $pty
    $inst setOrient $orient
    $inst setPlacementStatus "FIRM"

    set mterm [[$inst getMaster] findMTerm $pad_name]
    set mpin [lindex [$mterm getMPins] 0]
    foreach geometry [$mpin getGeometry] {
        if {[[$geometry getTechLayer] getName] == $metal} {
            set pin_box [pdngen::transform_box [$geometry xMin] [$geometry yMin] [$geometry xMax] [$geometry yMax] [$inst getOrigin] [$inst getOrient]]
            odb::dbBox_create $pin $layer {*}$pin_box
            $pin setPlacementStatus "FIRM"
        }
    } 

}

# Initialize floorplan using ICeWall FOOTPRINT
# ----------------------------------------------------------------------------
if {[info exists strategy_file]} {
    ICeWall load_footprint $strategy_file

    initialize_floorplan \
        -die_area  [ICeWall get_die_area] \
        -core_area [ICeWall get_core_area] \
        -site      $PLACE_SITE
    source $TRACKS_INFO_FILE
    ICeWall init_footprint $sigmap_file

# Initialize floorplan using CORE_UTILIZATION
# ----------------------------------------------------------------------------
} elseif {[info exists CORE_UTILIZATION] && $CORE_UTILIZATION != "" } {
  initialize_floorplan -utilization $CORE_UTILIZATION \
                       -aspect_ratio $CORE_ASPECT_RATIO \
                       -core_space $CORE_MARGIN \
                       -site $PLACE_SITE
  source $TRACKS_INFO_FILE
# Initialize floorplan using DIE_AREA/CORE_AREA
# ----------------------------------------------------------------------------
} else {
    initialize_floorplan -die_area $DIE_AREA \
                         -core_area $CORE_AREA \
                         -site $PLACE_SITE

    source $TRACKS_INFO_FILE

    place_pins -random \
               -hor_layer $IO_H_LAYER \
               -ver_layer $IO_V_LAYER 

    #source $PROJ_PATH/scripts/$DESIGN/place_io_1.tcl
    #source $PROJ_PATH/scripts/$DESIGN/place_block.tcl
}


# pre report
log_begin $RPT_PATH/init.rpt

puts "\n=========================================================================="
puts "report_checks"
puts "--------------------------------------------------------------------------"
report_checks

puts "\n=========================================================================="
puts "report_tns"
puts "--------------------------------------------------------------------------"
report_tns

puts "\n=========================================================================="
puts "report_wns"
puts "--------------------------------------------------------------------------"
report_wns

puts "\n=========================================================================="
puts "report_design_area"
puts "--------------------------------------------------------------------------"
report_design_area

log_end

# write output
write_def       $RESULT_PATH/$DESIGN.def
write_verilog   $RESULT_PATH/$DESIGN.v
#write_sdc      $RESULT_PATH/$DESIGN.sdc
exit

