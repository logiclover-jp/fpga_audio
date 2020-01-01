`timescale 1ns / 1ps
module tdm_gen(
    input bclk,
    input wclk,
    output tdm_out
);
    reg [1:0] wc_ff;
    reg [5:0] bclk_cnt;
    parameter FIX_DATA = 32'hABCD0000;

    assign tdm_out = FIX_DATA[bclk_cnt[4:0]];

    always @(posedge bclk)begin
        wc_ff <= {wc_ff[0], wclk};
    end

    always @(negedge bclk)begin
        if(wc_ff == 2'b01)
            bclk_cnt <= 6'd62;
		else begin
			bclk_cnt <= bclk_cnt - 6'd1;
		end
    end

endmodule
