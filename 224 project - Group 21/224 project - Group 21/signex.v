// Define the stimulus module
module stimulus;

	// Declare variables to be connected to inputs
	reg [3:0]in;
	wire [15:0]out;

	sign_extend signex(out,in);
	
	// Stimulate the inputs
	// Define the stimulus module (no ports)
	initial
	begin
	
	/*1*/	in = 4'b1101;
			#1 $display("1 input= %b, output= %b\n",in,out);
		
	/*2*/	in = 4'b0101;
			#1 $display("2 input= %b, output= %b\n",in,out);
		


	end
	
endmodule

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



