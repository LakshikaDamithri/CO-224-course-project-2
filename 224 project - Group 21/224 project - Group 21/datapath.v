//CO224 Group21

//************-------- RUN FOR 1us --------*******************



// Define the stimulus module (no ports)
module stimulus;
 
	reg clk;
	reg [15:0] in;
	wire [15:0] nextpc;
	wire [15:0] nextpc1;
	wire [15:0] nextpc2;
	wire [15:0] nextpc3;
	wire [15:0] nextpc4;
	wire [15:0] nextpc5;
	wire [15:0] nextpc6;
	wire [15:0] nextpc7;
	wire [15:0] nextpc8;

	initial
		clk = 0'b0;
	always
		#1 clk = ~clk;
	initial
		#2500 $finish;

	datapath data(nextpc,in,clk);
	datapath data1(nextpc1,nextpc,clk);
	datapath data2(nextpc2,nextpc1,clk);
	datapath data3(nextpc3,nextpc2,clk);
	datapath data4(nextpc4,nextpc3,clk);
	datapath data5(nextpc5,nextpc4,clk);	
	datapath data6(nextpc6,nextpc5,clk);
	datapath data7(nextpc7,nextpc6,clk);
	datapath data8(nextpc8,nextpc7,clk);

	// Stimulate the inputs
	// Define the stimulus module (no ports)
	initial
	begin
		// set input lines
		in=16'd0;
		#10 $display(" input= %b, next pc=%b, clk=%b\n",in,nextpc,clk); //add
		#20 $display("input= %b, next pc=%b, clk=%b\n",nextpc,nextpc1,clk); //sub
		#30 $display("input= %b, next pc=%b, clk=%b\n",nextpc1,nextpc2,clk); //and
		#40 $display("input= %b, next pc=%b, clk=%b\n",nextpc2,nextpc3,clk); //or
		#50 $display("input= %b, next pc=%b, clk=%b\n",nextpc3,nextpc4,clk); //slt
		#60 $display("input= %b, next pc=%b, clk=%b\n",nextpc4,nextpc5,clk); //lw
		#70 $display("input= %b, next pc=%b, clk=%b\n",nextpc5,nextpc6,clk); //sw
		#80 $display("input= %b, next pc=%b, clk=%b\n",nextpc6,nextpc7,clk); //bne
		#90 $display("input= %b, next pc=%b, clk=%b\n",nextpc7,nextpc8,clk); //jump
		
	end
	
endmodule
 
