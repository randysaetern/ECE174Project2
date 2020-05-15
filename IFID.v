// IFID register 
// By: Randy Saetern
module IFID (input [31:0] instruction, pcp, input clk, reset, wipe, power, output reg[31:0] instructionOUT, pcpOUT);
	

	always @(negedge clk) 
	begin
		if(reset|wipe) begin
			instructionOUT <= 0;
			pcpOUT <= 0;
		end
		else if (power)begin
			instructionOUT <= instruction;
			pcpOUT <= pcp;
		end
	end
	


endmodule
