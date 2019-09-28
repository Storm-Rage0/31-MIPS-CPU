`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/06 18:32:28
// Design Name: 
// Module Name: CPU_DeInstruction
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module CPU_DeInstruction(
	input [31:0] instruction,
	output [31:0] ins
    );
	wire [11:0] temp_ins;
    reg [31:0]reg_ins;
	assign temp_ins={instruction[31:26],instruction[5:0]};
	always @ (*)begin
        casex(temp_ins)
        //R指令
            12'b000000_100000:reg_ins = 32'h0000_0001;//addu
            12'b000000_100001:reg_ins = 32'h0000_0002;//add
            12'b000000_100010:reg_ins = 32'h0000_0004;//subu
            12'b000000_100011:reg_ins = 32'h0000_0008;//sub
            12'b000000_100100:reg_ins = 32'h0000_0010;//and
            12'b000000_100101:reg_ins = 32'h0000_0020;//or

            12'b000000_100110:reg_ins = 32'h0000_0040;//xor
            12'b000000_100111:reg_ins = 32'h0000_0080;//nor
            12'b000000_101010:reg_ins = 32'h0000_0100;//slt
            12'b000000_101011:reg_ins = 32'h0000_0200;//sltu
            12'b000000_000000:reg_ins = 32'h0000_0400;//sll
            12'b000000_000010:reg_ins = 32'h0000_0800;//srl

            12'b000000_000011:reg_ins = 32'h0000_1000;//sra
            12'b000000_000100:reg_ins = 32'h0000_2000;//sllv
            12'b000000_000110:reg_ins = 32'h0000_4000;//srlv
            12'b000000_000111:reg_ins = 32'h0000_8000;//srav
            12'b000000_001000:reg_ins = 32'h0001_0000;//jr

        //I指令
            12'b001000??????:reg_ins = 32'h0002_0000;//addi
            12'b001001??????:reg_ins = 32'h0004_0000;//addiu
            12'b001100??????:reg_ins = 32'h0008_0000;//andi
            12'b001101??????:reg_ins = 32'h0010_0000;//ori
            12'b001110??????:reg_ins = 32'h0020_0000;//xori
            12'b100011??????:reg_ins = 32'h0040_0000;//lw

            12'b101011??????:reg_ins = 32'h0080_0000;//sw 
            12'b000100??????:reg_ins = 32'h0100_0000;//beq 
            12'b000101??????:reg_ins = 32'h0200_0000;//bne 
            12'b001010??????:reg_ins = 32'h0400_0000;//slti 
            12'b001011??????:reg_ins = 32'h0800_0000;//sltiu 
            12'b001111??????:reg_ins = 32'h1000_0000;//lui

         //J指令
            12'b000010??????:reg_ins = 32'h2000_0000;//j
            12'b000011??????:reg_ins = 32'h4000_0000;//jal

            default: reg_ins = 32'bx;
    endcase  
    
    end//end always
	assign ins=reg_ins;
	
	
	
endmodule
