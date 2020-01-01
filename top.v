`timescale 1ns / 1ps

module top(
	input mclk_in,
	output bclk,
	output wclk,
	input tdm_in,
	output tdm_out
    );

	wire [7:0] cnt256_n;
	wire [15:0] ch1_in;
	wire [15:0] ch2_in;
	wire [15:0] ch1_out;
	wire [15:0] ch2_out;

	tdm_input tdmi (
		.mclk(mclk_in), 
		.cnt256_n(cnt256_n), 
		.tdm_in(tdm_in), 
		.ch1_out(ch1_in), 
		.ch2_out(ch2_in)
	);

	audio_clkgen clkgen (
		.mclk(mclk_in), 
		.bclk(bclk), 
		.wclk(wclk), 
		.cnt256_n(cnt256_n)
	);

	audio_processing dsp(
		.clk(mclk_in),
		.cnt256_n(cnt256_n),
		.ch1_in(ch1_in),
		.ch2_in(ch2_in),
		.ch1_out(ch1_out),
		.ch2_out(ch2_out)
	);

	tdm_output tdmo(
		.mclk(mclk_in),
		.cnt256_n(cnt256_n),
		.ch1_in(ch1_out),
		.ch2_in(ch2_out),
		.tdm_out(tdm_out)
	);
endmodule
