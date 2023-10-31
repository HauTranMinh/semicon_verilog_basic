module shift_reg(data, reset, CLK, Q, Q_n, OP);

	// declare I/O ports for module 
	input OP, CLK, reset, data;
	output [7:0] Q_n, Q;

	wire [7:0] r_next;
	reg  [7:0] r_reg;

	// behavior of FF
	always @(posedge CLK or posedge reset) begin
		if (reset) begin
			// reset asyn
			r_reg <= 8'h00;
		end
		else begin
			r_reg <= r_next; 
		end
	end

	// Option bit to decide shift left or right
	assign r_next = OP ? {r_reg[6:0], data} : {data, r_reg[7:1]};

	// Assign signal to output
	assign Q = r_reg;
	assign Q_n = ~r_reg;

endmodule 