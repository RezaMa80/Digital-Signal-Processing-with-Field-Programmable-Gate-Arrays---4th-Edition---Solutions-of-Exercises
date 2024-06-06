if {![file exists work]} {
     vlib work
}

vcom -93 -reportprogress 300 -work work lib_ff.vhd
vcom -93 -reportprogress 300 -work work lib_add_sub.vhd
vcom -93 -reportprogress 300 -work work example.vhd

# cleare wave window
if { [catch {delete wave *}] == 0 } {   delete wave * } 

vsim work.example(fpga)

########## Add I/O signals to wave window
add wave clk
radix -unsigned
add wave -divider  "Input data:" 
add wave a b op1 
add wave -divider  "Output data:" 
add wave sum c d

########## Add stimuli data
force clk 0 0 ns, 1 25 ns -r 50 ns
force b 2 0 ns
force a 3 0 ns, 1 130 ns, 3 240 ns
force op1 10 0 ns, 0 100 ns, 10 200 ns 

########## Run the simulation
run 250 ns 
wave zoomfull
configure wave -gridperiod 1000ns
configure wave -timelineunits ns
