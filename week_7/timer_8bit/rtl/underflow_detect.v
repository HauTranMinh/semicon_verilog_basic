module underflow_detect(
	input pclk,
	input preset_n,
	input [7:0] last_counter,
	input [7:0] counter,
	input up_down,
	input load,
	input enable,
	input clear_underflow,

	output underflow_flag);

	reg underflow_reg;

	assign underflow_flag = underflow_reg;

	always @(posedge pclk or posedge preset_n) begin
		if (~preset_n) begin
			// reset
			underflow_reg <= 1'b0;
		end
		else if(clear_underflow) begin
			underflow_reg <= 1'b0;
		end
		else begin
			if ((up_down) && (enable) && (~load) && (last_counter == 8'h00) && (counter == 8'hff)) begin
				// wait for the next rising clk signal (optional depend on documents)
				@(posedge pclk) begin
					underflow_reg <= 1'b1;
				end
			end
			else begin
				underflow_reg <= 1'b0;
			end
		end
	end


endmodule