`timescale 1ns / 1ps

module sccomp_dataflow(
    input clk_in,
    input reset,
    output [31:0] inst,
    output [31:0] pc  
    //output [7:0]o_seg,//鏄剧ず鏁板瓧
    //output [7:0]o_sel//閫夋嫨鏁扮爜锟�?????
    );
   
    //wire [31:0] pc;
    //wire [31:0] inst;
    wire [31:0]rdata;   
    wire [31:0]addr_imem;
    wire [31:0]addr_dmem;
    wire [31:0]wdata;
    wire IM_R;
    wire DM_CS;
    wire DM_R;
    wire DM_W;

    assign clk=clk_in;
    //Divider divider(clk_in,reset,clk);
    cpu sccpu(clk,reset,inst,rdata,addr_imem,addr_dmem,wdata,pc,IM_R,DM_CS,DM_R,DM_W);
    //seg7x16 segment(clk_in,reset,1'b1,addr_imem,o_seg,o_sel);
    IMEM_ip scimem(addr_imem[12:2],inst);
    DMEM scdmem(clk,DM_CS,DM_W,DM_R,addr_dmem[12:2],wdata,rdata);
    

endmodule