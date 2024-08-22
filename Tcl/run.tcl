create_project abproject_mips_32_version_1.0 E:\mips_32 -part xc7a35ticpg236-1L -force

## Add source files & XDC files
add_files alu.v adder.v alu_decoder.v control_unit.v data_memory.v instruction_memory.v main_decoder.v mux_2_1.v PC.v register_file.v shifter.v sign_extend.v top_module.v Constraints.xdc

## Elaborate Design (Will open the schematic)
synth_design -rtl -top top_module > elab.log

## Save Schematic
write_schematic elaborated_schematic.pdf -format pdf -force 

## Synthesize Design
launch_runs synth_1 > synth.log

## open gui (Schematic)
wait_on_run synth_1
open_run synth_1

## Save Schematic
write_schematic synthesized_schematic.pdf -format pdf -force 

## Generate netlist
write_verilog -force mips_netlist.v

## Implementation
launch_runs impl_1 -to_step write_bitstream 

## open gui (Schematic & Device view)
wait_on_run impl_1
open_run impl_1
