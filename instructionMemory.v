module INMEM (input [31:0] address, dataW, input write, clk, reset, output reg[31:0] instruction);
	
	reg [7:0] IMEM [0:4000-1];
	integer i;
	
	always @(posedge clk or posedge reset) 
	begin
		if(reset)begin
			for(i = 0; i<=4000-1; i = i+1) begin
				IMEM[i] <= 0;
			end
			instruction <=0;
		end
		else if(write) begin
			IMEM[address] <= dataW[31:24];
			IMEM[address+1] <= dataW[23:16];
			IMEM[address+2] <= dataW[15:8];
			IMEM[address+3] <= dataW[7:0];
		end
		else begin
			instruction <= {IMEM[address],IMEM[address+1],IMEM[address+2],IMEM[address+3]};
		end
	end

endmodule;
