module fulladder(
	output Sum, Cout,
	input  in1, in2, cin);


	wire I1, I2, I3;

	halfadder ha1 (I1, I2, in1, in2);
	halfadder ha2 (Sum, I3, I1, cin);

	assign 	Cout = 	I2	|| I3;

endmodule