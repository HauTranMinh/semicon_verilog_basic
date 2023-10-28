module Serial_32bits_adder_tb;
	// Define wires for inputs and outputs
	reg [31:0] A, B;
	reg Cin;
	wire [31:0] Sum;
	wire Cout;

	// Instantiate the Serial_32bits_adder module
	Serial_32bits_adder dut (
		.Sum(Sum),
		.Cout(Cout),
		.Cin(Cin),
		.A(A),
		.B(B)
	);

	// Initialize inputs
	initial begin
		A = 15'hABCD1234;
		B = 15'hDCBA4312;
		Cin = 1'b0;

		// Add a delay to allow for propagation
		#10;

		// Change inputs for additional test cases
		A = 15'h1234ABCD;
		B = 15'h4321DCBA;
		Cin = 1'b1;

		#10;

	end

	// Display outputs
	always @(posedge Cout) begin
		$display("Sum = %b, Cout = %b", Sum, Cout);
	end

endmodule
