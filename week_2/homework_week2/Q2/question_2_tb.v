// Testbench for homework_2 module

module testbench;

  // Declare signals for inputs and outputs
  reg [11:0] A;
  reg [11:0] B;
  wire [11:0] C;
  wire [11:0] D;
  wire [11:0] E;

  // Instantiate the module to be tested
  homework_2 uut (
    .A(A),
    .B(B),
    .C(C),
	 .D(D),
	 .E(E)
  );

  // Initialize inputs A and B
  initial begin
    A = 12'ha4b;
    B = 12'h101;
    // Add a delay to allow time for the simulation
    #10;
    // Stop the simulation

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
