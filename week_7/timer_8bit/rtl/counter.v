module counter(
	input pclk,
	input preset_n,
	input [7:0] TDR,
	input [7:0] TCR,
	input clk_in,

	output [7:0] counter_signal,
	output [7:0] last_counter);
//===========================internal register==============================//
	reg [7:0] counter_reg;
	reg [7:0] last_counter_reg;
	reg last_clk_internal;
	wire count_enable; // for edge detector

	assign counter_signal = counter_reg;
	assign last_counter = last_counter_reg;
//================================Control Logic=============================//	
	assign count_enable = (~last_clk_internal) & clk_in; 

	always @(posedge pclk or posedge preset_n) begin
		if (~preset_n) begin
			// reset
			last_clk_internal <= 1'b0;
		end
		else begin
			last_clk_internal <= clk_in; 
		end
	end
//=========================================================================//
	always @(posedge pclk or posedge preset_n) begin
		if (~preset_n) begin
			// reset
			counter_reg <= 8'h00;
		end
		else begin
			if (TCR[7]) begin // Load TDR to counter
				counter_reg <= TDR;
			end
			else begin // load bit == 0 => normal operation
				if (TCR[4]) begin
					if (TCR[3]) begin // up_down bit == 1 => countdown
						if (count_enable) begin // count_enable == 1 => are able to count 
							counter_reg <= counter_reg - 1'b1;
						end
						else begin // count_enable == 0 => are not able to count 
							counter_reg <= counter_reg;
						end
					end
					else begin // up_down bit == 0 => countup
						if (count_enable) begin // count_enable == 1 => are able to count 
							counter_reg <= counter_reg + 1'b1;
						end
						else begin // count_enable == 0 => are not able to count 
							counter_reg <= counter_reg;
						end
					end
				end
				else begin
					counter_reg <= counter_reg;
				end
			end
		end
	end

	// counter value for compare => take the previous value of counter reg
	// config as an Dff => delay the previous clk value

	always @(posedge pclk or posedge preset_n) begin
		if (~preset_n) begin
			// reset
			last_counter_reg <= 1'b0;
		end
		else begin
			last_counter_reg <= counter_reg;
		end
	end


endmodule