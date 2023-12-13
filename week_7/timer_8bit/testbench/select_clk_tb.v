`timescale 1ns/1ns  // Define simulation timescale

module testbench;

  // Define parameters
  parameter PERIOD = 10;  // Clock period in simulation time units
  parameter SIM_TIME = 100;  // Simulation time in time units

  // Declare signals
  reg clk, preset_n;
  reg [1:0] cks;
  wire int_clk;

  // Instantiate the module under test
  select_clock dut (
    .clk(clk),
    .preset_n(preset_n),
    .cks(cks),
    .int_clk(int_clk)
  );

  // Clock generation
  always begin
    clk = 0;
    forever #5 clk = ~clk;  // Toggle the clock every half period
  end

  // Initial block
  initial begin
    // Initialize signals
    clk = 0;
    preset_n = 1;
    cks = 2'b00;

    // Apply reset
    #10 preset_n = 0;

    // Release reset
    #10 preset_n = 1;

    // Apply some inputs
    #10 cks = 2'b01;
    #10 cks = 2'b10;
    #10 cks = 2'b11;

    // Run simulation for a specific time
    #SIM_TIME $finish;  // Stop simulation after SIM_TIME units

  end

  // Display statements to show signal values
  always @(posedge clk) begin
    $display("Time = %0t, clk = %b, preset_n = %b, cks = %b, int_clk = %b",
             $time, clk, preset_n, cks, int_clk);
  end

endmodule
