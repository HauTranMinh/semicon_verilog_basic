module fulladder_tb();

	reg in1, in2;
	reg Cin;

	wire Sum, Cout;

	fulladder uut(
		.Sum(Sum),
		.Cout(Cout),
		.in1(in1),
		.in2(in2),
		.cin(Cin));

	initial begin
		// Initialize inputs
	    in1 = 0;
	    in2 = 0;
	    Cin = 0;

	    // Monitor signals
	    
	    

	    // Test case 1: 0 + 0 + 0
	    in1 = 0; in2 = 0; Cin = 0;
	    #10;

	    // Test case 2: 0 + 0 + 1
	    in1 = 0; in2 = 0; Cin = 1;
	    #10;

	    // Test case 3: 0 + 1 + 0
	    in1 = 0; in2 = 1; Cin = 0;
	    #10;

	    // Test case 4: 0 + 1 + 1
	    in1 = 0; in2 = 1; Cin = 1;
	    #10;

	    // Test case 5: 1 + 0 + 0
	    in1 = 1; in2 = 0; Cin = 0;
	    #10;

	    // Test case 6: 1 + 0 + 1
	    in1 = 1; in2 = 0; Cin = 1;
	    #10;

	    // Test case 7: 1 + 1 + 0
	    in1 = 1; in2 = 1; Cin = 0;
	    #10;

	    // Test case 8: 1 + 1 + 1
	    in1 = 1; in2 = 1; Cin = 1;
	    #10;
	   
	end


	
endmodule 