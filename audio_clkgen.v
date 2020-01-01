`timescale 1ns / 1ps
module audio_clkgen(
    input mclk,
    output bclk,
    output wclk,
    output [7:0] cnt256_n
);

    reg [7:0] r_cnt256_n = 8'd0;

    assign cnt256_n = r_cnt256_n;
    assign bclk     = ~r_cnt256_n[1];
    assign wclk     = r_cnt256_n[7];

    always @(posedge mclk)begin
        r_cnt256_n <= r_cnt256_n - 8'd1;
    end

endmodule
