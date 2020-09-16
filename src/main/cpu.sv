`include "lib_cpu.svh"

module cpu import lib_cpu :: *; (
    input  logic       clk,
    input  logic       n_reset,
    input  logic [7:0] data,
    input  logic [3:0] switch,
    output logic [3:0] addr,
    output logic [3:0] led
);
    logic [3:0] a, next_a;
    logic [3:0] b, next_b;
    logic       cf, next_cf;
    logic [3:0] ip, next_ip;
    logic [3:0] out, next_out;
    
    always_ff @(posedge clk) begin
        if (~n_reset) begin 
            a   <= '0;
            b   <= '0;
            cf  <= '0;
            ip  <= '0;
            out <= '0;
        end else begin
            a   <= next_a;
            b   <= next_b;
            cf  <= next_cf;
            ip  <= next_ip;
            out <= next_out;
        end
    end
    
    OPECODE opecode;
    logic [3:0] imm;
    decoder decoder(.data, .opecode, .imm);
    assign addr    = ip;
    assign led     = out;
    
    always_comb begin
        next_a   = a;
        next_b   = b;
        next_cf  = 1'b0;
        next_ip  = ip + 1;
        next_out = out;
        
        unique case (opecode)
            ADD_A_IMM: {next_cf, next_a} = a + imm;
            ADD_B_IMM: {next_cf, next_b} = b + imm;
            MOV_A_IMM: next_a   = imm;
            MOV_B_IMM: next_b   = imm;
            MOV_A_B  : next_a   = b;
            MOV_B_A  : next_b   = a;
            JMP_IMM  : next_ip  = imm;
            JNC_IMM  : next_ip  = cf ? ip + 1 : imm;
            IN_A     : next_a   = switch;
            IN_B     : next_b   = switch;
            OUT_B    : next_out = b;
            OUT_IMM  : next_out = imm;
            default  : ;
        endcase
    end
endmodule
