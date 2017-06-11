// Define the stimulus module
module stimulus;

	// Declare variables to be connected to inputs
	reg [15:0]in1,in2;
	wire [15:0]out;

	add add2(out,in1,in2);
	
	// Stimulate the inputs
	// Define the stimulus module (no ports)
	initial
	begin
	
	/*1*/	in1 = 16'd10;	in2 = 16'd10;
			#1 $display("1 in1= %b, in1= %b, output= %b\n",in1,in2,out);
		
	/*2*/	in1 = 16'd2;	in2 = 16'd10;
			#1 $display("2 in1= %b, in1= %b, output= %b\n",in1,in2,out);
		


	end
	
endmodule

module add(out,in1,in2);
	
	// Port declarations
	output reg [15:0] out;
	input [15:0] in1,in2;
	
	always @(*)
	begin	
		out=in1+in2;
	end	
	
endmodule



