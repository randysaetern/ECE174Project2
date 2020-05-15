`include "OPcodes.v"
//testing the top module
module testing();
	reg power,reset,clk,IMEMwrite,softReset;
	reg [31:0] InW,TPC;
	reg [31:0] temp;
	wire valid;
	//integer fileO;
	//integer dragon;	
	CPUtop oomami(.power(power),.reset(reset),.clk(clk),.writeI(IMEMwrite),
			.softReset(softReset),.dataI(InW),.TPC(TPC),.valid(valid));
	always #25 clk = ~clk;
	initial
	begin
		power <=0;
		softReset <=0;
		reset <=1;
		clk <= 0;
		IMEMwrite <=0;
		InW <= 0;
		TPC<=0;
		//fileO = $fopen("MachineCode.txt","r");
	end
	initial
	begin
		#25;
		power <=0;
		reset <=0;
		IMEMwrite <=1;
		InW <= 32'b00100000000000000000000000000000; //addi zero,zero,zero;
		TPC <=0;
		@(posedge clk);
		#25;
		InW <= {`addi,5'd0, 5'd1,16'd20};
		TPC <= TPC+4;
		@(posedge clk);
		#25;
		InW <= {`addi,5'd0, 5'd2,16'd15};
		TPC <= TPC+4;
		@(posedge clk);//
		#25;
		InW <= {`strw,5'd1, 5'd2,16'd0};
		TPC <= TPC+4;
		@(posedge clk);
		#25;
		InW <= {`ldrw,5'd1, 5'd1,16'd0};
		TPC <= TPC+4;
		@(posedge clk);
		#25;
		InW <= {`Rformat,5'd1, 5'd1,5'd5,5'd0,`radd}; // R5 = R1 + R1;
		TPC <= TPC+4;
		@(posedge clk);
		#25;
		InW <= {`jump,26'd0}; //
		TPC <= TPC+4;
		@(posedge clk);
		#25;
		InW <= {`jump,26'd0};
		TPC <= TPC+4;
		@(posedge clk);
		#25;
		IMEMwrite <= 0;
		power <= 0;
		softReset <= 1;
		#50;
		softReset <= 0;
		power <=1;
		$display("start");
	end
	


endmodule
//Code section:
/*
		#25;
		power <=1;
		reset <=0;
		IMEMwrite <=1;
		InW <= 32'b00100000000000000000000000000000;
		TPC <=0;
		@(posedge clk);
		#25;
		InW <= {`addi,5'd0, 5'd1,16'd20};
		TPC <= TPC+4;
		@(posedge clk);
		#25;
		InW <= {`addi,5'd0, 5'd2,16'd15};
		TPC <= TPC+4;
		@(posedge clk);//
		#25;
		InW <= {`swr,5'd1, 5'd2,16'd0};
		TPC <= TPC+4;
		@(posedge clk);
		#25;
		InW <= {`ldrw,5'd1, 5'd2,16'd0};
		TPC <= TPC+4;
		@(posedge clk);
		#25;
		InW <= {`jump,26'd0};
		TPC <= TPC+4;
		@(posedge clk);
		#25;
		InW <= {`jump,26'd0};
		TPC <= TPC+4;
		@(posedge clk);
		#25;
		IMEMwrite = 0;
		$display("start");
*/
/*
//R will be used to determine which light will be on
//R10 is the switches bases and will contain the values of turned on switches. R10 = 320;8
//R11 is the LED lights address. 20
// if R10 is < 10, the first light will be on. If R10 < 15, the 
   second light will be on. If R10 < 20, light 3 will be on. If
   R10 >= 20 then lights 3 and 2 will be on. Continuous polling 
   will be done.

_main:  addi 	$zero,$zero,0;		0				{`addi,5'd0, 5'd0,16'd0}
4	addi 	r1, $zero, 10; 10					{`addi,5'd0, 5'd1,16'd10}
8	addi 	r2, $zero, 15; 15					{`addi,5'd0, 5'd2,16'd15}		
16	lw 	r3, $0[r10]; //load value of the switches into r3	{`ldrw,5'd10, 5'd3,16'd0}	
20	add 	r5, r1, r1; //r5 = 20;					{`Rformat,5'd1, 5'd1,5'd5,5'd0,`radd}
24	addi	r11, $zero, 20;						{`addi,5'd0, 5'd11,16'd20}
28
loop: 	addi 	$zero,$zero,0;						{`addi,5'd0, 5'd0,16'd0}
32	lw	r3, $zero[r10]; //load value of switches		{`ldrw,5'd10, 5'd3,16'd0}
36	BEQ	r3,$zero, off; 						{`beq, 5'd3, 5'd0, 16'd128}
40	slt 	r4, r3, r1; 						{`Rformat, 5'd3, 5'd1, 5'd4, 5'd0, `rslt}
44	BNE 	r4, $zero, L1; if less than 10, jump			{`bne, 5'd0, 5'd4, 16'd76}
48	slt 	r4, r3, r2;						{`Rformat, 5'd3, 5'd1, 5'd4, 5'd0, `rslt}
52	BNE 	r4, $zero, L2; if less than 15, jump			{`bne, 5'd0, 5'd4, 16'd92}
56	slt	r4, r3, r5;						{`Rformat, 5'd3, 5'd5, 5'd4, 5'd0, `rslt}
60	BNE	r4, $zero, L3;						{`bne, 5'd0, 5'd4, 16'd112}
64	addi 	r6, $zero, 6;						{`addi,5'd0, 5'd6,16'd6}
68	sw	r6,$zero[r11];						{`swr,5'd11, 5'd6,16'd0}						
72	B	loop;							{`jump,26'd28}
76
L1:	addi 	$zero,$zero,0;						{`addi,5'd0, 5'd0,16'd0}
80	addi 	r6, $zero,1;						{`addi,5'd0, 5'd6,16'd1}
84	sw	r6,$zero[r11];						{`swr,5'd11, 5'd6,16'd0}
88	B 	loop;							{`jump,26'd28}
92
L2:	addi 	$zero,$zero,0;						{`addi,5'd0, 5'd0,16'd0}
96	addi 	r6, $zero,2;						{`addi,5'd0, 5'd6,16'd2}
104	sw	r6,$zero[r11];						{`swr,5'd11, 5'd6,16'd0}
108	B	Loop;							{`jump,26'd28}
112
L3:	addi 	$zero,$zero,0;						{`addi,5'd0, 5'd0,16'd0}
116	addi 	r6, $zero,4;						{`addi,5'd0, 5'd6,16'd2}
120	sw	r6,$zero[r11];						{`swr,5'd11, 5'd6,16'd0}
124	B	Loop;							{`jump,26'd28}
128
off:	addi 	$zero,$zero,0;						{`addi,5'd0, 5'd0,16'd0}
132	sw	$zero,[r11];						{`swr,5'd11, 5'd0,16'd0}
136	B	Loop;							{`jump,26'd28}
140	B	Loop;							{`jump,26'd28}
32'b001000 00000 00000 0000000000000000
32'b001000 00000 00001 0000000000001010
32'b001000 00000 00010 0000000000001111





*/