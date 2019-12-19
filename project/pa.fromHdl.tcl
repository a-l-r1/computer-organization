
# PlanAhead Launch Script for Pre-Synthesis Floorplanning, created by Project Navigator

create_project -name cpu -dir "/home/a-l-r/co/src/project/planAhead_run_2" -part xc6slx100fgg676-2
set_param project.pinAheadLayout yes
set srcset [get_property srcset [current_run -impl]]
set_property verify_dir { {/home/a-l-r/co/src/src/include} } $srcset
set_property target_constrs_file "constraints.ucf" [current_fileset -constrset]
add_files [list {ipcore_dir/im_ipcore.ngc}]
add_files [list {ipcore_dir/dm_ipcore.ngc}]
set hdlfile [add_files [list {../src/datapath/pff.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../src/control/pipelined3-hazard.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../src/control/pipelined3-handler.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../src/control/pipelined3-forward.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {ipcore_dir/im_ipcore.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {ipcore_dir/dm_ipcore.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../src/datapath/rf.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../src/datapath/pc.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../src/datapath/npc.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../src/datapath/im.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../src/datapath/ext.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../src/datapath/dm.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../src/datapath/cp0.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../src/datapath/cmp.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../src/datapath/alu.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../src/control/pipelined3-function.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../src/devices/timer.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../src/cpu/pipelined3-cpu.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../src/bridge/bridge.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../src/mips/mips.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set_property top mips $srcset
add_files [list {constraints.ucf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/dm_ipcore.ncf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/im_ipcore.ncf}] -fileset [get_property constrset [current_run]]
open_rtl_design -part xc6slx100fgg676-2
