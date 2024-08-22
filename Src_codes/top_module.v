//===========================================================
// Project:     MIPS 32 Single-Cycle Processor
// File:        top_module.v
// Author:      Abdelrahman Hatem Nasr 
// Date:        2024-08-22
// Description: Top-level module for a single-cycle MIPS 32 processor. 
//              This module integrates the control unit, ALU, memory, 
//              and registers to execute instructions.
//===========================================================

module top_module (clk, rst_n);

input clk, rst_n;  // Clock and active-low reset signals

//===========================================================
// Wire Declarations
//===========================================================
wire [31:0] PCPlus4, PCBranch, BranchMuxResult, PcPre, Pc, Instr, SrcA, WriteData, SrcB, SignImm, SignImmShifted, ALUResult, ReadData, Result;
wire PCSrc, Jump, MemtoReg, MemWrite, Branch, ALUSrc, RegDst, RegWrite, Zero;
wire [2:0] ALUControl;
wire [4:0] WriteReg;
wire [27:0] ShiftRegisterPcIn;

//===========================================================
// Control Unit Instantiation
//===========================================================
// Generates control signals based on opcode and function fields
control_unit CU (
    .Op(Instr[31:26]),   // Opcode from instruction
    .Funct(Instr[5:0]),  // Function code for R-type instructions
    .MemtoReg(MemtoReg), // Control signal for memory-to-register mux
    .MemWrite(MemWrite), // Control signal to enable memory write
    .Branch(Branch),     // Control signal to enable branching
    .ALUControl(ALUControl), // ALU operation control signals
    .ALUSrc(ALUSrc),     // Control signal to select ALU input source
    .RegDst(RegDst),     // Control signal for register destination mux
    .RegWrite(RegWrite), // Control signal for register write enable
    .Jump(Jump)          // Control signal to enable jumping
);

//===========================================================
// PC Update MUXs and Program Counter
//===========================================================
// Mux to choose between PC+4 and branch target
mux_2_1 #(.WIDTH(32)) m1 (
    .I0(PCPlus4),      // Incremented PC
    .I1(PCBranch),     // Branch target
    .Sel(PCSrc),       // Select signal based on branch condition
    .Out(BranchMuxResult) // Output result of the mux
);

// Mux to choose between BranchMuxResult and Jump address
mux_2_1 #(.WIDTH(32)) m2 (
    .I0(BranchMuxResult),                          // Branch or PC+4
    .I1({PCPlus4[31:28], ShiftRegisterPcIn[27:0]}), // Jump target
    .Sel(Jump),                                    // Select signal for jump
    .Out(PcPre)                                    // Output result of the mux
);

// Program Counter (PC) register
PC p (
    .PC_pre(PcPre),   // Next PC value
    .PC_post(Pc),     // Current PC value
    .clk(clk),        // Clock signal
    .rst_n(rst_n)     // Active-low reset
);

//===========================================================
// Instruction Fetch and Increment
//===========================================================
// PC incrementer (adds 4 to the current PC)
adder adder_1 (
    .Operand_1(Pc),       // Current PC
    .Operand_2(32'd4),    // Constant value of 4
    .Result(PCPlus4)      // Next PC (PC + 4)
);

// Instruction memory to fetch the instruction at current PC
instruction_memory mem_1 (
    .A(Pc),       // Address (PC)
    .RD(Instr)    // Output instruction
);

//===========================================================
// Register File and ALU Setup
//===========================================================
// Register file for MIPS architecture
register_file reg_1 (
    .clk(clk),         // Clock signal
    .rst_n(rst_n),     // Active-low reset
    .A1(Instr[25:21]), // Register source 1 (rs)
    .A2(Instr[20:16]), // Register source 2 (rt)
    .A3(WriteReg),     // Destination register (rd/rt)
    .WD3(Result),      // Data to be written to the register
    .WE3(RegWrite),    // Write enable control
    .RD1(SrcA),        // Output data for source 1 (rs)
    .RD2(WriteData)    // Output data for source 2 (rt)
);

// Mux to select destination register (rd or rt)
mux_2_1 #(.WIDTH(5)) m3 (
    .I0(Instr[20:16]), // rt field (for I-type instructions)
    .I1(Instr[15:11]), // rd field (for R-type instructions)
    .Sel(RegDst),      // Control signal for destination selection
    .Out(WriteReg)     // Output selected register
);

//===========================================================
// ALU and Sign Extension
//===========================================================
// Mux to select ALU input (immediate value or register data)
mux_2_1 #(.WIDTH(32)) m4 (
    .I0(WriteData),  // Register data (rt)
    .I1(SignImm),    // Sign-extended immediate value
    .Sel(ALUSrc),    // Control signal for ALU input selection
    .Out(SrcB)       // Output selected ALU input
);

// Sign extension unit for immediate values
sign_extend s1 (
    .In(Instr[15:0]),  // Immediate value (from instruction)
    .Out(SignImm)      // Sign-extended value
);

// ALU operation
alu al1 (
    .SrcA(SrcA),        // First operand (from register file)
    .SrcB(SrcB),        // Second operand (from mux)
    .ALUControl(ALUControl), // ALU operation control signals
    .Zero(Zero),        // Zero flag (result is zero)
    .ALUResult(ALUResult) // Result of the ALU operation
);

//===========================================================
// Memory Access and Write-back
//===========================================================
// Data memory for load/store operations
data_memory dat1 (
    .clk(clk),           // Clock signal
    .rst_n(rst_n),       // Active-low reset
    .WE(MemWrite),       // Write enable control
    .A(ALUResult),       // Address for memory access
    .RD(ReadData),       // Data read from memory
    .WD(WriteData)       // Data to be written to memory
);

// Mux to select result between ALU and memory
mux_2_1 #(.WIDTH(32)) m5 (
    .I0(ALUResult),   // Result from ALU
    .I1(ReadData),    // Data from memory
    .Sel(MemtoReg),   // Control signal for selection
    .Out(Result)      // Output selected result
);

//===========================================================
// Branch Logic and PC Update
//===========================================================
// Adder for calculating branch target
adder adder_2 (
    .Operand_1(SignImmShifted),  // Shifted sign-extended immediate value
    .Operand_2(PCPlus4),         // Incremented PC (PC + 4)
    .Result(PCBranch)            // Branch target address
);

// Shift left unit to shift the immediate value for branching
shifter #(.WIDTH_IN(32), .WIDTH_OUT(32)) sh1 (
    .In(SignImm),              // Sign-extended immediate value
    .Out(SignImmShifted)       // Shifted immediate value
);

// Shift left unit to shift the jump target address
shifter #(.WIDTH_IN(32), .WIDTH_OUT(32)) sh2 (
    .In({6'd0, Instr[25:0]}),  // Jump target address (from instruction)
    .Out(ShiftRegisterPcIn)    // Shifted jump target address
);

// AND gate for branch condition (Zero flag AND Branch control signal)
and a1 (
    PCSrc,     // Branch decision output
    Zero,      // Zero flag from ALU
    Branch     // Branch control signal from control unit
);

endmodule
