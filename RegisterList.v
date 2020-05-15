module Registers(input [4:0] R1, R2, R3, input [31:0] dataWrite, input regwrite, clk, reset, output reg [31:0] Rd1,Rd2);
	reg [31:0] register[0:31];
	integer i;
	always @(posedge clk or posedge reset)
	begin
		if(reset) begin
			
			for(i=0;i<=31;i=i+1) begin
				register[i] = 32'b0;
			end
			Rd1 <= 0;
			Rd2 <= 0;
		end
		else begin
			Rd1 <= register[R1];
			Rd2 <= register[R2];
		end
	end
	always @(negedge clk)
	begin
		if (regwrite) begin
			register [R3] = dataWrite;
		end	
	end

endmodule
