module compiler();
	integer fileCode, binaryCode;
	reg [31:0] instruction;
	
	
	initial
	begin
		fileCode= $fopen("MachineCode.txt","r");
		binaryCode = $fopen("instructionSet.txt", "w");
		
			
	end

endmodule
