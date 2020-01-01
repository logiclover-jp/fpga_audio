`timescale 1ns / 1ps
module tdm_input(
    input mclk,
    input [7:0] cnt256_n,
    input tdm_in,
    output reg [15:0] ch1_out,
    output reg [15:0] ch2_out
);
    reg [63:0] data_reg;
    always @(posedge mclk)begin
        if(cnt256_n == 8'd0)begin
            //シフトレジスタのデータを外部に出力
            ch1_out <= data_reg[63:48];
            ch2_out <= data_reg[31:16];
        end
        else if(cnt256_n[1:0] == 2'd2)begin
            //シリアルデータを取り込み
            data_reg <= {data_reg[62:0], tdm_in};
        end
        else begin
            //Latch
        end
    end
endmodule
