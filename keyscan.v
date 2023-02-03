module keyscan(clk,rst,key_col,key_row,key);
// module keyscan(clk,rst,key_col,key_row,key,led_ld);
    input clk;
    input rst;
    output reg [3:0] key_col; 
    input [3:0] key_row;
    output reg [16:0] key;
    //output [15:0] led_ld; 

    reg [1:0] state;

    initial begin
        state<=2'b00;
        key_col<=4'b0000;
        key<=17'b0_0000_0000_0000_0000;
    end

    always @(posedge clk or posedge rst) begin
        if(rst) begin
            state<=2'b11;
            key_col<=4'b1000;
            key<=17'b0_0000_0000_0000_0000;
        end

        else begin
            case (state)
                2'b00: begin
                    // key[3:0]<=~key_row;
                    {key[1],key[5],key[9],key[13]}<=~key_row;
                    // key[0]<=key_row[3];
                    // key[4]<=key_row[2];
                    // key[8]<=key_row[1];
                    // key[12]<=key_row[0];
                    key_col<=~4'b0010;
                    state<=2'b01;
                end
                2'b01: begin
                    // key[7:4]<=~key_row;
                    {key[2],key[6],key[10],key[14]}<=~key_row;
                    // key[1]<=key_row[3];
                    // key[5]<=key_row[2];
                    // key[9]<=key_row[1];
                    // key[13]<=key_row[0];
                    key_col<=~4'b0100;
                    state<=2'b10;
                end
                2'b10: begin
                    // key[11:8]<=~key_row;
                    {key[3],key[7],key[11],key[15]}<=~key_row;
                    // key[2]<=key_row[3];
                    // key[6]<=key_row[2];
                    // key[10]<=key_row[1];
                    // key[14]<=key_row[0];
                    key_col<=~4'b1000;
                    state<=2'b11;
                end
                2'b11: begin
                    // key[15:12]<=~key_row;
                    {key[4],key[8],key[12],key[16]}<=~key_row;
                    // key[3]<=key_row[3];
                    // key[7]<=key_row[2];
                    // key[11]<=key_row[1];
                    // key[15]<=key_row[0];
                    key_col<=~4'b0001;
                    state<=2'b00;
                end
            endcase

            // case (count)
            //     2'b00: begin
            //         key[3:0]<=key_row;
            //         key_col<=4'b0010;
            //     end
            //     2'b01: begin
            //         key[7:4]<=key_row;
            //         key_col<=4'b0100;
            //     end
            //     2'b10: begin
            //         key[11:8]<=key_row;
            //         key_col<=4'b1000;
            //     end
            //     2'b11: begin
            //         key[15:12]<=key_row;
            //         key_col<=4'b0001;
            //     end 
            // endcase
            // count<=count+1'b1;
        end
    end
    //assign led_ld[15:0]=key[16:1];
    // assign led_ld[15:14]=state;
    // assign led_ld[11:8]=key_col;
    // assign led_ld[7:4]=~key_row;
    // assign led_ld[0]=rst;
    // assign led_ld=key;
endmodule