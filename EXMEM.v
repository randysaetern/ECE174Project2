module EXMEM (input [7:0] control, input [31:0] pcp, ALU,R2, input[4:0] WR, input zero,clk,reset,wipe,power,output reg[7:0] controlOUT, output reg[31:0] pcpOUT, ALUOUT,R2OUT, output reg[4:0] WROUT,output reg zeroOUT);

	always@(negedge clk)
	begin
		if(reset|wipe) begin
			controlOUT <= 0;
			pcpOUT <= 0;
			ALUOUT <= 0;
			R2OUT <= 0;
			WROUT <= 0;
			zeroOUT <= 0;

		end
		else if (power)begin
			controlOUT <= control;
			pcpOUT <= pcp;
			ALUOUT <= ALU;
			R2OUT <= R2;
			WROUT <= WR;
			zeroOUT <= zero;
		end

	end


endmodule