//module datapath
module datapath(nextpc,in,clk);
		input [15:0] in;
		input clk;
		output wire [15:0] nextpc;
		
		//pc
		wire [15:0] mypcout;
		pc mypc(mypcout,in,clk);
		
		//instruction fetch
		wire [15:0] insout;
		insmem ins(insout,mypcout,clk);

		// pc = pc + 2
		wire [15:0] newpc;
		add add1(newpc,mypcout,16'd2);
	
		//control lines
		wire RegDst,Jump,Branch,MemRead,MemtoReg,MemWrite,RegWrite,ALUSrc;
		wire [2:0] ALUOp;
		KURM_controller  con(RegDst,Jump,Branch,MemRead,MemtoReg,MemWrite,ALUSrc,RegWrite,ALUOp,insout[15:12],clk);

		//shift by 1
		wire [12:0] jumpout;
		shift_12_bit shift12(jumpout,insout[11:0]);

		//select write register
		wire [3:0 ]mux1out;
		mux2_to_1_2 mux1(mux1out,insout[3:0],insout[7:4],RegDst);
		
		//register output
		reg [15:0] writeData;
		wire [15:0] regout1,regout2;
		regfile regf(regout1,regout2,insout[11:8],insout[7:4],mux1out,writeData,RegWrite,clk);
		
		//sign extend offset
		wire [15:0] exout;
		sign_extend ex(exout,insout[3:0]);
		
		//shift sign extended value
		wire [15:0] shift16out;
		shift_16_bit shift16(shift16out,exout);

		//create branch address
		wire [15:0] branchaddress;
		add add2(branchaddress,newpc,shift16out);

		//select alu input2
		wire [15:0] mux2out;
		mux2_to_1 mux2(mux2out,regout2,exout,ALUSrc);
		
		//alu output
		wire [15:0] aluout;
		wire lt,zero,gt,overflow;
		alu myalu(regout1,mux2out,aluout,lt,zero,gt,overflow,ALUOp);

		//select whether branch or not
		wire [15:0] mux3out;
		mux2_to_1 mux3(mux3out,newpc,branchaddress,Branch & zero);
		
		//read data from memory or write data into memory
		wire [15:0] readData;
		datamem data(readData,aluout,regout2,MemWrite,MemRead,clk);
		
		//check whether MemToReg
		wire [15:0] mux4out;
		mux2_to_1 mux4(mux4out,aluout,readData,MemtoReg);	
		
		//write data into regfile
		wire [15:0] reg2out1,reg2out2;
		regfile reg2(reg2out1,reg2out2,insout[11:8],insout[7:4],mux1out,mux4out,RegWrite,clk);

		//select next pc
		mux2_to_1 mux5out(nextpc,mux3out,{newpc[15:13],jumpout[12:0]},Jump);
	
endmodule


//module 1 pc
module pc(out,in,clk);
	
	// Port declarations
	output reg [15:0] out;
	input [15:0] in;
	input clk;
	
	always @(posedge clk)
	begin	
		out=in;
	end	
	
endmodule

//module 2 instruction memory
module insmem(out,address,clk);
	
	output reg [15:0]  out;
	input [15:0] address;
	input clk;
	
	reg [15:0] insMem [19:0]; //19 registers of size 16bits
	initial 
	begin
		insMem [0][15:0] = 16'b0010000000011001; //add r0+r1=r9	
		insMem [2][15:0] = 16'b0110001101001010; //sub r3-r4=r10	
		insMem [4][15:0] = 16'b0000010010001011; //and r4&r8=r11	
		insMem [6][15:0] = 16'b0001011010011100; //or r6|r9=r12	
		insMem [8][15:0] = 16'b0111010101111101; //slt r5<r7 -> r13=1	
		insMem [10][15:0] = 16'b1000110100000100; //lw r0<- r13+4
		insMem [12][15:0] = 16'b1010110000010110; //sw r1->r12+6
		insMem [14][15:0] = 16'b1110011110000001; //bne r7!=r8 -> pc=pc+1+2	
		insMem [16][15:0] = 16'b0010000000011001; //add r0+r1=r9
		insMem [18][15:0] = 16'b1111000000000100; //jump pc=pc[15:13]:12'd8:1'b0		
	end

	always @(posedge clk)
		out[15:0] = insMem [address][15:0];

endmodule

//module 3 register file
module regfile(out1,out2,read1,read2,write,writeData,regWrite,clk);
	
	reg [15:0] regFile [15:0]; //16 registers of size 16bits
	output reg [15:0]  out1,out2;
	input [15:0] writeData;
	input [3:0] write,read1,read2;
	input clk,regWrite;
	
	initial
	begin
		regFile [0][15:0] = 16'd2;	regFile [8][15:0] = 16'b0;  
		regFile [1][15:0] = 16'd4;	regFile [9][15:0] = 16'd0;
		regFile [2][15:0] = 16'd6;	regFile [10][15:0] = 16'd0;
		regFile [3][15:0] = 16'd8;	regFile [11][15:0] = 16'd0;
		regFile [4][15:0] = 16'd10;	regFile [12][15:0] = 16'd0;
		regFile [5][15:0] = 16'd12;	regFile [13][15:0] = 16'd0;
		regFile [6][15:0] = 16'd14;	regFile [14][15:0] = 16'd0;
		regFile [7][15:0] = 16'd16;	regFile [15][15:0] = 16'd0;
	end
	always @(negedge clk)
	begin
		out1 = regFile[read1];
		out2 = regFile[read2];
	end

	always @(posedge clk)
	if(regWrite==1)
	begin
		regFile[write] = writeData;
	end
		
	
endmodule

//module 4 data memory
module datamem (readData,address,writeData,memWrite,memRead,clk);
	
	output reg [15:0]  readData;
	input [15:0] writeData,address;
	input clk,memRead,memWrite;
	
	reg [15:0] dataMemory [19:0]; //16 registers of size 16bits
	initial
	begin
		dataMemory [0][15:0] = 16'd0;	dataMemory [8][15:0] = 16'd8;  
		dataMemory [1][15:0] = 16'd1;	dataMemory [9][15:0] = 16'd8;
		dataMemory [2][15:0] = 16'd2;	dataMemory [10][15:0] = 16'd10;
		dataMemory [3][15:0] = 16'd3;	dataMemory [11][15:0] = 16'd11;
		dataMemory [4][15:0] = 16'd4;	dataMemory [12][15:0] = 16'd12;
		dataMemory [5][15:0] = 16'd5;	dataMemory [13][15:0] = 16'd13;
		dataMemory [6][15:0] = 16'd6;	dataMemory [14][15:0] = 16'd14;
		dataMemory [7][15:0] = 16'd7;	dataMemory [15][15:0] = 16'd15;
		
	end

	always @(posedge clk)
		if(memWrite==1)
			dataMemory [address][15:0] = writeData;
	
	always @(negedge clk)
		if(memRead==1)
			readData[15:0] = dataMemory[address][15:0];
	
endmodule

//module 5 add
module add(out,in1,in2);
	
	// Port declarations
	output reg [15:0] out;
	input [15:0] in1,in2;
	
	always @(*)
	begin	
		out=in1+in2;
	end	
	
endmodule

//module 6 alu
module alu (Rs,Rt,Rd,lt,eq,gt,overflow,control);

	output reg lt,eq,gt,overflow;
	output reg [15:0] Rd;
	input [2:0]control;
	input [15:0] Rs,Rt;
	
	wire inv[15:0];
	reg [15:0] temp;

	always @(Rs,Rt,control)
	
	begin
		 // add
		if ( control == 3'b010 ) Rd= Rs+Rt; 

		//substract
		else if (control == 3'b011) Rd = ~Rs+16'b1+Rt; 
		
		 // AND
		else if (control == 3'b000) Rd = Rs&Rt;
	
		// OR
		else if (control == 3'b001) Rd = Rs|Rt; 

		// set on less than
		else if (control == 3'b111) 
		begin
		  if(Rs < Rt) Rd = 16'b1;
		  else Rd = 16'b0;
		end

	// asserting the lt,gt,eq,overflow bits


		if( Rs > Rt)
		begin 
		  assign gt = 1'b1;
		  assign lt = 1'b0;
		  assign eq = 1'b1;
		end
		
		else if ( Rs < Rt)
		begin
		  assign gt = 1'b0;
		  assign lt = 1'b1;
		  assign eq = 1'b1;
		end

		else if ( Rs == Rt)
		begin
		  assign gt = 1'b0;
		  assign lt = 1'b0;
		  assign eq = 1'b0;
		end

	end
endmodule

//module 7 sign_extend
module sign_extend(out,in);
	
	// Port declarations
	output reg [15:0] out;
	input [3:0] in;
	
	always @(*)
	begin	
		if(in[3]==0)
			out [15:0]={12'd0,in[3:0]};
		else
			out [15:0]={12'd4095,in[3:0]};

	end	
	
endmodule

//module 8 shift4
module shift_4_bit(out,in,lsb);
	
	// Port declarations
	output reg [3:0] out;
	input [3:0] in;
	input lsb;
	
	always @(*)
	begin	
		out={in[2:0],lsb};

	end	
	
endmodule

//module 9 shift16
module shift_16_bit(out16,in16);

	// Port declarations
	output reg [15:0] out16;
	input [15:0] in16;
	
	wire [3:0] in1= in16[15:12];
	wire [3:0] in2= in16[11:8]; 
	wire [3:0] in3= in16[7:4];
	wire [3:0] in4= in16[3:0];
	
	wire [3:0] out1,out2,out3,out4;

	reg lsb4=1'b0; //initialize  msb and lsb
	reg lsb3=1'b0;
	reg lsb2=1'b0;
	reg lsb1=1'b0;
	
	always @(*)
	begin	
	lsb1=in16[11];
	lsb2=in16[7];
	lsb3=in16[3];
	end
	shift_4_bit shift1(out1,in1,lsb1); // send first 4bit 
	shift_4_bit shift2(out2,in2,lsb2); // send second 4bit 
	shift_4_bit shift3(out3,in3,lsb3); // send third 4bit 
	shift_4_bit shift4(out4,in4,lsb4); // send last 4bit 
	
	
	always @*
		out16 = {out1[3:0], out2[3:0],out3[3:0],out4[3:0]};	//get the output of 16bits  with concatenation
	
endmodule

//module 10 shift12
module shift_12_bit(out13,in12);

	// Port declarations
	output reg [12:0] out13;
	input [11:0] in12;
	
	always @*
		out13 [12:0] = {in12[11:0],1'b0};
	
endmodule

//module 11 mux2x1 16bit
module mux2_to_1 (out,in1,in2, s0);
	
	// Port declarations from the I/O diagram
	output reg [15:0]out;
	input [15:0]in1,in2;
	input s0;

	always @(*)
	begin	
	
	if (s0==1'b0)
		out=in1;
	else
		out = in2;

	end	
	
	
endmodule

//module 12 mux2x1 4bit
module mux2_to_1_2 (out,in1,in2, s0);
	
	// Port declarations from the I/O diagram
	output reg [3:0]out;
	input [3:0]in1,in2;
	input s0;

	always @(*)
	begin	
	
	if (s0==1'b1)
		out=in1;
	else
		out = in2;

	end	
	
	
endmodule

//module 13 control
module KURM_controller (RegDst,Jump,Branch,MemRead,MemtoReg,MemWrite,ALUSrc,RegWrite,ALUOp,opcode,clk);

// Input variables
input [3:0] opcode;
input clk;

//Output variables
output reg RegDst,Jump,Branch,MemRead,MemtoReg,MemWrite,ALUSrc,RegWrite;
output reg [2:0] ALUOp;

always @(posedge clk)
begin

	case(opcode)
	
	4'b0010:  // ADD instruction (Op code is 2), ALUOp = 010
	begin
	RegDst=1; Jump=0; Branch=0; MemRead=0; MemtoReg=0; MemWrite=0; ALUSrc=0; RegWrite=1; ALUOp=3'b010;   
	end
	
	4'b0110: // SUB instruction (Op code is 6) , ALUOp= 011
	begin
	RegDst=1; Jump=0; Branch=0; MemRead=0; MemtoReg=0; MemWrite=0; ALUSrc=0; RegWrite=1; ALUOp=3'b011;   
	end

	4'b0000: // AND insruction (Op code is 0), ALUOp = 000
	begin
	RegDst=1; Jump=0; Branch=0; MemRead=0; MemtoReg=0; MemWrite=0; ALUSrc=0; RegWrite=1; ALUOp=3'b000;   
	end
	
	4'b0001: // OR instruction (Op code is 1), ALUOp = 001
	begin
	RegDst=1; Jump=0; Branch=0; MemRead=0; MemtoReg=0; MemWrite=0; ALUSrc=0; RegWrite=1; ALUOp=3'b001;   
	end
	
	4'b0111: // SLT instruction (Op code is 7) , ALUOp = 111
	begin
	RegDst=1; Jump=0; Branch=0; MemRead=0; MemtoReg=0; MemWrite=0; ALUSrc=0; RegWrite=1; ALUOp=3'b111;   
	end
	
	4'b1000: // LW instruction (Op code is 8), ALUOp = 010
	begin
	RegDst=0; Jump=0; Branch=0; MemRead=1; MemtoReg=1; MemWrite=0; ALUSrc=1; RegWrite=1; ALUOp=3'b010;   
	end
	
	4'b1010: // SW instruction (Op code is A) , ALUOp = 010
	begin
	RegDst=1; Jump=0; Branch=0; MemRead=0; MemtoReg=0; MemWrite=1; ALUSrc=1; RegWrite=0; ALUOp=3'b010;   
	end
	
	4'b1110: // BNE instruction (Op code is E), ALUOp = 110
	begin
	RegDst=0; Jump=0; Branch=1; MemRead=0; MemtoReg=0; MemWrite=0; ALUSrc=0; RegWrite=0; ALUOp=3'b011;   
	end
	
	4'b1111: // JUMP instruction (Op code is F) , No ALUOp
	begin
	RegDst=0; Jump=1; Branch=0; MemRead=0; MemtoReg=0; MemWrite=0; ALUSrc=0; RegWrite=0;  
	end
	
	endcase

end

endmodule

