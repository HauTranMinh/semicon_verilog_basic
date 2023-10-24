module Q4(
	input a, b, c, d, e, f,
	output x,y,z);

	// reg a, b, c, d, e, f;
	// wire x,y,z;

	assign x = a << b;
	assign y = c << d;	
	assign z = e >> f;
		
	
endmodule