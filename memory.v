module mem(input [31:0] address,writeData, input clk, reset, memread,memwrite, output reg [31:0] data);
	reg [31:0] memory[0:4000 -1];
	integer i;
	wire [31:0] overflowCont;
	assign overflowCont = address & 32'h7ff;
	always @(posedge clk or posedge reset)
	begin
		if (reset) begin
			for(i=0; i<=4000-1;i = i+1) begin
				memory[i] <= 0;
			end
		end
		else if (memread) begin
			data = memory[overflowCont];
		end
		else if (memwrite) begin
			memory[overflowCont] = writeData;
		end
		else begin
			data <= 0;
		end
	end


endmodule
