module Serial_8bits_adder_tb();
    // Define wires for inputs and outputs
    reg [7:0] A, B;
    reg Cin;
    wire [7:0] Sum;
    wire Cout;

    // Instantiate the Serial_8bits_adder module
    Serial_8bits_adder dut (
        .Sum(Sum),
        .Cout(Cout),
        .Cin(Cin),
        .A(A),
        .B(B)
    );

    // Initialize inputs
    initial begin
        A = 8'h7f;
        B = 8'hff;
        Cin = 1'b0;

        // Add a delay to allow for propagation
        #10;

        // Change inputs for additional test cases
        A = 8'hff;
        B = 8'hf1;
        Cin = 1'b1;

        #10;
        A = 8'd15;
        B = 8'd15;
        Cin = 1'b0;

        #10;
        // Finish simulation
        //$finish;
    end

    // Display outputs
    always @(posedge Cout) begin
        $display("Sum = %b, Cout = %b", Sum, Cout);
    end
endmodule
