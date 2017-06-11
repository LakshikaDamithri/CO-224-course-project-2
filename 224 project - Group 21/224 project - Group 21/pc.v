// Define the stimulus module
module stimulus;

	// Declare variables to be connected to inputs
	reg [15:0]in;
	reg clk;
	wire [15:0]out;

	pc mypc(out,in,clk);
	
	// Stimulate the inputs
	// Define the stimulus module (no ports)
	initial
	begin
	
	/*1*/	in = 16'd10;	clk=0;
			#1 $display("1 in= %b , output= %b , in1= %b\n",in,out,clk);
	/*1*/	in = 16'd20;	clk=1;
			#1 $display("1 in= %b , output= %b , in1= %b\n",in,out,clk);
	/*1*/	in = 16'd3;	clk=0;
			#1 $display("1 in= %b , output= %b , in1= %b\n",in,out,clk);		


	end
	
endmodule

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



