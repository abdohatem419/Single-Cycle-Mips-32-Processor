vlib work
vlog mux_2_1.v
vsim -voptargs=+acc work.
add wave *
run -all
#quit -sim