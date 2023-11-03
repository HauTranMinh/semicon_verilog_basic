module fsm(data_in, signal_out, clk, rst_n, state, next_state);

	input data_in, clk, rst_n;
	output signal_out, state, next_state;

	reg [1:0] state, next_state;
	reg signal;
	
	always @(posedge clk or negedge rst_n) begin
		case (state)
			// state A: 00 
			2'b00: 
				if (data_in) begin
					next_state <= 2'b01;
					signal <= 1'b0;
				end
				else begin
					next_state <= 2'b00;
					signal <= 1'b0;
				end

			// state B: 01 
			2'b01: 
				if (data_in) begin
					next_state <= 2'b10;
					signal <= 1'b0;
				end
				else begin
					next_state <= 2'b00;
					signal <= 1'b0;
				end

			// state C: 10 
			2'b10: 
				if (data_in) begin
					next_state <= 2'b10;
					signal <= 1'b0;
				end
				else begin
					next_state <= 2'b11;
					signal <= 1'b0;
				end

			// state D: 11
			2'b11: 
				if (data_in) begin
					next_state <= 2'b01;
					signal <= 1'b1;
				end
				else begin
					next_state <= 2'b00;
					signal	 <= 1'b0;
				end
			default: state <= 2'b00;
		endcase
	end


	// Flips_flops
	always @(posedge clk or negedge rst_n) begin
		if (~rst_n) begin
			// reset 
			next_state <= 2'b00;
		end
		else begin
			state <= next_state;
		end
	end

	assign signal_out = signal;

endmodule 