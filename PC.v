`include "OPcodes.v"
`define IF 0
`define ID 1
`define EX 2
`define MEM 3
`define WB 4
`define PCPL 5
module PC(input [31:0] IPC, TPC, input [2:0] state, input reset, softReset, power, writeI,output [31:0]PCout);
	assign PCout = writeI? TPC:IPC;
	


endmodule 
