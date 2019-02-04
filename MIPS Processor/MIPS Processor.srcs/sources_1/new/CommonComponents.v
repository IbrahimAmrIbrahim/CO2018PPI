`timescale 1ns / 1ps

module InstructionMemory();

endmodule


module DataMemory(READ_DATA,ADDRESS,WRITE_DATA,MEM_WRITE,MEM_READ);
input [31:0]ADDRESS,WRITE_DATA;
input MEM_READ,MEM_WRITE;
output reg [31:0] READ_DATA;
reg [7:0] memory [0:4294967295];

always@(*)
begin
if(MEM_READ)
    begin
	READ_DATA[7:0]   <= memory[ADDRESS];
	READ_DATA[15:8]  <= memory[ADDRESS+1];
	READ_DATA[23:16] <= memory[ADDRESS+2];
	READ_DATA[32:24] <= memory[ADDRESS+3];
    end
    
 if(MEM_WRITE)
    begin
    memory[ADDRESS]   <= WRITE_DATA[7:0];
    memory[ADDRESS+1] <= WRITE_DATA[15:8];
    memory[ADDRESS+2] <= WRITE_DATA[23:16];
    memory[ADDRESS+3] <= WRITE_DATA[32:24];
    end
end
endmodule


module RegisterFile(READ_DATA2,READ_DATA1,READ_REGISTER1,READ_REGISTER2,WRITE_REGISTER,WRITE_DATA,REG_WRITE);
input [4:0] READ_REGISTER2,READ_REGISTER1,WRITE_REGISTER;
input REG_WRITE;
input [31:0] WRITE_DATA;
output [31:0] READ_DATA2,READ_DATA1;
reg [31:0] memory [31:0];

assign READ_DATA2 = memory[READ_REGISTER2];
assign READ_DATA1 = memory[READ_REGISTER1];

always@(*)
begin
if(REG_WRITE)
    begin
    memory[WRITE_REGISTER] <= WRITE_DATA;
    end
end
endmodule


module mux4x1_32bit(in1,in2,in3,in4,sel,out);
input [31:0] in1,in2,in3,in4;
input [1:0]sel;
output reg [31:0] out;

always@(*)
begin
    case(sel)
		2'b00:out <= in1;
		2'b01:out <= in2;
		2'b10:out <= in3;
		2'b11:out <= in4;
    endcase
end
endmodule


module mux2x1_5bit(in1, in2, sel, out);
input [4:0] in1;
input [4:0] in2;
input sel;
output [4:0] out;

assign out = (sel == 0)? in1:in2;
endmodule


module mux2x1_32bit(in1, in2, sel, out);
input [31:0] in1;
input [31:0] in2;
input sel;
output [31:0] out;

assign out = (sel == 0)? in1:in2;
endmodule


module ALU(in1,in2,ALUCtrl,out,zero);
input [31:0] in1;
input [31:0] in2;
input [3:0] ALUCtrl;
output reg [31:0] out;
output zero;

assign zero = (out == 32'h0000_0000)?1:0;
always@(*)
begin
case(ALUCtrl)
	4'b0000: out <= in1&in2;
	4'b0001: out <= in1|in2;
	4'b0010: out <= in1+in2;
	4'b0110: out <= in1-in2;
	4'b0111: out <= (in1<in2)? 32'h0000_0001:32'h0000_0000;
endcase
end
endmodule


module ShiftLeft2(in1,out);
input [31:0] in1;
output [31:0] out;

assign out = in1 << 2;
endmodule


module ALUControl();

endmodule


module ControlUnit();

endmodule


module forwarding_unit(RS,RT,RD_EX,RD_MEM,WB_EX,WB_MEM,MUX_RS,MUX_RT);
input [4:0] RS,RT,RD_EX,RD_MEM;
input WB_EX,WB_MEM;
output reg [1:0] MUX_RS,MUX_RT;

always@(*)
begin
	if(WB_MEM||WB_EX)
	begin
		case(RS)
			RD_MEM:begin
				if(WB_MEM)
				MUX_RS=1;
				end
			RD_EX:begin
				 if(WB_EX)
				 MUX_RS=2;
				 end
			default:MUX_RS=0;
		endcase
 
		case(RT)
			RD_MEM:begin
				if(WB_MEM)
				MUX_RT=1;
				end
			RD_EX:begin
				if(WB_EX)
				MUX_RT=2;
				end
			default:MUX_RT=0;
		endcase
	end
	else
	begin
		MUX_RT=0;
		MUX_RS=0;
	end
end
endmodule


module IF_ID(CLK,INPUT,OUTPUT,HOLD);
input [63:0]INPUT;
output reg [63:0]OUTPUT;
input CLK,HOLD;
reg [63:0]memory;

always@(posedge CLK)
begin
	if(~HOLD)
		memory <= INPUT;
end
	
always@(negedge CLK)
begin
	if(~HOLD)
		OUTPUT <= memory;
end
endmodule


module ID_EX(CLK,INPUT,OUTPUT);
input [119:0]INPUT;
output reg [119:0]OUTPUT;
input CLK;
reg [119:0]memory;

always@(posedge CLK)
begin
	memory <= INPUT;
end

always@(negedge CLK)
begin
	OUTPUT <= memory;
end
endmodule


module EX_MEM(CLK,INPUT,OUTPUT);
input [73:0]INPUT;
output reg [73:0]OUTPUT;
input CLK;
reg [73:0]memory;

always@(posedge CLK)
begin
	memory <= INPUT;
end

always@(negedge CLK)
begin
	OUTPUT <= memory;
end
endmodule


module MEM_WB(CLK,INPUT,OUTPUT);
input [70:0]INPUT;
output reg [70:0]OUTPUT;
input CLK;
reg [70:0]memory;

always@(posedge CLK)
begin
	memory <= INPUT;
end

always@(negedge CLK)
begin
	OUTPUT <= memory;
end
endmodule



/*---------------tb---------------*/
module tb_mux();
reg [31:0]in1;
reg [31:0]in2;
reg sel;
wire [31:0]out;


initial
begin
$monitor("%h // %h // %b // %h", in1,in2,sel,out);
#5
in1=32'h11111111;
#5
in1=32'h00000000;
in2=32'hffffffff;
sel=0;
#5
in1=32'h00000000;
in2=32'hffffffff;
sel=1;
end

mux2x1_32bit tmux(in1, in2 , sel, out);
endmodule 

module tb_ALU();
reg [31:0] in1,in2;
reg [3:0] aluctr;
wire [31:0] out;
wire zero;


initial 
begin
$monitor(" %d // %d // %b // %b // %b",in1,in2,aluctr,out,zero);
#5
in1=32'd25;
in2=32'd50;
aluctr=4'b0000;
#5
in1=32'd25;
in2=32'd50;
aluctr=4'b0001;
#5
in1=32'd25;
in2=32'd50;
aluctr=4'b0010;
#5
in1=32'd50;
in2=32'd25;
aluctr=4'b0111;
#5
in1=32'd25;
in2=32'd50;
aluctr=4'b0111;

#5
in1=32'd25;
in2=32'd50;
aluctr=4'b0110;
#5
in1=32'd75;
in2=32'd50;
aluctr=4'b0110;
end

ALU ALUTest(in1,in2,aluctr,out,zero);
endmodule


module tb_shift();
reg [31:0]in1;
wire [31:0]out;

initial 
begin
$monitor("%d // %d",in1,out);
#5
in1= 32'd25;
#5
in1=32'd100;
end

ShiftLeft2 shift(in1,out);
endmodule


module tb_forwarding();
reg [4:0]RS,RT,RD_EX,RD_MEM;
reg  WB_EX,WB_MEM;
wire  [1:0]MUX_RS,MUX_RT;

initial 
begin
$monitor("%d // %d", MUX_RS,MUX_RT);
WB_EX=1;WB_MEM=1;
RS=1;
RT=2;
RD_EX=1;
RD_MEM=2;
#5
WB_EX=1;WB_MEM=1;
RS=1;
RT=2;
RD_EX=3;
RD_MEM=4;
#5
WB_EX=0;WB_MEM=1;
RS=1;
RT=2;
RD_EX=1;
RD_MEM=5;
#5
WB_EX=0;WB_MEM=0;
RS=1;
RT=2;
RD_EX=1;
RD_MEM=5;
end

forwarding_unit ahmed(RS,RT,RD_EX,RD_MEM,WB_EX,WB_MEM,MUX_RS,MUX_RT); 
endmodule