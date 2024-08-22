# Create a working library
vlib work

# Compile all Verilog files
vlog adder.v
vlog alu.v
vlog alu_decoder.v
vlog control_unit.v
vlog data_memory.v
vlog instruction_memory.v
vlog main_decoder.v
vlog mips_tb.v
vlog mux_2_1.v
vlog PC.v
vlog register_file.v
vlog shifter.v
vlog sign_extend.v
vlog top_module.v


vsim -voptargs=+acc work.mips_tb

add wave *
add wave -position insertpoint  \
sim:/mips_tb/dut/mem_1/A \
sim:/mips_tb/dut/mem_1/RD \
sim:/mips_tb/dut/CU/Op \
sim:/mips_tb/dut/CU/Funct \
sim:/mips_tb/dut/CU/MemtoReg \
sim:/mips_tb/dut/CU/MemWrite \
sim:/mips_tb/dut/CU/Branch \
sim:/mips_tb/dut/CU/ALUSrc \
sim:/mips_tb/dut/CU/RegDst \
sim:/mips_tb/dut/CU/RegWrite \
sim:/mips_tb/dut/CU/Jump \
sim:/mips_tb/dut/CU/ALUControl \
sim:/mips_tb/dut/CU/ALUOp \
sim:/mips_tb/dut/p/PC_pre \
sim:/mips_tb/dut/p/PC_post \
sim:/mips_tb/dut/al1/ALUResult 
run -all

#quit -sim
