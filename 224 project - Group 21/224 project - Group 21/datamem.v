// Define the stimulus module (no ports)
module stimulus;
 
	//Declare inputs
	reg [15:0] writeData,address;
	reg memRead,memWrite,clk;
	
	// Declare output wire
	wire [15:0] readData;
	
	// Instantiate the multiplexer
	datamem data(readData,address,writeData,memWrite,memRead,clk);
	
	// Stimulate the inputs
	// Define the stimulus module (no ports)
	initial
	begin
		// set input lines
		address = 16'd11 ; writeData=16'd20 ; memWrite=1 ; memRead=0; clk=0;
		#1 $display("address= %b, readData = %b, writeData = %b, memWrite= %b, memRead = %b, clk= %b\n",
		address,readData,writeData,memWrite,memRead,clk);
		address = 16'd14 ; writeData=16'd15 ; memWrite= 1; memRead=0; clk=1;
		#1 $display("store -> address= %b, readData = %b, writeData = %b, memWrite= %b, memRead = %b, clk= %b\n",
		address,readData,writeData,memWrite,memRead,clk);
		address = 16'd14 ; writeData=16'd2; memWrite=1 ; memRead=1; clk=0;
		#1 $display("load -> address= %b, readData = %b, writeData = %b, memWrite= %b, memRead = %b, clk= %b\n",
		address,readData,writeData,memWrite,memRead,clk);
		address = 16'd10 ; writeData=16'd30 ; memWrite=1 ; memRead=0; clk=1;
		#1 $display("store -> address= %b, readData = %b, writeData = %b, memWrite= %b, memRead = %b, clk= %b\n",
		address,readData,writeData,memWrite,memRead,clk);
	end
	
endmodule


// module instruction memory.
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