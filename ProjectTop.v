`include "OPcodes.v"
`define IF 0
`define ID 1
`define EX 2
`define MEM 3
`define WB 4
`define PCPL 5
module CPUtop (input power,reset,clk,writeI,softReset,input [31:0] dataI,TPC,output reg valid);
	reg [31:0] IPC;//IPC is the internal PC and TPC is for programming the instruction memory.
	// counter is used for the proper state of the processor, 
	//IE instruction fetch, decode...etc.
	reg [2:0] state;
	wire [31:0] PC;
	wire [31:0] instruction;
	wire [4:0] writeRegister;
	wire [7:0] controlOut;
	wire [31:0] writeData;
	wire[31:0] writeDatamem;
	wire [31:0] Rd1,Rd2;
	wire [31:0] ALUI2;
	wire[31:0] ALUout;
	wire [31:0] memData;
	wire zero,wipe;
	wire [31:0]nextPC,pcPlus4,jb;
	wire [31:0] instructionOUT,pcpOUT,pcpOUT1,Read1OUT,Read2OUT,R2OUT1,ImmOUT,pcpOUT2,ALUOUT,ReadOUT,ALUOUT1,ALU;
	wire [7:0] controlOUT1,controlOUT2,controlOUT3;
	wire [5:0] func1OUT,func2OUT;
	wire [4:0] R2OUT,R3OUT,WROUT,WROUT1,WR;
	wire zeroOUT;

	assign wipe = softReset ;//| zeroOUT;
	//assign nextPC = ((instruction[31:26] == `jump) |(controlOut[6]& zero))?(/*IPC+4+*/{ImmOUT[29:0],2'b0}):pcPlus4; 
	assign nextPC = (controlOUT2[6] & zeroOUT)?pcpOUT2:pcPlus4;
	assign pcPlus4= IPC +4;
	assign jb = {ImmOUT[29:0],2'b0};
	assign writeData = (controlOUT3[4])? ReadOUT: ALUOUT1;
	assign ALUI2 = controlOUT1[1]? ImmOUT:Read2OUT;
	//assign writeRegister = controlOut[7] ? instruction[15:11]:instruction[20:16];
	assign WR = controlOUT1[7] ? R3OUT:R2OUT;
	assign PC = writeI? TPC:IPC;
	INMEM mem1 (PC, dataI, writeI, clk, reset, instruction);
	Registers Regdir(instructionOUT[25:21], instructionOUT[20:16], WROUT1, writeData, controlOUT3[0], clk, reset, Rd1,Rd2);
	ALUM A1 (Rd1,ALUI2, func1OUT,func2OUT, clk, controlOUT1[3],reset, zero, ALUout);
	mem mem2( ALUOUT,R2OUT1, clk, reset, controlOUT2[5],controlOUT2[2], memData);
	control C1 (instructionOUT[31:26], state, clk, reset, power,controlOut);
	IFID ifid1(instruction, pcPlus4, clk, reset, wipe, power, instructionOUT, pcpOUT);
	IDEX idex1(controlOut, pcpOUT, Rd1, Rd2,{16'b0,instructionOUT[15:0]}, instructionOUT[5:0],instructionOUT[31:26],instructionOUT[20:16], instructionOUT[15:11], clk,reset,wipe,power, controlOUT1, pcpOUT1,Read1OUT,Read2OUT,ImmOUT,func1OUT,func2OUT, R2OUT,R3OUT );
	EXMEM exmem1( controlOUT1, jb, ALUout,Read2OUT,  WR, zero,clk,reset,wipe,power, controlOUT2, pcpOUT2, ALUOUT,R2OUT1,WROUT,zeroOUT);
	MEMWB memwb1(controlOUT2,memData,ALUOUT,WROUT,clk,reset,wipe,power,controlOUT3,ReadOUT,ALUOUT1, WROUT1);
	always @(posedge clk) 
	begin
		if(reset) begin
			IPC <= 0;
			state <= 0;
		end
		else if (softReset) begin
			state <= 0;
		end
		else if (power) begin
			IPC <= nextPC;
			//$display("%d:PC = %b. Instruction: %b\nstate:%h. \n",$time,PC, instruction,state);
		end

	end

endmodule
