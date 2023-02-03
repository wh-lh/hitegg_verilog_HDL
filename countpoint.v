module countpoint(clk,rst,key,position,score,over,correct,color);
	input clk;
	input rst;
	input [16:0] key;
	input [16:0] position;
	input over;
	output reg [4:0] score;
	output reg correct;
	input [1:0]color;
	//input remake;
	initial begin
		score<=5'b00000;
		correct<=1'b0;
	end
	always@(posedge clk or posedge rst)
	begin
		if(rst) begin
			score<=5'b00000;
		end
		else if(key==position &&  !over)begin
			if(color==2'b10) begin
				score<=score+2'd1;
			end
			else if(color==2'b01) begin
				score<=score+2'd2;
			end
			else if(color==2'b11) begin
				score<=score+2'd3;
			end
				correct<=1'b1;
		end
		else if(key!=position && !over)begin
			score<=score;
			correct<=1'b0;
		end
//		else if(score==5'd19 && !over) begin
//			score<=5'd19;
//		end
		else if(over) begin
			score<=score;
		end
//		else if(remake) begin
//			correct<=0;
//			
//		end
	
	end

endmodule
