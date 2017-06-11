
module stimulus;

// Input variables
reg [3:0] opcode;
reg clk;

//Output variables
wire RegDst,Jump,Branch,MemRead,MemtoReg,MemWrite,ALUSrc,RegWrite;
wire [2:0] ALUOp;


KURM_controller con(RegDst,Jump,Branch,MemRead,MemtoReg,MemWrite,ALUSrc,RegWrite,ALUOp,opcode,clk);

initial
begin

// Possible input combinations	
	clk=0; opcode=4'b0010;  // ADD
	#1 $display("1	clock=%b,op_code=%b,RegDest=%b,Jump=%b,Branch=%b,MemRead=%b,MemToReg=%b,MemWrite=%b,ALUSrc=%b,RegWrite=%b,ALUOp=%b",clk,opcode,RegDst,Jump,Branch,MemRead,MemtoReg,MemWrite,ALUSrc,RegWrite,ALUOp);
	
	clk=1; opcode=4'b0010; 
	#1 $display("	clock=%b,op_code=%b,RegDest=%b,Jump=%b,Branch=%b,MemRead=%b,MemToReg=%b,MemWrite=%b,ALUSrc=%b,RegWrite=%b,ALUOp=%b",clk,opcode,RegDst,Jump,Branch,MemRead,MemtoReg,MemWrite,ALUSrc,RegWrite,ALUOp);


	clk=0; opcode=4'b0110;  // SUB
	#1 $display("2	clock=%b,op_code=%b,RegDest=%b,Jump=%b,Branch=%b,MemRead=%b,MemToReg=%b,MemWrite=%b,ALUSrc=%b,RegWrite=%b,ALUOp=%b",clk,opcode,RegDst,Jump,Branch,MemRead,MemtoReg,MemWrite,ALUSrc,RegWrite,ALUOp);
	
	clk=1; opcode=4'b0110; 
	#1 $display("	clock=%b,op_code=%b,RegDest=%b,Jump=%b,Branch=%b,MemRead=%b,MemToReg=%b,MemWrite=%b,ALUSrc=%b,RegWrite=%b,ALUOp=%b",clk,opcode,RegDst,Jump,Branch,MemRead,MemtoReg,MemWrite,ALUSrc,RegWrite,ALUOp);
	

	clk=0; opcode=4'b0000;  // AND
	#1 $display("3	clock=%b,op_code=%b,RegDest=%b,Jump=%b,Branch=%b,MemRead=%b,MemToReg=%b,MemWrite=%b,ALUSrc=%b,RegWrite=%b,ALUOp=%b",clk,opcode,RegDst,Jump,Branch,MemRead,MemtoReg,MemWrite,ALUSrc,RegWrite,ALUOp);

	clk=1; opcode=4'b0000; 
	#1 $display("	clock=%b,op_code=%b,RegDest=%b,Jump=%b,Branch=%b,MemRead=%b,MemToReg=%b,MemWrite=%b,ALUSrc=%b,RegWrite=%b,ALUOp=%b",clk,opcode,RegDst,Jump,Branch,MemRead,MemtoReg,MemWrite,ALUSrc,RegWrite,ALUOp);
	

	clk=0; opcode=4'b0001;  // ORR
	#1 $display("4	clock=%b,op_code=%b,RegDest=%b,Jump=%b,Branch=%b,MemRead=%b,MemToReg=%b,MemWrite=%b,ALUSrc=%b,RegWrite=%b,ALUOp=%b",clk,opcode,RegDst,Jump,Branch,MemRead,MemtoReg,MemWrite,ALUSrc,RegWrite,ALUOp);

	clk=1; opcode=4'b0001; 
	#1 $display("	clock=%b,op_code=%b,RegDest=%b,Jump=%b,Branch=%b,MemRead=%b,MemToReg=%b,MemWrite=%b,ALUSrc=%b,RegWrite=%b,ALUOp=%b",clk,opcode,RegDst,Jump,Branch,MemRead,MemtoReg,MemWrite,ALUSrc,RegWrite,ALUOp);
	

	clk=0; opcode=4'b0111;  // SLT
	#1 $display("5	clock=%b,op_code=%b,RegDest=%b,Jump=%b,Branch=%b,MemRead=%b,MemToReg=%b,MemWrite=%b,ALUSrc=%b,RegWrite=%b,ALUOp=%b",clk,opcode,RegDst,Jump,Branch,MemRead,MemtoReg,MemWrite,ALUSrc,RegWrite,ALUOp);

	clk=1; opcode=4'b0111; 
	#1 $display("	clock=%b,op_code=%b,RegDest=%b,Jump=%b,Branch=%b,MemRead=%b,MemToReg=%b,MemWrite=%b,ALUSrc=%b,RegWrite=%b,ALUOp=%b",clk,opcode,RegDst,Jump,Branch,MemRead,MemtoReg,MemWrite,ALUSrc,RegWrite,ALUOp);
	

	clk=0; opcode=4'b1000;  // LW
	#1 $display("6	clock=%b,op_code=%b,RegDest=%b,Jump=%b,Branch=%b,MemRead=%b,MemToReg=%b,MemWrite=%b,ALUSrc=%b,RegWrite=%b,ALUOp=%b",clk,opcode,RegDst,Jump,Branch,MemRead,MemtoReg,MemWrite,ALUSrc,RegWrite,ALUOp);

	clk=1; opcode=4'b1000; 
	#1 $display("	clock=%b,op_code=%b,RegDest=%b,Jump=%b,Branch=%b,MemRead=%b,MemToReg=%b,MemWrite=%b,ALUSrc=%b,RegWrite=%b,ALUOp=%b",clk,opcode,RegDst,Jump,Branch,MemRead,MemtoReg,MemWrite,ALUSrc,RegWrite,ALUOp);
	

	clk=0; opcode=4'b1010;  // SW
	#1 $display("7	clock=%b,op_code=%b,RegDest=%b,Jump=%b,Branch=%b,MemRead=%b,MemToReg=%b,MemWrite=%b,ALUSrc=%b,RegWrite=%b,ALUOp=%b",clk,opcode,RegDst,Jump,Branch,MemRead,MemtoReg,MemWrite,ALUSrc,RegWrite,ALUOp);

	clk=1; opcode=4'b1010; 
	#1 $display("	clock=%b,op_code=%b,RegDest=%b,Jump=%b,Branch=%b,MemRead=%b,MemToReg=%b,MemWrite=%b,ALUSrc=%b,RegWrite=%b,ALUOp=%b",clk,opcode,RegDst,Jump,Branch,MemRead,MemtoReg,MemWrite,ALUSrc,RegWrite,ALUOp);
	

	clk=0; opcode=4'b1110;  // BNE
	#1 $display("8	clock=%b,op_code=%b,RegDest=%b,Jump=%b,Branch=%b,MemRead=%b,MemToReg=%b,MemWrite=%b,ALUSrc=%b,RegWrite=%b,ALUOp=%b",clk,opcode,RegDst,Jump,Branch,MemRead,MemtoReg,MemWrite,ALUSrc,RegWrite,ALUOp);

	clk=1; opcode=4'b1110; 
	#1 $display("	clock=%b,op_code=%b,RegDest=%b,Jump=%b,Branch=%b,MemRead=%b,MemToReg=%b,MemWrite=%b,ALUSrc=%b,RegWrite=%b,ALUOp=%b",clk,opcode,RegDst,Jump,Branch,MemRead,MemtoReg,MemWrite,ALUSrc,RegWrite,ALUOp);
	

	clk=0; opcode=4'b1111;  // JUMP
	#1 $display("9	clock=%b,op_code=%b,RegDest=%b,Jump=%b,Branch=%b,MemRead=%b,MemToReg=%b,MemWrite=%b,ALUSrc=%b,RegWrite=%b",clk,opcode,RegDst,Jump,Branch,MemRead,MemtoReg,MemWrite,ALUSrc,RegWrite);

	clk=1; opcode=4'b1111;
	#1 $display("	clock=%b,op_code=%b,RegDest=%b,Jump=%b,Branch=%b,MemRead=%b,MemToReg=%b,MemWrite=%b,ALUSrc=%b,RegWrite=%b",clk,opcode,RegDst,Jump,Branch,MemRead,MemtoReg,MemWrite,ALUSrc,RegWrite);
	
