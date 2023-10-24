module Q4_tb();
	
  reg [7:0] a, b, c, d, e, f;
	wire [7:0] x,y,z;

	 Q4 dut (
	    .a(a),
	    .b(b),
	    .c(c),
	    .d(d),
	    .e(e),
	    .f(f),
	    .x(x),
	    .y(y),
	    .z(z));

	initial begin
		// initial the input values
		a = 4'd12;
		b = 2'b10;
		c = 8'ha9;
		d = 4'd8;
		e = 8'hB4;
		e = 3'b10;
		#10;

		// Display the output values
	    $display("x = %d", x);
	    $display("y = %d", y);
	    $display("z = %d", z);
	end
endmodule