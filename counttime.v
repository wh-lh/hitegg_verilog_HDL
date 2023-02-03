module counttime(clk,rst,cnttime,over);
	input clk;
	input rst;
	//input btn;
	//output [8:0]sega;
	//output [8:0]segb;
	reg [9:0] cnt1;
	output reg over;
	//reg [7:0] seg[9:0];
//	output reg [7:0] seg_data0;
//	output reg [7:0] seg_data1;
	//output [15:0] led_ld;
	output reg [5:0]cnttime;
	initial begin
//		   seg[0] <= 8'b00111111;                                           //对存储器中第一个数赋值9'b00_0011_1111,相当于共阴极接地，DP点变低不亮，7段显示数字  0
//	      seg[1] <= 8'b00000110;                                           //7段显示数字  1
//	      seg[2] <= 8'b01011011;                                           //7段显示数字  2
//	      seg[3] <= 8'b01001111;                                           //7段显示数字  3
//	      seg[4] <= 8'b01100110;                                           //7段显示数字  4
//	      seg[5] <= 8'b01101001;                                           //7段显示数字  5
//	      seg[6] <= 8'b01111101;                                           //7段显示数字  6
//	      seg[7] <= 8'b00000111;                                           //7段显示数字  7
//	      seg[8] <= 8'b01111111;                                           //7段显示数字  8
//	      seg[9] <= 8'b01101111;  
			cnttime<=6'd60;
			cnt1<=10'b0;
			over<=1'b0;
	end
//	    divide #(.WIDTH(32),.N(12000000)) u2 (         //传递参数
//			.clk(clk),
//			.rst_n(rst),                   //例化的端口信号都连接到定义好的信号
//			.clkout(clk1h)
//		);  \
	always@(posedge clk or posedge rst)
	begin
		if(rst) begin
			cnt1<=10'b0;
		end
		else if(cnt1<1000) begin
			cnt1<=cnt1+1;
		end
		else if(cnt1==1000) begin
			cnt1<=10'b0;
		end
	end
	
	always@(posedge clk or posedge rst)
	begin
		if(rst) begin
			cnttime<=6'd60;
			over<=1'b0;
		end
		else if(cnt1==1000 && cnttime!=0)begin
			cnttime<=cnttime-1;
//			if(cnttime>=0) begin
//				cnttime<=cnttime;
//			end
//			if(cnttime==0) begin
//				cnttime<=6'd60;
//			end
		end
		else if(cnttime==0 && cnt1==1000) begin
			cnttime<=6'b0;
			over<=1'b1;
			
		end
	end
	 
	 //assign led_ld[4:0]=cnt;
endmodule
