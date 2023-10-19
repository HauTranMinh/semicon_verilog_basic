module homework_3(
	input x0, x1,
	input a0, a1, a2,
	output y0, y1
	);

	assign y0 = x0 == 1 ? a0 : a1;
	//assign y1 = x1 == 1 ? y0 : a2;
	
endmodule 