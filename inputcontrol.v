module inputcontrol(clk,rst,sw3,key_row,key_col,key);
	input clk;
	input rst;
	//output btn;
	output sw3;
	input [3:0]key_row;
	output [3:0]key_col;
	output [16:0] key;
	keyscan keyscan0(clk,rst,key_col,key_row,key);
endmodule
