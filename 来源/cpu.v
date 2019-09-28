`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/11 23:49:59
// Design Name: 
// Module Name: cpu
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

module cpu(
    input         clk,
    input         reset,
    input  [31:0] inst,
    input  [31:0] rdata,    //dmem读取数据
    output [31:0] addr_imem,
    output [31:0] addr_dmem,
    output [31:0] wdata,    //写入dmem数据
    output [31:0] pc,
    output        IM_R,     //指令寄存器读取
    output        DM_CS,
    output        DM_R,
    output        DM_W
    );
    
    wire PC_CLK;                     
    wire PC_ENA;                     
    wire [1:0]mux_pc;                         
    wire mux_rdc;                         
    wire [1:0]mux_rd;                         
    wire mux_ext5;                         
    wire mux_a;                         
    wire [1:0]mux_b;                         
    wire [3:0] aluc;                 
    wire RF_W;                       
    wire RF_CLK;                     
    
    //ALU
    wire zero;                       
    wire carry;                      
    wire negative;                   
    wire overflow;                   
    wire add_overflow;               
    
    wire [31:0] INS;         
    
    //数据段
    wire [31:0] D_ALU;               
    wire [31:0] D_PC;                
    wire [31:0] D_RF;                
    wire [31:0] D_Rs;                
    wire [31:0] D_Rt;                
    wire [31:0] D_IM;                
    wire [31:0] D_DM;                
    wire [31:0] D_mux_pc;              
    wire [4:0] D_mux_rdc;              
    wire [4:0] D_mux_rdc2;
    wire [31:0] D_mux_rd;              
    wire [4:0]  D_mux_ext5;              
    wire [31:0] D_mux_a;              
    wire [31:0] D_mux_b;              
    
    wire [31:0] D_S_EXT16;              
    wire [31:0] D_EXT5;              
    wire [31:0] D_EXT16;             
    wire [31:0] D_S_EXT18;             
    wire [31:0] D_ADD;               
    wire [31:0] D_ADD8;              
    wire [31:0] D_NPC;               
    wire [31:0] D_II;    

    assign PC_ENA = 1;
    
    assign addr_imem = D_PC;
    assign addr_dmem = D_ALU;
    assign wdata = D_Rt;
    assign pc=D_PC;
    assign D_DM = rdata;
   

    
    CPU_DeInstruction cpu_ins(inst,INS);
    CPU_Option cpu_opcode (clk,zero,INS,PC_CLK,IM_R,mux_pc,mux_rd,mux_rdc,mux_rdc2,mux_ext5,mux_a,mux_b,aluc,RF_W,RF_CLK,DM_R,DM_W,DM_CS);
    
    pcreg   pc_out      (clk,reset,PC_ENA,D_mux_pc,D_PC);
    ALU     cpu_alu     (D_mux_a,D_mux_b,aluc,D_ALU,zero,carry,negative,overflow);
    regfile cpu_ref     (RF_CLK,reset,RF_W,inst[25:21],inst[20:16],D_mux_rdc,D_mux_rd,D_Rs,D_Rt);

    MUX_4   cpu_mux_pc  (D_NPC,D_Rs,D_ADD,D_II,mux_pc,D_mux_pc);
    MUX_4   cpu_mux_rd  ({inst[15:0],16'b0},D_ADD8,D_DM,D_ALU,mux_rd,D_mux_rd);
    MUX_4   cpu_mux_b   (.a1(D_Rt),.a2(D_S_EXT16),.a3(D_EXT16),.a4(32'b0),.choose(mux_b),.z(D_mux_b));
    MUX5    cpu_muxext5    (inst[10:6],D_Rs[4:0],mux_ext5,D_mux_ext5);
    MUX5   cpu_rdc     (inst[15:11],D_mux_rdc2,mux_rdc,D_mux_rdc);
    MUX5     cpr_rdc2    (inst[20:16],5'b11111,mux_rdc2,D_mux_rdc2);
    MUX_2   cpu_mux_a   (D_Rs,D_EXT5,mux_a,D_mux_a);
    
    Ext5 cpu_ext5    (D_mux_ext5,D_EXT5);
    Ext16 cpu_ext16  (inst[15:0],D_EXT16);
    S_Ext16 cpu_s_ext16(inst[15:0],D_S_EXT16);
    S_Ext18 cpu_s_ext18  (inst[15:0], D_S_EXT18);
    Add     cpu_add     (D_S_EXT18,D_NPC,D_ADD,add_overflow);
    Add8    cpu_add8    (D_PC,D_ADD8);
    npc     cpu_npc     (D_PC,reset,D_NPC);
    II      cpu_II      (D_NPC[31:28],inst[25:0], D_II);
    
endmodule
