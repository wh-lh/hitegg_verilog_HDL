module hitegg(clk,rst,sw3,key_row,key_col,sure, led_Rcol,led_Gcol,led_row,num_Rcol,num_row,led_ld);
	input clk;
	input rst;
	input sw3;
	//input btn;
	input [3:0]key_row;
	output [3:0] key_col;
	input sure;
	output [7:0]led_Rcol;
	output [7:0]led_Gcol;
	output [7:0]led_row;
	//wire   [63:0] led_R;
	//wire   [63:0] led_G;
	//output   [63:0] led_Y;
	output   [7:0] num_row;
	output   [7:0] num_Rcol;
	output [15:0]led_ld;
	wire [16:0] key;
	wire [5:0]cnttime;
	//wire [3:0]en;
	wire [3:0]cnt;
	wire [4:0] score;
	wire [16:0]position;
	wire [1:0]color;
	wire remake;
	wire correct;
	
	inputcontrol inputcontrol0(clk,rst,sw3,key_row,key_col,key);
	game game0(clk,rst,key,cnttime,cnt,position,score,sure,color,correct,remake);
	outputcontrol outputcontrol0(clk,rst,position,cnttime,score,num_row,num_Rcol,led_Rcol,led_Gcol,led_row,color,remake,correct);
	//assign led_ld[15:10]=cnttime;
	//assign led_ld[15:0]=position[16:1];
endmodule
