module game(clk,rst,key,cnttime,cnt,position,score,sure,color,correct,remake);
	input clk;
	input rst;
	input [16:0]key;
	input sure;
	//input btn;
	//output [15:0]led_ld;
	//input sw3;
	output [16:0] position;
	output [1:0]color;
	output [5:0] cnttime;
	output [3:0]cnt;
	output [4:0] score;
	wire over;
	input remake;
	output correct;
	
	//assign led_ld[15:0]=position[16:1];
	random random0(clk,rst,position,sure,cnt,led_ld,color,remake);
	countpoint countpoint0(clk,rst,key,position,score,over,correct,color);
	counttime counttime0(clk,rst,cnttime,over);
endmodule
