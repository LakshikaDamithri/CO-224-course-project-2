module stimulus;
	//declaring variables
	reg [3:0] inp;
	reg load, hold, c_up,c_down,enable, clk;
	wire [3:0] out;

	counter mycounter (load, hold, c_up, c_down, inp, enable, clk, out );

	initial
	begin
		// setting input lines
		// load
		load = 1; hold= 0; c_up =0; c_down = 0; enable = 1; clk=0; inp= 4'd2;
		#1 $display("OUTPUT = %b \n", out);
		load = 1; hold= 0; c_up =0; c_down = 0; enable = 1; clk=1; inp= 4'd2;
		#1 $display("OUTPUT = %b \n", out);
		
		//hold
		load = 0; hold= 1; c_up =0; c_down = 0; enable = 1; clk=0;
		#1 $display("OUTPUT = %b \n", out);
		load = 0; hold= 1; c_up =0; c_down = 0; enable = 1; clk=1; 
		#1 $display("OUTPUT = %b \n", out);

		// count up
		load = 0; hold= 0; c_up =1; c_down = 0; enable = 1; clk=0;
		#1 $display("OUTPUT = %b \n", out);
		load = 0; hold= 0; c_up =1; c_down = 0; enable = 1; clk=1;
		#1 $display("OUTPUT = %b \n", out);

		// count down
		load = 0; hold= 0; c_up =0; c_down = 1; enable = 1; clk=0; 
		#1 $display("OUTPUT = %b \n", out);
		load = 0; hold= 0; c_up =0; c_down = 1; enable = 1; clk=1;
		#1 $display("OUTPUT = %b \n", out);
		
		
	end

endmodule



module counter (load , hold, count_up, count_down, initial_value, En , clk, out);
	output reg [3:0] out;
	input [3:0]initial_value;
	input load, hold, count_up, count_down,clk,En; 

	always @(posedge clk)
	begin
		if (En == 1 && load == 1) out = initial_value;
		else if ( En == 1 && hold == 1) out = out;
		else if (En == 1 && count_up == 1) out = out + 1;
		else if (En ==1 && count_down == 1) out = out - 1 ;
	end


endmodule
