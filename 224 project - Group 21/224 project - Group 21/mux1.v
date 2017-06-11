// Define the stimulus module (no ports)
module stimulus;

	// Declare variables to be connected
	// to inputs
	reg [15:0]in1,in2;
	reg s0;
	
	// Declare output wire
	wire [15:0] out;
	
	// Instantiate the multiplexer
	mux2_to_1 mymux(out,in1,in2,s0);
	
	// Stimulate the inputs
	// Define the stimulus module (no ports)
	initial
	begin
		// set input lines
		in1=16'd10;in2=16'd15;s0=0;
		#1 $display("out= %b, in2= %b, in2= %b,s0= %b\n",out,in1,in2,s0);
		in1=16'd10;in2=16'd15;s0=1;
		#1 $display("out= %b, in2= %b, in2= %b,s0= %b\n",out,in1,in2,s0);

	end
	
endmodule


// Module 4-to-1 multiplexer. Port list is taken exactly from
// the I/O diagram.
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