end

endmodule


// Module for the KURM controller
module KURM_controller (RegDst,Jump,Branch,MemRead,MemtoReg,MemWrite,ALUSrc,RegWrite,ALUOp,opcode,clk);

// Input variables
input [3:0] opcode;
input clk;

//Output variables
output reg RegDst,Jump,Branch,MemRead,MemtoReg,MemWrite,ALUSrc,RegWrite;
output reg [2:0] ALUOp;

always @(posedge clk)
begin

	case(opcode)
	
	4'b0010:  // ADD instruction (Op code is 2), ALUOp = 010
	begin
	RegDst=1; Jump=0; Branch=0; MemRead=0; MemtoReg=0; MemWrite=0; ALUSrc=0; RegWrite=1; ALUOp=3'b010;   
	end
	
	4'b0110: // SUB instruction (Op code is 6) , ALUOp= 011
	begin
	RegDst=1; Jump=0; Branch=0; MemRead=0; MemtoReg=0; MemWrite=0; ALUSrc=0; RegWrite=1; ALUOp=3'b011;   
	end

	4'b0000: // AND insruction (Op code is 0), ALUOp = 000
	begin
	RegDst=1; Jump=0; Branch=0; MemRead=0; MemtoReg=0; MemWrite=0; ALUSrc=0; RegWrite=1; ALUOp=3'b000;   
	end
	
	4'b0001: // OR instruction (Op code is 1), ALUOp = 001
	begin
	RegDst=1; Jump=0; Branch=0; MemRead=0; MemtoReg=0; MemWrite=0; ALUSrc=0; RegWrite=1; ALUOp=3'b001;   
	end
	
	4'b0111: // SLT instruction (Op code is 7) , ALUOp = 111
	begin
	RegDst=1; Jump=0; Branch=0; MemRead=0; MemtoReg=0; MemWrite=0; ALUSrc=0; RegWrite=1; ALUOp=3'b111;   
	end
	
	4'b1000: // LW instruction (Op code is 8), ALUOp = 010
	begin
	RegDst=0; Jump=0; Branch=0; MemRead=1; MemtoReg=1; MemWrite=0; ALUSrc=1; RegWrite=1; ALUOp=3'b010;   
	end
	
	4'b1010: // SW instruction (Op code is A) , ALUOp = 010
	begin
	RegDst=1; Jump=0; Branch=0; MemRead=0; MemtoReg=0; MemWrite=1; ALUSrc=1; RegWrite=0; ALUOp=3'b010;   
	end
	
	4'b1110: // BNE instruction (Op code is E), ALUOp = 110
	begin
	RegDst=0; Jump=0; Branch=1; MemRead=0; MemtoReg=0; MemWrite=0; ALUSrc=0; RegWrite=0; ALUOp=3'b011;   
	end
	
	4'b1111: // JUMP instruction (Op code is F) , No ALUOp
	begin
	RegDst=0; Jump=1; Branch=0; MemRead=0; MemtoReg=0; MemWrite=0; ALUSrc=0; RegWrite=0;  
	end
	
	endcase

end

endmodule
