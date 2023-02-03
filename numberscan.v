module numberscan(clk,rst,num_Rcol,num_row,num_R,cnttime,score);
	input clk;
	input rst;
	input  [31:0] num_R;
	input  [5:0]cnttime;
	input  [4:0] score;
	//input [5:0]cnttime;
	//reg [8:0] seg[9:0];
	//reg [8:0] seg_data [1:0];
	//reg [5:0]cnt;
	//wire  [7:0] seg_data0;
	//wire  [7:0] seg_data1;
	reg [7:0] seg[9:0];
	reg [5:0]cnt;
	output reg  [7:0] num_row;
	output reg  [7:0] num_Rcol;
	//output [15:0]led_ld;
	//wire [7:0] seg_data2;
	//wire [7:0] seg_data3;

	

	
	reg [1:0] state;
	//count(clk,rst,seg_data0,seg_data1,led_ld);
	//countpoint(clk,rst,seg_data2,seg_data3);
	initial begin
		  seg[0] <= 8'b00111111;                                           //对存储器中第一个数赋值9'b00_0011_1111,相当于共阴极接地，DP点变低不亮，7段显示数字  0
	      seg[1] <= 8'b00000110;                                           //7段显示数字  1
	      seg[2] <= 8'b01011011;                                           //7段显示数字  2
	      seg[3] <= 8'b01001111;                                           //7段显示数字  3
	      seg[4] <= 8'b01100110;                                           //7段显示数字  4
	      seg[5] <= 8'b01101101;                                           //7段显示数字  5
	      seg[6] <= 8'b01111101;                                           //7段显示数字  6
	      seg[7] <= 8'b00000111;                                           //7段显示数字  7
	      seg[8] <= 8'b01111111;                                           //7段显示数字  8
	      seg[9] <= 8'b01101111;  
		state<=2'b00;
		num_Rcol<=8'b0000_0000;
		
		num_row<=8'b11111111;
	end

	always @(posedge clk or posedge rst) begin
      	  if(rst) begin
           	 	state<=2'b00;
            		num_Rcol<=8'b0000_0000;
            		
						num_row<=8'b11111110;
       	 	end
	  else begin
		case(state)
		2'b00: begin
			state<=2'b01;
			num_row<=8'b11111110;
			//num_Rcol<=8'b00111111;
         if(score>=10 && score<=19) begin
				num_Rcol<=seg[score-10];
			end
			else if(score>=0 && score<=9) begin
				num_Rcol<=seg[score];
			end
		end 
		2'b01:begin
			state<=2'b10;
			num_row<=8'b11111101;
			//num_Rcol<=8'b00111111;
			if(score>=10 && score<=19) begin
				num_Rcol<=seg[1];
			end
			else if(score>=0 && score<=9) begin
				num_Rcol<=seg[0];
			end
                    		
	
		end
		2'b10:begin
			state<=2'b11;
			num_row<=8'b10111111;
			//num_Rcol<=8'b00111111;
			//num_Rcol<=seg_data0;
         if(cnttime>=50 && cnttime<=59) begin
				num_Rcol<=seg[cnttime-50];
			end
			else if(cnttime>=40 && cnttime<=49) begin
				num_Rcol<=seg[cnttime-40];
			end
			else if(cnttime>=30 && cnttime<=39) begin
				num_Rcol<=seg[cnttime-30];
			end
			else if(cnttime>=20 && cnttime<=29) begin
				num_Rcol<=seg[cnttime-20];
			end
			else if(cnttime>=10 && cnttime<=19) begin
				num_Rcol<=seg[cnttime-10];
			end
			else if(cnttime>=0 && cnttime<=9) begin
				num_Rcol<=seg[cnttime];
			end 
			else if(cnttime==60)begin
				num_Rcol<=seg[0];
			end
	
		end
		2'b11:begin
			state<=2'b00;
			num_row<=8'b01111111;
			//num_Rcol<=8'b00111111;
         //num_Rcol<=seg_data1;
			
		   if(cnttime>=50 && cnttime<=59) begin
				num_Rcol<=seg[5];
			end
			else if(cnttime>=40 && cnttime<=49) begin
				num_Rcol<=seg[4];
			end
			else if(cnttime>=30 && cnttime<=39) begin
				num_Rcol<=seg[3];
			end
			else if(cnttime>=20 && cnttime<=29) begin
				num_Rcol<=seg[2];
			end
			else if(cnttime>=10 && cnttime<=19) begin
				num_Rcol<=seg[1];
			end
			else if(cnttime>=0 && cnttime<=9) begin
				num_Rcol<=seg[0];
			end
			else if(cnttime==60)begin
				num_Rcol<=seg[6];
			end
	
		end
		
		endcase
	end
	end
	//assign led_ld[5:0]=cnttime;
	
	//assign led_ld[15:13]=state;
  
	//assign led_ld[7:0]=num_row;
endmodule