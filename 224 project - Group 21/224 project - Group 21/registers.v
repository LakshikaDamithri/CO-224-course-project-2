// Define the stimulus module (no ports)
module stimulus;
 
	//Declare inputs
	reg [3:0] read1,read2,write;
	reg [15:0] writeData;
	reg regWrite,clk;
	
	// Declare output wire
	wire [15:0] out1,out2;
	
	// Instantiate the multiplexer
	regfile myreg(out1,out2,read1,read2,write,writeData,regWrite,clk);
	
	// Stimulate the inputs
	// Define the stimulus module (no ports)
	initial
	begin
		// set input lines
		read1=16'd7 ; read2=16'd4 ; write=16'd10 ; writeData=16'd20 ; regWrite=16'd0 ; clk=0;
		#1 $display("read1= %b, read2= %b, out1= %b, out2= %b,write= %b, writeData= %b, regWrite= %b, clk=%b\n",read1,read2,out1,out2,write,writeData,regWrite,clk);
		read1=16'd7 ; read2=16'd4 ; write=16'd10 ; writeData=16'd20 ; regWrite=16'd1 ; clk=1;
		#1 $display("read1= %b, read2= %b, out1= %b, out2= %b,write= %b, writeData= %b, regWrite= %b, clk=%b\n",read1,read2,out1,out2,write,writeData,regWrite,clk);
		read1=16'd10 ; read2=16'd5 ; write=16'd10 ; writeData=16'd20 ; regWrite=16'd0 ; clk=0;
		#1 $display("read1= %b, read2= %b, out1= %b, out2= %b,write= %b, writeData= %b, regWrite= %b, clk=%b\n",read1,read2,out1,out2,write,writeData,regWrite,clk);

	end
	
endmodule


// module instruction memory.
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