module MEMWB(input [7:0] control, input [31:0] Read, ALU, input [4:0] writeReg, input clk,reset,wipe,power, output reg [7:0] controlOUT, output reg[31:0] ReadOUT,ALUOUT,output reg [4:0] writeRegOUT);
	
	always @(negedge clk) begin
		if (reset | wipe) begin
			controlOUT <= 0;
			ReadOUT <= 0;
			ALUOUT <= 0;
			writeRegOUT <= 0;
		end
		else if (power) begin
			controlOUT <= control;
			ReadOUT <= Read;
			ALUOUT <= ALU;
			writeRegOUT <= writeReg;
		end


	end



endmodule
