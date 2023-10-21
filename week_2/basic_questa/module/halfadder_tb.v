module half_adder_tb();
  
  // Inputs
  reg A, B;
  
  // Outputs
  wire Sum, Carry;
  
  // Instantiate the half adder
  halfadder dut (
    .A(A),
    .B(B),
    .sum(Sum),
    .cout(Carry)
  );
  
  // Stimulus
  initial begin

    
    // Test case 1: A = 0, B = 0
    A = 0;
    B = 0;
    #10;
    
    // Test case 2: A = 0, B = 1
    A = 0;
    B = 1;
    #10;
    
    // Test case 3: A = 1, B = 0
    A = 1;
    B = 0;
    #10;
    
    // Test case 4: A = 1, B = 1
    A = 1;
    B = 1;
    #10;
    
  end
  
endmodule
