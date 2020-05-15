module IDEX (input [7:0] control, input [31:0] pcp, Read1, Read2,Imm, input [5:0] func1,func2, input [4:0]R2, R3,input clk,reset,wipe,power, output reg [7:0] controlOUT, output reg[31:0] pcpOUT,Read1OUT,Read2OUT,ImmOUT,output reg [5:0] func1OUT,func2OUT,output reg [4:0] R2OUT,R3OUT );

	always @(negedge clk) 
	begin
		if(reset|wipe) begin
			controlOUT <= 0;
			Read1OUT <=0;
			Read2OUT <= 0;
			ImmOUT <= 0;
			func1OUT <= 0;
			func2OUT <=0;
			R2OUT <=0;
			R3OUT <= 0;
			pcpOUT <= 0;
		end
		else if (power)begin
			controlOUT <= control;
			Read1OUT <=Read1;
			Read2OUT <= Read2;
			pcpOUT <= pcp;
			ImmOUT <= Imm;
			R2OUT <= R2;
			R3OUT <= R3;
			func1OUT <= func1;
			func2OUT <= func2;
		end
	end


endmodule
