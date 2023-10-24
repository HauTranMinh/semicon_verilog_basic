module Q4_tb();
	
  	reg  [7:0] a, b, c, d, e, f;
	//wire [7:0] x,y,z;


	initial begin
		// initial the input values
		a = 4'd12;
		b = 2'b10;
		c = 8'hA9;
		d = 4'd8;
		e = 8'hB4;
		f = 3'b10;
		

		// Display the output values
	    $display("x = %d", a << 1);
	    $display("y = %d", c << 3);
	    $display("z = %d", e >> 1);
	end
endmodule