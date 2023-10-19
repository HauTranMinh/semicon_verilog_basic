module homework_1 (A, B, C);

	input reg [5:0] A;
	input reg [5:0] B;
	output wire [5:0] C;

	assign C = A|B;

endmodule
