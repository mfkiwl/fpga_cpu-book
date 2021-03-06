`ifndef LIB_CPU_SVH
`define LIB_CPU_SVH
package lib_cpu;
    typedef struct packed {
        logic [7:0] a, b, ip, out;
        logic cf;
    } REGS;
    
    typedef enum logic [7:0] {
        ADD_A_IMM,
        ADD_B_IMM,
        MOV_A_IMM,
        MOV_B_IMM,
        MOV_A_B,
        MOV_B_A,
        JMP_IMM,
        JNC_IMM,
        IN_A,
        IN_B,
        OUT_B,
        OUT_IMM,
        INVALID
    } OPECODE;
endpackage
`endif