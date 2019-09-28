`timescale 1ns / 1ps
module Asynchronous_D_FF(
    input CLK,
    input D,
    input RST_n,//high
	input ENA,
    output reg Q1
    );
    always @ (negedge CLK or posedge RST_n)
    begin
    if(RST_n==1)
        Q1<=0;
    else if(ENA!=0)
        Q1<=D;
	else
		Q1<=Q1;
    end//end always
endmodule
    