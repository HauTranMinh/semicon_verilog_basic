module fulladder(
	Sum, Cout, in1, in2, cin);
	
	output Sum, Cout;
	input in1, in2, cin;

	wire Sum, Cout, in1, in2, cin;
	wire I1, I2, I3;

	halfadder ha1 (I1, I2, in1, in2);
	halfadder ha2 (Sum, I3, in1, in2);

	assign 	Cout = 	cin	| I3;

	
endmodule