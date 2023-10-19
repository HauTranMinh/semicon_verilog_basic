// Testbench for homework_1 module

module testbench;

  // Declare signals for inputs and outputs
  reg [5:0] A;
  reg [5:0] B;
  wire [5:0] C;
  wire [5:0] D;
  wire [5:0] E;

  // Instantiate the module to be tested
  homework_1 uut (
    .A(A),
    .B(B),
    .C(C),
	 .D(D),
	 .E(E)
  );

  // Initialize inputs A and B
  initial begin
    A = 6'b101100;
    B = 6'b101011;
    // Add a delay to allow time for the simulation
    #10;
    // Stop the simulation
    //$finish;
  end

  // Display input and output values
  initial begin
    $display("Input A = %b", A);
    $display("Input B = %b", B);
    // Add a delay to wait for simulation to complete
    #20;
    $display("Output C = %b", C);
    $display("Output D = %b", D);
    $display("Output E = %b", E);
  end

endmodule
