## add a local signal for behavior simulation only
proc add_local {var_name} { 
  if { [catch {add wave $var_name}] > 0 } {
    puts "** Uwe Info: Local Signal $var_name is NOT available in timing simulation!"
  } else {
    puts "** Uwe Info: Add local variable $var_name in wave window for simulation!"
  }
}

if {![file exists work]} {
     vlib work
}

if {[catch { vcom -93 $2.vhd } ] == 0} { vcom -93 $2.vhd }
if {[catch { vcom -93 $3.vhd } ] == 0} { vcom -93 $3.vhd }

## clear wave window first
if { [catch {delete wave *}] == 0 } {   delete wave * } 

## Read in functional or timing simulation switch
puts -nonewline "** Functional (0) Timing Simulation (1) "
if { $1 == 0 } {
  puts "** Functional Simulation"
  vcom -93 -reportprogress 300 -work work $project_name.vhd
  # vcom -reportprogress 300 -work work ${project_name}_tb.vhd
  vsim work.${project_name}(fpga)
} else {
  puts "** Timing Simulation"
  vcom -reportprogress 300 -work work ${project_name}.vho
  ##vsim -sdftyp /${project_name}=${project_name}_vhd.sdo work.${project_name}
  vsim +altera -L C:/altera/12.1/modelsim_ase/altera/vhdl/cycloneive \
  -L C:/altera/12.1/modelsim_ase/altera/vhdl/altera \
  -L C:/altera/12.1/modelsim_ase/altera/vhdl/altera_mf \
  -l msim_transcript -gui work.${project_name}
}
