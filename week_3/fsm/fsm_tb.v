module fsm_tb;
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
  always begin
    #1 clk = ~clk;
  end

  // Initial values
  initial begin
    clk = 0;
    rst_n = 0;
    //state = 2'b00;
    //data_in = 0;

    // Apply a reset and allow time for it to settle
    rst_n = 1;
    #5 rst_n = 0;
    #5 rst_n = 1;

    // Test sequence: "10011001111010"
    #5 data_in = 1;
    #5 data_in = 0;
    #5 data_in = 0;
    #5 data_in = 1;
    #5 data_in = 1;
    #5 data_in = 0;
    #5 data_in = 0;
    #5 data_in = 1;
    #5 data_in = 1;
    #5 data_in = 1;
    #5 data_in = 0;
    #5 data_in = 1;
    #5 data_in = 0;
    // Add more delays or additional data_in values if needed
    #20;
    // Finish the simulation
    $finish;
  end

  // Display the state
  always @(posedge clk) begin
    $display("State: %b, Signal Out: %b", state, signal_out);
  end

endmodule

// Run the simulation
// initial begin
//   $dumpfile("fsm_tb.vcd");
//   $dumpvars(0, fsm_tb);
//   $display("Starting FSM testbench...");
//   $monitor("Time: %t, State: %b, Signal Out: %b", $time, state, signal_out);
//   $timeformat(-9, 1, " ns", 10);
//   $start = 0;
//   #1000 $stop;
// end
