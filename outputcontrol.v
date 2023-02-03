module outputcontrol(clk,rst,position,cnttime,score,num_row,num_Rcol,led_Rcol,led_Gcol,led_row,color,remake,correct);
	input clk;
	input rst;
	input [16:0]position;
	input [5:0]cnttime;
	input [4:0]score;
	input [1:0]color;
	output [7:0]num_row;
	output [7:0]num_Rcol;
	output [7:0]led_Rcol;
	output [7:0]led_Gcol;
	output [7:0]led_row;
	output remake;
	input correct;
	
	//input [15:0]key;
	LEDscan LEDscan0(clk,rst,led_Rcol,led_Gcol,led_row,position,key,color,remake,correct);
	numberscan numberscan0(clk,rst,num_Rcol,num_row,num_R,cnttime,score);
endmodule
