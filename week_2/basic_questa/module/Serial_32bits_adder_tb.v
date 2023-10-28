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
		A = 32'b11001100110011001100110011001100;
		B = 32'b10101010101010101010101010101010;
		Cin = 1'b0;

		// Add a delay to allow for propagation
		#10;

		// Change inputs for additional test cases
		A = 32'b11110000111100001111000011110000;
		B = 32'b00001111000011110000111100001111;
		Cin = 1'b1;

		#10;

	end

	// Display outputs
	always @(posedge Cout) begin
		$display("Sum = %b, Cout = %b", Sum, Cout);
	end

endmodule
