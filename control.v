`include "OPcodes.v"

`define IF 0
`define ID 1
`define EX 2
`define MEM 3
`define WB 4
`define PCPL 5
/*
`define RSS 0
`define IF 1
`define ID 2
`define EX 3
`define MEM 4
`define WB 5
*/
module control(input [5:0] OP, input [2:0] state,input clk, reset, power, output[7:0] out);
	wire regdst,branch,memread,memtoreg,ALUOP,memwrite,ALUSrc,regwrite;
	assign regdst = ((OP==`Rformat))? 1:0;//1,2
	assign branch =((OP == `beq|OP == `bne|OP == `blez | OP == `jump))? 1:0;//2
	assign memread = ((OP == `ldrw))? 1:0;
	assign memtoreg = ((OP == `ldrw))? 1:0;
	assign ALUOP =((OP == `addi | OP == `addiu | OP ==`Rformat| OP == `ldrw | OP == `strw | OP == `jump))? 1:0;
	assign memwrite = ((OP == `strw))? 1:0;
	assign ALUSrc = ((OP == `addi | OP == `addiu| OP == `strw | OP == `ldrw))? 1:0;
	assign regwrite = ((OP == `Rformat | OP == `addi | OP == `addiu| OP == `ldrw))? 1:0;
	assign out = {regdst,branch,memread,memtoreg,ALUOP,memwrite,ALUSrc,regwrite};
endmodule
