// Define the stimulus module
module stimulus;

	// Declare variables to be connected to inputs
	reg [15:0]in16;
	wire [15:0]out16;

	shift_16_bit myshift16(out16,in16);
	
	// Stimulate the inputs
	// Define the stimulus module (no ports)
	initial
	begin
	
	/*1*/	in16 = 16'b1111000011001100;
			#1 $display("1 input= %b, output= %b\n",in16,out16);
		
	/*2*/	in16 = 16'b1010110000100010;
			#1 $display("2 input= %b, output= %b\n",in16,out16);
		


	end
	
endmodule

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


