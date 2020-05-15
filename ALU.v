`include "OPcodes.v"

module ALUM (input [31:0] in1,in2, input [5:0] func1, func2, input clk, ALUOP, reset, output reg zero, output reg [31:0] out);
	
	always @(*)
	begin
		if(reset) begin
			out <= 0;
		end
		else if (ALUOP)begin
			case(func2)
				`beq:begin
				zero <= (in1 == in2)? 1:0;
				end
				`bne: begin
				zero <= (in1 != in2)? 1:0;
				end
				`ldrw: begin
				out <= in1+in2;
				end
				`strw: begin
				out <= in1+in2;
				end
				`slti: begin
				out <= (in1 < in2)? 1:0;
				end
				`jump: begin
				zero <= 1;
				end
				`addi: begin
				out <= in1 + in2;
				end
				`FlPt: begin
					//stall or delay....
				end
				`Rformat: begin
				case(func1)
				`rsll: begin
					out <= in1 << in2;
					zero <= 0;
				end
				`rsrl: begin
					out <= in1 >> in2;
					zero <= 0;
				end
				`radd: begin
					out <= in1 + in2;
					zero <= 0;
				end
				`rmult: begin
					out <= in1 * in2;
					zero <= 0;
					end
				`rdiv: begin
					out <= in1/in2;
					zero <= 0;
				end
				`rsub: begin
					out <= in1 - in2;
					zero <= 0;
				end
				`rslt: begin
					if (in1 < in2) begin
						out <= 1;
					end
					else begin
						out <= 0;
					end
				end
				endcase
				end
			default: begin 
				out <= 0;
				zero <= 0;
			end
			endcase
			
		end
	end
endmodule
