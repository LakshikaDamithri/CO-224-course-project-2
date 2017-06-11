// Define the stimulus module
module stimulus;

	// Declare variables to be connected to inputs
	reg [11:0]in12;
	wire [11:0]out12;

	shift_12_bit myshift12(out12,in12);
	
	// Stimulate the inputs
	// Define the stimulus module (no ports)
	initial
	begin
	
	/*1*/	in12 = 12'b111100001100;
			#1 $display("1 input= %b, output= %b\n",in12,out12);
		
	/*2*/	in12 = 12'b101011000010;
			#1 $display("2 input= %b, output= %b\n",in12,out12);
		


	end
	
endmodule

module shift_12_bit(out13,in12);

	// Port declarations
	output reg [12:0] out13;
	input [11:0] in12;
	
	always @*
		out13 [12:0] = {in12[11:0],1'b0};
	
endmodule


