`timescale 1ns / 1ps

module tb_tdm_input;

	reg mclk;

	wire [7:0] cnt256_n;
	wire [15:0] ch1_out;
	wire [15:0] ch2_out;
	wire bclk;
	wire wclk;
	wire tdm_in;

	// Instantiate the Unit Under Test (UUT)
	tdm_input uut (
		.mclk(mclk), 
		.cnt256_n(cnt256_n), 
		.tdm_in(tdm_in), 
		.ch1_out(ch1_out), 
		.ch2_out(ch2_out)
	);

	audio_clkgen gen0 (
        .mclk(mclk), 
        .bclk(bclk), 
        .wclk(wclk), 
        .cnt256_n(cnt256_n)
    );
	
	tdm_gen sig_gen(
		.bclk(bclk),
		.wclk(wclk),
		.tdm_out(tdm_in)
	);

	//Master Clockê∂ê¨
	initial begin
		mclk = 1;
		forever begin
			#40;
			mclk = ~mclk;
		end
	end

	initial begin
		#100;
        
		// Add stimulus here
	end
      
endmodule

