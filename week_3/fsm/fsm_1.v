module fsm(data, clk, rst_n, out);

	input data, clk, rst_n;
	output out;

	parameter A = 0, B = 1, C = 2, D = 3;

	reg [1:0] current, next;

	always @(posedge clk or negedge rst_n) begin
		if (!rst_n) begin
			// reset
			current <= A;
		end
		else begin
			current <= next;
		end
	end

	
endmodule