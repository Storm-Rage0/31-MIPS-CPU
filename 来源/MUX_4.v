`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/07 10:04:16
// Design Name: 
// Module Name: MUX_4
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


module MUX_4(
    input [31:0]a1,
    input [31:0]a2,
    input [31:0]a3,
    input [31:0]a4,
    input [1:0]choose,
    output [31:0]z
    );

    assign z=(choose[0])?(choose[1]?a4:a2):(choose[1]?a3:a1);

endmodule
