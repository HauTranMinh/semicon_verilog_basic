module Serial_4bits_adder_tb();

    reg [3:0] in1, in2;
    reg Cin;
    wire [3:0] Sum;
    wire Cout;

    Serial_4bits_adder uut (
        .Sum(Sum),
        .Cout(Cout),
        .in1(in1),
        .in2(in2),
        .Cin(Cin)
    );

    // Initialize inputs
    initial begin
        in1 = 4'b1101;
        in2 = 4'b0110;
        Cin = 1'b0;

        // Add a delay to allow for propagation
        #10;

        // Change inputs for additional test cases
        in1 = 4'b1110;
        in2 = 4'b0001;
        Cin = 1'b1;

        #10;

        // Add more test cases as needed

        // Finish simulation
        $finish;
    end

    // Display outputs
    always @(posedge Cout) begin
        $display("Sum = %b, Cout = %b", Sum, Cout);
    end
endmodule
