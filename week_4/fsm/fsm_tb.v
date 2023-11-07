module fsm_tb();
  reg clk;
  reg rst_n;
  wire [1:0] state, next_state;
  reg data_in;
  wire signal_out;


  // Instantiate the FSM module
  fsm dut (
    .data_in(data_in),
    .signal_out(signal_out),
    .clk(clk),
    .rst_n(rst_n),
    .state(state),
    .next_state(next_state)
  );

  // Clock generation
  // always begin
  //   #1 clk = ~clk;
  // end

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Initial values
  initial begin
    clk = 0;
    rst_n = 0;
    #5;
    // Apply a reset and allow time for it to settle
    rst_n = 1;
    #5;
    // test reset system
    #5 rst_n = 0;
    #5 rst_n = 1;

    // Test sequence: "10011001111010"
    #12 data_in = 1;
    #12 data_in = 0;
    #12 data_in = 0;
    #12 data_in = 1;
    #12 data_in = 1;
    #12 data_in = 0;
    #12 data_in = 0;
    #12 data_in = 1;
    #12 data_in = 1;
    #12 data_in = 1;
    #12 data_in = 0;
    #12 data_in = 1;
    #12 data_in = 0;
    // Add more delays or additional data_in values if needed
    #50;
    // Finish the simulation
    $finish;
  end

  // Display the state
  always @(posedge clk) begin
    $display("State: %b, Signal Out: %b", state, signal_out);
  end

endmodule


