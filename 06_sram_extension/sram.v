`timescale 1ns / 1ps

module sync_sram(addr, din, dout, clk, we);

parameter addr_width = 8, word_depth = 256, word_width = 8;

input clk, we;
input [addr_width-1:0] addr;
input [word_width-1:0] din;
output reg [word_width-1:0] dout;

reg [word_width-1:0] mem [0:word_depth-1];

always @ (posedge clk) begin
    if(!we)
        mem[addr] <= din[word_width-1:0];
end

always @ (posedge clk) begin
    #1 dout <= mem[addr];
end

endmodule

