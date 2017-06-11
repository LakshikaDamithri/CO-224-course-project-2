// Define the stimulus module (no ports)
module stimulus;
 
	//Declare inputs
	reg [15:0] address;
	reg clk;
	
	// Declare output wire
	wire [15:0] out;
	
	// Instantiate the multiplexer
	insmem ins(out,address,clk);
	
	// Stimulate the inputs
	// Define the stimulus module (no ports)
	initial
	begin
		// set input lines
		address= 16'd6;clk=0;
		#1 $display("address= %b, out= %b, clk=%b\n",address,out,clk);
		address=16'd2; clk=1;
		#1 $display("address= %b, out= %b, clk=%b\n",address,out,clk);
		address=16'd10; clk=0;
		#1 $display("address= %b, out= %b, clk=%b\n",address,out,clk);

	end
	
endmodule


// module instruction memory.
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