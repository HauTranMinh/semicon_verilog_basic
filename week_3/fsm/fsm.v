module fsm(data_in, signal_out, clk, rst_n);

	input data_in, clk, rst_n;
	output signal_out;

	reg [1:0] state, next_state;
	

	always @(posedge clk or negedge rst_n) begin
		case (state)
			// state A: 00 
			2'b00: 
				if (data_in) begin
					state <= 2'b01;
					signal_out <= 1'b0;
				end
				else begin
					state <= 2'b00;
					signal_out <= 1'b0;
				end

			// state B: 01 
			2'b01: 
				if (data_in) begin
					state <= 2'b10;
					signal_out <= 1'b0;
				end
				else begin
					state <= 2'b00;
					signal_out <= 1'b0;
				end

			// state C: 10 
			2'b10: 
				if (data_in) begin
					state <= 2'b10;
					signal_out <= 1'b0;
				end
				else begin
					state <= 2'b11;
					signal_out <= 1'b0;
				end

			// state D: 11
			2'b11: 
				if (data_in) begin
					state <= 2'b01;
					signal_out <= 1'b1;
				end
				else begin
					state <= 2'b00;
					signal_out <= 1'b0;
				end
			default:
					state <= 0;
					signal_out <= 0;
		endcase

	end
	
	always @(posedge clk or negedge rst_n) begin
		if (~rst_n) begin
			// reset
			state <= 2'b00;
		end
		else begin
			state <= next_state;
		end
	end
	
endmodule 