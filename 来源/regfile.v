`timescale 1ns / 1ns
module regfile(
    input clk, //下降沿写入数�?
    input rst, //reset异步复位高有�?
    input we, //寄存器读写有效信号，高电平时允许寄存器写入数�?
    input [4:0] raddr1, 
    input [4:0] raddr2, 
    input [4:0] waddr, 	//写入地址
    input [31:0] wdata, //写入数据
    output [31:0] rdata1, 
    output [31:0] rdata2   
    );

    reg [31:0] array_reg[31:0];
	integer i;
	initial begin
		for(i = 0; i < 32; i = i +1) begin
			array_reg[i] <= 32'b0;
		end
	end

	
	
	always @(posedge clk or posedge rst) begin
		if(rst) begin
			for(i = 0;i < 32;i = i + 1)
				array_reg[i] <= 0;
		end
		else 
		begin
		    if(waddr&&we)
				array_reg[waddr] <= wdata;
		end
	end
assign rdata1 = array_reg[raddr1];
        assign rdata2 = array_reg[raddr2];
endmodule
