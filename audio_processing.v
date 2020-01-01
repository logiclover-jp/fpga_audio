`timescale 1ns / 1ps
module audio_processing(
	input clk,
	input [7:0] cnt256_n,
	input signed [15:0] ch1_in,
	input signed [15:0] ch2_in,
	output reg signed [15:0] ch1_out,
	output reg signed [15:0] ch2_out
);

parameter ST_IDLE = 0;
parameter ST_CLIP_L = 1;
parameter ST_CLIP_R = 2;

reg [3:0]  state;
reg signed [15:0] ch1_buf;
reg signed [15:0] ch2_buf;

always @(posedge clk)begin
    if(cnt256_n == 8'd0)begin
        state <= ST_CLIP_L;
    end
end

always @(posedge clk)begin
	if(cnt256_n == 8'd1)begin
		ch1_out <= ch1_buf;
		ch2_out <= ch2_buf;
	end
end

always @(posedge clk)begin
	case(state)
		ST_IDLE : begin
			//No Action
		end
		ST_CLIP_L : begin
			if(ch1_in > $signed(16'h1FFF))begin
				ch1_buf <= 16'h1FFF;
			end
			else if(ch1_in < $signed(16'hE000))begin
				ch1_buf <= 16'hE000;
			end
			else begin
				ch1_buf <= ch1_in;
			end
			state <= ST_CLIP_R;
		end
		ST_CLIP_R : begin
			if(ch2_in > $signed(16'h1FFF))begin
				ch2_buf <= 16'h1FFF;
			end
			else if(ch2_in < $signed(16'hE000))begin
				ch2_buf <= 16'hE000;
			end
			else begin
				ch2_buf <= ch2_in;
			end
			state <= ST_IDLE;
		end
	endcase
end

endmodule
