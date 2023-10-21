module halfadder(
	
	output wire sum,
	output wire cout,
	input wire A,B);

	assign sum = A ^ B;
	assign cout	= A & B;

endmodule