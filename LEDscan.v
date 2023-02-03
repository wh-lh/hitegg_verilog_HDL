module LEDscan(clk,rst,led_Rcol,led_Gcol,led_row,position,key,color,remake,correct);
	input clk;
	input rst;
   reg  [63:0] led_R;
	reg  [63:0] led_G;
	//reg  [63:0] led_Y;
	reg  [9:0] holdtime;
	reg  [9:0] delaytime;
	output reg remake;    //传递参数  决定是否产生新的随机数
	input correct;    //判断按键是否按对
	input  [16:0] position;
	input  [16:0] key;
	input [1:0]color;
	output reg  [7:0] led_row;
	output reg  [7:0] led_Rcol;
	output reg  [7:0] led_Gcol;
	
	//reg enhold;
	//output [15:0] led_ld;
	//input correct;
	reg [2:0] state;
	initial begin
		state<=3'b000;
		led_Rcol<=8'b0000_0000;
		led_Gcol<=8'b0000_0000;
		led_row<=8'b1111_1111;
//		cnt4[0]<=2'b01;
//		cnt4[1]<=2'b11;
//		cnt4[2]<=2'b01;

	end
//	always @(posedge clk or posedge rst) begin
//		if(rst) begin
//		end
//		else if(cnt5<3'd8)begin
//			cnt5<=cnt5+1;
//		end
//		else if(cnt5==3'd8)begin
//			cnt5<=3'd0;
//		end
//	end
//	always @(posedge clk or posedge rst) begin
//		if(rst) begin
//		end
//		else if(position)begin
//		  color<=cnt4[cnt5];
//		end
//
//	end
	//assign color=cnt4[cnt5];
	always @(posedge clk or posedge rst) begin
      	  if(rst) begin
           	 	state<=3'b000;
            		led_Rcol<=8'b0000_0000;
            		led_Gcol<=8'b0000_0000;
						led_row<=8'b1111_1110;
       	 	end
	  else begin
		case(state)
		3'b000: begin
			state<=3'b001;
			led_row<=8'b1111_1110;
			led_Rcol<=led_R[7:0];
                    		led_Gcol<=led_G[7:0];
		end 
		3'b001:begin
			state<=3'b010;
			led_row<=8'b1111_1101;
			led_Rcol<=led_R[15:8];
                    		led_Gcol<=led_G[15:8];
	
		end
		3'b010:begin
			state<=3'b011;
			led_row<=8'b1111_1011;
			led_Rcol<=led_R[23:16];
                    		led_Gcol<=led_G[23:16];
	
		end
		3'b011:begin
			state<=3'b100;
			led_row<=8'b1111_0111;
			led_Rcol<=led_R[31:24];
                    		led_Gcol<=led_G[31:24];
	
		end
		3'b100:begin
			state<=3'b101;
			led_row<=8'b1110_1111;
			led_Rcol<=led_R[39:32];
                    		led_Gcol<=led_G[39:32];
	
		end
		3'b101:begin
			state<=3'b110;
			led_row<=8'b1101_1111;
			led_Rcol<=led_R[47:40];
                    		led_Gcol<=led_G[47:40];
	
		end
		3'b110:begin
			state<=3'b111;
			led_row<=8'b1011_1111;
			led_Rcol<=led_R[55:48];
                    		led_Gcol<=led_G[55:48];
	
		end
		3'b111:begin
			state<=3'b000;
			led_row<=8'b0111_1111;
			led_Rcol<=led_R[63:56];
                    		led_Gcol<=led_G[63:56];
	
		end
		endcase
	end
	end
	always@(posedge clk or posedge rst)
	begin
		if(rst) begin
		end
		else if(holdtime==10'd1000 || delaytime==10'd1000) begin
			remake<=1'b1;
		end	
		else begin
			remake<=1'b0;
		end
	end
	always@(posedge clk or posedge rst)
	begin
		if(rst) begin
		end
		
		else  begin
			case(position)
			17'b0_0000_0000_0000_0010:begin
					{led_R[57:56],led_R[49:48]}<=(color[0])?4'b1111:4'b0000;
					{led_R[47:0],led_R[55:50],led_R[63:58]}<=60'b0;
					{led_G[57:56],led_G[49:48]}<=(color[1])?4'b1111:4'b0000;
					{led_G[47:0],led_G[55:50],led_G[63:58]}<=60'b0;
			end
			17'b0_0000_0000_0000_0100:begin
					{led_R[59:58],led_R[51:50]}<=(color[0])?4'b1111:4'b0000;
					{led_R[49:0],led_R[57:52],led_R[63:60]}<=60'b0;
					{led_G[59:58],led_G[51:50]}<=(color[1])?4'b1111:4'b0000;
					{led_G[49:0],led_G[57:52],led_G[63:60]}<=60'b0;
			end
			17'b0_0000_0000_0000_1000:begin
					{led_R[61:60],led_R[53:52]}<=(color[0])?4'b1111:4'b0000;
					{led_R[51:0],led_R[59:54],led_R[63:62]}<=60'b0;
					{led_G[61:60],led_G[53:52]}<=(color[1])?4'b1111:4'b0000;
					{led_G[51:0],led_G[59:54],led_G[63:62]}<=60'b0;
			end
			17'b0_0000_0000_0001_0000:begin
					{led_R[63:62],led_R[55:54]}<=(color[0])?4'b1111:4'b0000;                                                                            
					{led_R[53:0],led_R[61:56]}<=60'b0;
					{led_G[63:62],led_G[55:54]}<=(color[1])?4'b1111:4'b0000;                                                                            
					{led_G[53:0],led_G[61:56]}<=60'b0;
			end
			
			17'b0_0000_0000_0010_0000:begin
					{led_R[41:40],led_R[33:32]}<=(color[0])?4'b1111:4'b0000;
					{led_R[31:0],led_R[39:34],led_R[63:42]}<=60'b0;
					{led_G[41:40],led_G[33:32]}<=(color[1])?4'b1111:4'b0000;
					{led_G[31:0],led_G[39:34],led_G[63:42]}<=60'b0;
			end
			17'b0_0000_0000_0100_0000:begin
		
					{led_R[43:42],led_R[35:34]}<=(color[0])?4'b1111:4'b0000;
					{led_R[33:0],led_R[41:36],led_R[63:44]}<=60'b0;
					
					{led_G[43:42],led_G[35:34]}<=(color[1])?4'b1111:4'b0000;
					{led_G[33:0],led_G[41:36],led_G[63:44]}<=60'b0;
			end
			17'b0_0000_0000_1000_0000:begin
					{led_R[45:44],led_R[37:36]}<=(color[0])?4'b1111:4'b0000;
					{led_R[35:0],led_R[43:38],led_R[63:46]}<=60'b0;
					{led_G[45:44],led_G[37:36]}<=(color[1])?4'b1111:4'b0000;
					{led_G[35:0],led_G[43:38],led_G[63:46]}<=60'b0;
			end
			17'b0_0000_0001_0000_0000:begin
					{led_R[47:46],led_R[39:38]}<=(color[0])?4'b1111:4'b0000;
					{led_R[37:0],led_R[45:40],led_R[63:48]}<=60'b0;
					{led_G[47:46],led_G[39:38]}<=(color[1])?4'b1111:4'b0000;
					{led_G[37:0],led_G[45:40],led_G[63:48]}<=60'b0;
			end
			17'b0_0000_0010_0000_0000:begin
					{led_R[25:24],led_R[17:16]}<=(color[0])?4'b1111:4'b0000;
					{led_R[15:0],led_R[23:18],led_R[63:26]}<=60'b0;
					{led_G[25:24],led_G[17:16]}<=(color[1])?4'b1111:4'b0000;
					{led_G[15:0],led_G[23:18],led_G[63:26]}<=60'b0;
			end
			17'b0_0000_0100_0000_0000:begin
					{led_R[27:26],led_R[19:18]}<=(color[0])?4'b1111:4'b0000;
					{led_R[17:0],led_R[25:20],led_R[63:28]}<=60'b0;
					{led_G[27:26],led_G[19:18]}<=(color[1])?4'b1111:4'b0000;
					{led_G[17:0],led_G[25:20],led_G[63:28]}<=60'b0;
			end
			17'b0_0000_1000_0000_0000:begin
					{led_R[29:28],led_R[21:20]}<=(color[0])?4'b1111:4'b0000;
					{led_R[19:0],led_R[27:22],led_R[63:30]}<=60'b0;
					{led_G[29:28],led_G[21:20]}<=(color[1])?4'b1111:4'b0000;
					{led_G[19:0],led_G[27:22],led_G[63:30]}<=60'b0;
			end
			17'b0_0001_0000_0000_0000:begin
					{led_R[31:30],led_R[23:22]}<=(color[0])?4'b1111:4'b0000;
					{led_R[21:0],led_R[29:24],led_R[63:32]}<=60'b0;
					{led_G[31:30],led_G[23:22]}<=(color[1])?'b1111:4'b0000;
					{led_G[21:0],led_G[29:24],led_G[63:32]}<=60'b0;
			end
			17'b0_0010_0000_0000_0000:begin
					{led_R[9:8],led_R[1:0]}<=(color[0])?4'b1111:4'b0000;
					{led_R[7:2],led_R[63:10]}<=60'b0;
					{led_G[9:8],led_G[1:0]}<=(color[1])?4'b1111:4'b0000;
					{led_G[7:2],led_G[63:10]}<=60'b0;
			end
			17'b0_0100_0000_0000_0000:begin
					{led_R[11:10],led_R[3:2]}<=(color[0])?4'b1111:4'b0000;
					{led_R[1:0],led_R[9:4],led_R[63:12]}<=60'b0;
					{led_G[11:10],led_G[3:2]}<=(color[1])?4'b1111:4'b0000;
					{led_G[1:0],led_G[9:4],led_G[63:12]}<=60'b0;
			end
			17'b0_1000_0000_0000_0000:begin
					{led_R[13:12],led_R[5:4]}<=(color[0])?4'b1111:4'b0000;
					{led_R[3:0],led_R[11:6],led_R[63:14]}<=60'b0;
					{led_G[13:12],led_G[5:4]}<=(color[1])?4'b1111:4'b0000;
					{led_G[3:0],led_G[11:6],led_G[63:14]}<=60'b0;
			end
			17'b1_0000_0000_0000_0000:begin
					{led_R[15:14],led_R[7:6]}<=(color[0])?4'b1111:4'b0000;
					{led_R[5:0],led_R[13:8],led_R[63:16]}<=60'b0;
					{led_G[15:14],led_G[7:6]}<=(color[1])?4'b1111:4'b0000;
					{led_G[5:0],led_G[13:8],led_G[63:16]}<=60'b0;
			end
			endcase
		end
		//assign led_ld[1:0]=color[1:0];
			
			
			
			
			
			
			
			
			
		end
	
	
	
	always@(posedge clk or posedge rst)
	begin
		if(rst) begin
		end
		else if(correct && holdtime<10'd1000 && delaytime<10'd1000) begin
			holdtime<=10'd0;
			delaytime<=delaytime+1'b1;
		end
		else if(!correct && holdtime<10'd1000)  begin
			holdtime<=holdtime+1;
			delaytime<=10'd0;
			
		end
		else if(!correct && holdtime==10'd1000)  begin
			holdtime<=0;
			delaytime<=10'd0;
			
		end
		else if(correct && holdtime<10'd1000 && delaytime==10'd1000) begin
			holdtime<=10'd0;
			delaytime<=10'd0;
		end
	end
	
//				case(position)
//					16'b0000_0000_0000_0001: begin
//						{led_R[49:48],led_R[57:56]}<=(color[1])?4'b1111:4'b0000;
//						{led_R[58],led_R[50],led_R[41:40]}<=(color[1])?4'b1111:4'b0000;
//						{led_R[42]}<=1'b0;
//						{led_R[63:59],led_R[55:51],led_R[47:43],led_R[39:0]}<=55'd0;
//						{led_G[49:48],led_G[57:56]}<=(color[0])?4'b1111:4'b0000;
//						{led_G[58],led_G[50],led_G[41:40]}<=(color[0])?4'b1111:4'b0000;
//						{led_G[42]}<=1'b0;
//						{led_G[63:59],led_G[55:51],led_G[47:43],led_G[39:0]}<=55'd0;
//					end
//					16'b0000_0000_0000_0010: begin
//						{led_R[51:50],led_R[59:58]}<=(color[1])?4'b1111:4'b0000;
//						{led_R[60],led_R[57],led_R[52],led_R[49],led_R[43:42]}<=(color[1])?6'b11_1111:6'b00_0000;
//						{led_R[44],led_R[41]}<=2'b00;
//						{led_R[63:61],led_R[56:53],led_R[48:45],led_R[40:0]}<=52'd0;
//						{led_G[51:50],led_G[59:58]}<=(color[0])?4'b1111:4'b0000;
//						{led_G[60],led_G[57],led_G[52],led_G[49],led_G[43:42]}<=(color[0])?6'b11_1111:6'b00_0000;
//						{led_G[44],led_G[41]}<=2'b00;
//						{led_G[63:61],led_G[56:53],led_G[48:45],led_G[40:0]}<=52'd0;
//					end
//					16'b0000_0000_0000_0100: begin
//						{led_R[53:52],led_R[61:60]}<=(color[1])?4'b1111:4'b0000;
//						{led_R[62],led_R[59],led_R[54],led_R[51],led_R[45:44]}<=(color[1])?6'b11_1111:6'b00_0000;
//						{led_R[46],led_R[43]}<=2'b00;
//						{led_R[63],led_R[58:55],led_R[50:47],led_R[42:0]}<=52'd0;
//						{led_G[53:52],led_G[61:60]}<=(color[0])?4'b1111:4'b0000;
//						{led_G[62],led_G[59],led_G[54],led_G[51],led_G[45:44]}<=(color[0])?6'b11_1111:6'b00_0000;
//						{led_G[46],led_G[43]}<=2'b00;
//						{led_G[63],led_G[58:55],led_G[50:47],led_G[42:0]}<=52'd0;
//					end
//					16'b0000_0000_0000_1000: begin
//						{led_R[55:54],led_R[63:62]}<=(color[1])?4'b1111:4'b0000;
//						{led_R[61],led_R[53],led_R[47:46]}<=(color[1])?4'b1111:4'b0000;
//						{led_R[45]}<=1'b0;
//						{led_R[60:56],led_R[52:48],led_R[44:0]}<=55'd0;
//						{led_G[55:54],led_G[63:62]}<=(color[0])?4'b1111:4'b0000;
//						{led_G[61],led_G[53],led_G[47:46]}<=(color[0])?4'b1111:4'b0000;
//						{led_G[45]}<=1'b0;
//						{led_G[60:56],led_G[52:48],led_G[44:0]}<=55'd0;
//					end
//					16'b0000_0000_0001_0000: begin
//						{led_R[33:32],led_R[41:40]}<=(color[1])?4'b1111:4'b0000;
//						{led_R[49:48],led_R[42],led_R[34],led_R[25:24]}<=(color[1])?6'b11_1111:6'b00_0000;
//						{led_R[50],led_R[26]}<=2'b00;
//						{led_R[63:51],led_R[47:43],led_R[39:35],led_R[31:27],led_R[23:0]}<=52'd0;
//						{led_G[33:32],led_G[41:40]}<=(color[0])?4'b1111:4'b0000;
//						{led_G[49:48],led_G[42],led_G[34],led_G[25:24]}<=(color[0])?6'b11_1111:6'b00_0000;
//						{led_G[50],led_G[26]}<=2'b00;
//						{led_G[63:51],led_G[47:43],led_G[39:35],led_G[31:27],led_G[23:0]}<=52'd0;
//					end
//					16'b0000_0000_0010_0000: begin
//						{led_R[35:34],led_R[43:42]}<=(color[1])?4'b1111:4'b0000;
//						{led_R[51:50],led_R[44],led_R[41],led_R[36],led_R[33],led_R[27:26]}<=(color[1])?8'b1111_1111:8'b0000_0000;
//						{led_R[52],led_R[49],led_R[28],led_R[25]}<=4'b0000;
//						{led_R[63:53],led_R[48:45],led_R[40:37],led_R[32:29],led_R[24:0]}<=48'd0;
//						{led_G[35:34],led_G[43:42]}<=(color[0])?4'b1111:4'b0000;
//						{led_G[51:50],led_G[44],led_G[41],led_G[36],led_G[33],led_G[27:26]}<=(color[0])?8'b1111_1111:8'b0000_0000;
//						{led_G[52],led_G[49],led_G[28],led_G[25]}<=4'b0000;
//						{led_G[63:53],led_G[48:45],led_G[40:37],led_G[32:29],led_G[24:0]}<=48'd0;
//					end
//					16'b0000_0000_0100_0000: begin
//						{led_R[37:36],led_R[45:44]}<=(color[1])?4'b1111:4'b0000;
//						{led_R[53:52],led_R[46],led_R[43],led_R[38],led_R[35],led_R[29:28]}<=(color[1])?8'b1111_1111:8'b0000_0000;
//						{led_R[54],led_R[51],led_R[30],led_R[27]}<=4'b0000;
//						{led_R[63:55],led_R[50:47],led_R[42:39],led_R[34:31],led_R[26:0]}<=48'd0;
//						{led_G[37:36],led_G[45:44]}<=(color[0])?4'b1111:4'b0000;
//						{led_G[53:52],led_G[46],led_G[43],led_G[38],led_G[35],led_G[29:28]}<=(color[0])?8'b1111_1111:8'b0000_0000;
//						{led_G[54],led_G[51],led_G[30],led_G[27]}<=4'b0000;
//						{led_G[63:55],led_G[50:47],led_G[42:39],led_G[34:31],led_G[26:0]}<=48'd0;
//					end
//					16'b0000_0000_1000_0000: begin
//						{led_R[39:38],led_R[47:46]}<=(color[1])?4'b1111:4'b0000;
//						{led_R[55:54],led_R[45],led_R[37],led_R[31:30]}<=(color[1])?6'b11_1111:6'b00_0000;
//						{led_R[53],led_R[29]}<=2'b00;
//						{led_R[63:56],led_R[52:48],led_R[44:40],led_R[36:32],led_R[28:0]}<=52'd0;
//						{led_G[39:38],led_G[47:46]}<=(color[0])?4'b1111:4'b0000;
//						{led_G[55:54],led_G[45],led_G[37],led_G[31:30]}<=(color[0])?6'b11_1111:6'b00_0000;
//						{led_G[53],led_G[29]}<=2'b00;
//						{led_G[63:56],led_G[52:48],led_G[44:40],led_G[36:32],led_G[28:0]}<=52'd0;
//					end
//					16'b0000_0001_0000_0000: begin
//						{led_R[17:16],led_R[25:24]}<=(color[1])?4'b1111:4'b0000;
//						{led_R[33:32],led_R[26],led_R[18],led_R[9:8]}<=(color[1])?6'b11_1111:6'b00_0000;
//						{led_R[34],led_R[10]}<=2'b00;
//						{led_R[63:35],led_R[31:27],led_R[23:19],led_R[15:11],led_R[7:0]}<=52'd0;
//						{led_G[17:16],led_G[25:24]}<=(color[0])?4'b1111:4'b0000;
//						{led_G[33:32],led_G[26],led_G[18],led_G[9:8]}<=(color[0])?6'b11_1111:6'b00_0000;
//						{led_G[34],led_G[10]}<=2'b00;
//						{led_G[63:35],led_G[31:27],led_G[23:19],led_G[15:11],led_G[7:0]}<=52'd0;
//					end
//					16'b0000_0010_0000_0000: begin
//						{led_R[19:18],led_R[27:26]}<=(color[1])?4'b1111:4'b0000;
//						{led_R[35:34],led_R[28],led_R[25],led_R[20],led_R[17],led_R[11:10]}<=(color[1])?8'b1111_1111:8'b0000_0000;
//						{led_R[36],led_R[33],led_R[12],led_R[9]}<=4'b0000;
//						{led_R[63:37],led_R[32:29],led_R[24:21],led_R[16:13],led_R[8:0]}<=48'd0;
//						{led_G[19:18],led_G[27:26]}<=(color[0])?4'b1111:4'b0000;
//						{led_G[35:34],led_G[28],led_G[25],led_G[20],led_G[17],led_G[11:10]}<=(color[0])?8'b1111_1111:8'b0000_0000;
//						{led_G[36],led_G[33],led_G[12],led_G[9]}<=4'b0000;
//						{led_G[63:37],led_G[32:29],led_G[24:21],led_G[16:13],led_G[8:0]}<=48'd0;
//					end
//					16'b0000_0100_0000_0000: begin
//						{led_R[21:20],led_R[29:28]}<=(color[1])?4'b1111:4'b0000;
//						{led_R[37:36],led_R[30],led_R[27],led_R[22],led_R[19],led_R[13:12]}<=(color[1])?8'b1111_1111:8'b0000_0000;
//						{led_R[38],led_R[35],led_R[14],led_R[11]}<=4'b0000;
//						{led_R[63:39],led_R[34:31],led_R[26:23],led_R[18:15],led_R[10:0]}<=48'd0;
//						{led_G[21:20],led_G[29:28]}<=(color[0])?4'b1111:4'b0000;
//						{led_G[37:36],led_G[30],led_G[27],led_G[22],led_G[19],led_G[13:12]}<=(color[0])?8'b1111_1111:8'b0000_0000;
//						{led_G[38],led_G[35],led_G[14],led_G[11]}<=4'b0000;
//						{led_G[63:39],led_G[34:31],led_G[26:23],led_G[18:15],led_G[10:0]}<=48'd0;
//					end
//					16'b0000_1000_0000_0000: begin
//						{led_R[23:22],led_R[31:30]}<=(color[1])?4'b1111:4'b0000;
//						{led_R[39:38],led_R[29],led_R[21],led_R[15:14]}<=(color[1])?6'b11_1111:6'b00_0000;
//						{led_R[37],led_R[13]}<=2'b00;
//						{led_R[63:40],led_R[36:32],led_R[28:24],led_R[20:16],led_R[12:0]}<=52'd0;
//						{led_G[23:22],led_G[31:30]}<=(color[0])?4'b1111:4'b0000;
//						{led_G[39:38],led_G[29],led_G[21],led_G[15:14]}<=(color[0])?6'b11_1111:6'b00_0000;
//						{led_G[37],led_G[13]}<=2'b00;
//						{led_G[63:40],led_G[36:32],led_G[28:24],led_G[20:16],led_G[12:0]}<=52'd0;
//					end
//					16'b0001_0000_0000_0000: begin
//						{led_R[1:0],led_R[9:8]}<=(color[1])?4'b1111:4'b0000;
//						{led_R[17:16],led_R[10],led_R[2]}<=(color[1])?4'b1111:4'b0000;
//						{led_R[18]}<=1'b0;
//						{led_R[63:19],led_R[15:11],led_R[7:3]}<=55'd0;
//						{led_G[1:0],led_G[9:8]}<=(color[0])?4'b1111:4'b0000;
//						{led_G[17:16],led_G[10],led_G[2]}<=(color[0])?4'b1111:4'b0000;
//						{led_G[18]}<=1'b0;
//						{led_G[63:19],led_G[15:11],led_G[7:3]}<=55'd0;
//					end
//					16'b0010_0000_0000_0000: begin
//						{led_R[3:2],led_R[11:10]}<=(color[1])?4'b1111:4'b0000;
//						{led_R[19:18],led_R[12],led_R[9],led_R[4],led_R[1]}<=(color[1])?6'b11_1111:6'b00_0000;
//						{led_R[20],led_R[17]}<=2'b00;
//						{led_R[63:21],led_R[16:13],led_R[8:5],led_R[0]}<=52'd0;
//						{led_G[3:2],led_G[11:10]}<=(color[0])?4'b1111:4'b0000;
//						{led_G[19:18],led_G[12],led_G[9],led_G[4],led_G[1]}<=(color[0])?6'b11_1111:6'b00_0000;
//						{led_G[20],led_G[17]}<=2'b00;
//						{led_G[63:21],led_G[16:13],led_G[8:5],led_G[0]}<=52'd0;
//					end
//					16'b0100_0000_0000_0000: begin
//						{led_R[5:4],led_R[13:12]}<=(color[1])?4'b1111:4'b0000;
//						{led_R[21:20],led_R[14],led_R[11],led_R[6],led_R[3]}<=(color[1])?6'b11_1111:6'b00_0000;
//						{led_R[22],led_R[19]}<=2'b00;
//						{led_R[63:23],led_R[18:15],led_R[10:7],led_R[2:0]}<=52'd0;
//						{led_G[5:4],led_G[13:12]}<=(color[0])?4'b1111:4'b0000;
//						{led_G[21:20],led_G[14],led_G[11],led_G[6],led_G[3]}<=(color[0])?6'b11_1111:6'b00_0000;
//						{led_G[22],led_G[19]}<=2'b00;
//						{led_G[63:23],led_G[18:15],led_G[10:7],led_G[2:0]}<=52'd0;
//					end
//					16'b1000_0000_0000_0000: begin
//						{led_R[7:6],led_R[15:14]}<=(color[1])?4'b1111:4'b0000;
//						{led_R[23:22],led_R[13],led_R[5]}<=(color[1])?4'b1111:4'b0000;
//						{led_R[21]}<=1'b0;
//						{led_R[63:24],led_R[20:16],led_R[12:8],led_R[4:0]}<=55'd0;
//						{led_G[7:6],led_G[15:14]}<=(color[0])?4'b1111:4'b0000;
//						{led_G[23:22],led_G[13],led_G[5]}<=(color[0])?4'b1111:4'b0000;
//						{led_G[21]}<=1'b0;
//						{led_G[63:24],led_G[20:16],led_G[12:8],led_G[4:0]}<=55'd0;
//					end
//					default: begin
//						led_R<=64'd0;
//						led_G<=64'd0;
//					end
//				endcase
	

//	assign led_ld[15:13]=state;
//assign led_ld[15:8]=led_Rcol;
	//assign led_ld[7:0]=led_row;
endmodule
 	