`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/06 18:33:00
// Design Name: 
// Module Name: CPU_Option
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


module CPU_Option(
    input clk,
    input if_equal,
    input [31:0] ins,
    output PC_CLK,
    output IM_R,
    output [1:0] MUX_PC,
    output [1:0] MUX_Rd,
    output MUX_Rdc,
    output MUX_Rdc2,
    output MUX_Ext5,
    output MUX_A,
    output [1:0]MUX_B,
    output [3:0] ALU,
    output RF_W,
    output RF_CLK,
    output DM_r,
    output DM_w,
    output DM_CS
    );

    assign PC_CLK=clk;
    assign RF_CLK=clk;
    assign IM_R=1'b1;
    assign MUX_PC[0]=(ins[16]|ins[29]|ins[30]);
    assign MUX_PC[1]=((ins[24]&if_equal)|(ins[25]&~if_equal)|ins[29]|ins[30]);
    assign MUX_Rd[0]=~(ins[16]|ins[22]|ins[23]|ins[24]|ins[25]|ins[28]|ins[29]);
    assign MUX_Rd[1]=~(ins[16]|ins[23]|ins[24]|ins[25]|ins[28]|ins[29]|ins[30]);
    assign MUX_Rdc=~(ins[15]|ins[14]|ins[13]|ins[12]|ins[11]|ins[10]|ins[9]|ins[8]|ins[7]|ins[6]|ins[5]|ins[4]|ins[3]|ins[2]|ins[1]|ins[0]);
    assign MUX_Rdc2=ins[30];
    assign MUX_Ext5=(ins[13]|ins[14]|ins[15]);
    assign MUX_A=(ins[10]|ins[11]|ins[12]|ins[13]|ins[14]|ins[15]);
    assign MUX_B[0]=(ins[17]|ins[18]|ins[22]|ins[23]|ins[26]|ins[27]);
    assign MUX_B[1]=(ins[19]|ins[20]|ins[21]);
    //assign MUX_ADD=ins[30];
    assign ALU[0]=ins[2]|ins[3]|ins[5]|ins[7]|ins[8]|ins[11]|ins[14]|ins[20]|ins[26]|ins[24]|ins[25];
    assign ALU[1]=ins[1]|ins[3]|ins[6]|ins[7]|ins[8]|ins[9]|ins[10]|ins[13]|ins[17]|ins[21]|ins[26]|ins[27]|ins[24]|ins[25];
    assign ALU[2]=ins[4]|ins[5]|ins[6]|ins[7]|ins[10]|ins[11]|ins[12]|ins[13]|ins[14]|ins[15]|ins[19]|ins[20]|ins[21];
    assign ALU[3]=ins[8]|ins[9]|ins[10]|ins[11]|ins[12]|ins[13]|ins[14]|ins[15]|ins[26]|ins[27];
    assign RF_W=~(ins[16]|ins[23]|ins[24]|ins[25]|ins[29]);
    
    assign DM_r=ins[22];
    assign DM_w=ins[23];
    assign DM_CS=ins[22]|ins[23];


endmodule
