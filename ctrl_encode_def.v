// NPC control signal
`define NPC_PLUS4   3'b000
`define NPC_BEQ     3'b001
`define NPC_BNE     3'b010
`define NPC_REG     3'b011
`define NPC_BLEZ    3'b100
`define NPC_BGTZ    3'b101
`define NPC_REGIMM  3'b110
`define NPC_JUMP    3'b111

// ALUOp signal
`define ALU_NOP    4'b0000 
`define ALU_ADD    4'b0001
`define ALU_SUB    4'b0010 
`define ALU_AND    4'b0011
`define ALU_OR     4'b0100
`define ALU_SLT    4'b0101
`define ALU_SLTU   4'b0110
`define ALU_XOR    4'b0111
`define ALU_NOR    4'b1000
`define ALU_LUI    4'b1100

`define ALU_SLL    4'b1001
`define ALU_SRL    4'b1010
`define ALU_SRA    4'b1011

//toReg control signal
`define ALU2Reg    2'b00
`define Mem2Reg    2'b01
`define PC2Reg     2'b10    

//RegDst control signal
`define Rt         2'b00
`define Rd         2'b01
`define R31        2'b10  

//ALUSrc control signal
`define reg        1'b0
`define shamt      1'b1
`define imm        1'b1

//EXTOp control signal
`define signext     2'b00
`define zero       2'b01
`define lui        2'b10  

//DMRd  control signal
`define DMRd_NOP   3'b000
`define DMRd_LW    3'b001
`define DMRd_LH    3'b010
`define DMRd_LB    3'b011
`define DMRd_LHU   3'b100
`define DMRd_LBU   3'b101

//DMWr  control signal
`define DMWr_NOP   3'b000
`define DMWr_SW    3'b001
`define DMWr_SH    3'b010
`define DMWr_SB    3'b011

//func
`define ADD        6'b100000
`define SUB        6'b100010
`define AND        6'b100100
`define OR         6'b100101
`define SLT        6'b101010
`define SLTU       6'b101011
`define ADDU       6'b100001
`define SUBU       6'b100011
`define XOR        6'b100110
`define NOR        6'b100111
`define SLL        6'b000000
`define SRA        6'b000011
`define SRAV       6'b000111
`define SRL        6'b000010
`define SLLV       6'b000100
`define SRLV       6'b000110
`define JR         6'b001000
`define JALR       6'b001001

//opcode
`define R_type     6'b000000
`define ADDI       6'b001000
`define ORI        6'b001101
`define LW         6'b100011
`define SW         6'b101011

`define BEQ        6'b000100
`define BNE        6'b000101
`define BLEZ       6'b000110
`define BGTZ       6'b000111
`define REGIMM     6'b000001

`define J          6'b000010
`define JAL        6'b000011
`define XORI       6'b001110
`define ADDIU      6'b001001
`define ANDI       6'b001100
`define LUI        6'b001111

`define SLTI       6'b001010
`define SLTIU      6'b001011
`define LH         6'b100001
`define LB         6'b100000
`define LHU        6'b100101
`define LBU        6'b100100
`define SH         6'b101001
`define SB         6'b101000