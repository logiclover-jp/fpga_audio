`timescale 1ns / 1ps
module tdm_output(
	input mclk,
	input [7:0] cnt256_n,
	input [15:0] ch1_in,
	input [15:0] ch2_in,
	output tdm_out
);

	reg [63:0] tdmo_buf;

	assign tdm_out = tdmo_buf[63];

	always @(posedge mclk)begin
		if(cnt256_n == 8'd0)begin
			tdmo_buf <= {ch1_in, 16'd0, ch2_in, 16'd0};
		end
		else if(cnt256_n[1:0] == 2'd0)begin
			tdmo_buf <= {tdmo_buf[62:0], 1'd0};
		end
		else begin
			//Latch
		end
	end

endmodule
