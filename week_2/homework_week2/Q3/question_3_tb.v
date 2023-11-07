module testbench ();
	
	reg x0, x1;
	reg [3:0] a0, a1, a2;
	wire [3:0] y0,  y1;
	

	homework_3 uut(
		.x0(x0),
		.x1(x1),
		.a0(a0),
		.a1(a1),
		.a2(a2),
		.y0(y0),
		.y1(y1));

	initial begin
		x0 = 1'b0;
		x1 = 1'b0;
		a0 = 4'ha;
		a1 = 4'hb;
		a2 = 4'hc;

		#10;

		x0 = 1'b1;
		x1 = 1'b0;
		a0 = 4'ha;
		a1 = 4'hb;
		a2 = 4'hc;

		#10 ;

		x0 = 1'b0;
		x1 = 1'b1;
		a0 = 4'ha;
		a1 = 4'hb;
		a2 = 4'hc;

		#10 ;

		x0 = 1'b1;
		x1 = 1'b1;
		a0 = 4'ha;
		a1 = 4'hb;
		a2 = 4'hc;

		#10 ;

	end

	initial begin
	    $display("Input x0 = %b", x0);
	    $display("Input x1 = %b", x1);
	    $display("Input a0 = %b", a0);
	    $display("Input a1 = %b", a1);
	    $display("Input a2 = %b", a2);
	    
	    // Add a delay to wait for simulation to complete
	    #20;
	    $display("Output y0 = %b", y0);
	    $display("Output y1 = %b", y1);
  	end
endmodule