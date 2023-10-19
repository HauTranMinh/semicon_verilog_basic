module homework_2 (
	input [11:0] A, B,
	output [11:0] C,
	output [11:0] D,
	output [11:0] E);

	assign C = A|B;
	assign D = A&B;
	assign E = A^B;


endmodule