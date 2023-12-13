module overflow_detect(
	input pclk,
	input preset_n,
	input last_counter,
	input [7:0] counter,
	input [7:0] up_down,
	input load,
	input enable,
	input clear_overflow,

	output overflow_flag);

	reg overflow_reg; // internal registor

	assign overflow_flag = overflow_reg; 
	
	always @(posedge pclk or posedge preset_n) begin
		if (~preset_n) begin
			// reset
			overflow_reg <= 1'b0;
		end
		else if(clear_overflow) begin
			overflow_reg <= 1'b0;
		end
		else begin
			if ((~up_down) && (~load) && (enable) && (last_counter == 8'hff) && (counter == 8'h00)) begin
				// wait for the next clk signal (optional depend on documents)
				@(posedge pclk) begin
					overflow_reg <= 1'b1;
				end
			end
			else begin
				overflow_reg <= 1'b0;
			end
		end
	end

endmodule