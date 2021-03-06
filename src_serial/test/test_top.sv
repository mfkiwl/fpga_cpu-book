`timescale 1ns / 1ps

module test_top();
    logic clk, neg_rst, uart_rxd_out;
    
    top top(.*);
    
    defparam top.send_serial.WAIT_DIV = 3;
    
    always #5 clk = ~clk;
    initial   clk = 1'b0;

    initial begin
        neg_rst = 1'b0;
        #10;
        neg_rst = 1'b1;
        
        #100;
        wait (top.byte_cnt == 11);
        #100;
        $finish;
    end
endmodule
