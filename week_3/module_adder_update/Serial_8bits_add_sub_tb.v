module Serial_8bits_add_sub_tb();

    reg [7:0] in1, in2;
    reg Cin, SU, EO;
    wire [7:0] result;
    wire Cout;

    Serial_8bits_add_sub uut (
        .result(result),
        .Cin(SU),
        .Cout(Cout),
        .in1(in1),
        .in2(in2),
        .EO(EO),
        .SU(SU)
    );

    // Initialize inputs
    initial begin
        in1 = $random();
        in2 = $random();
        Cin = 1'b0;
        SU = 1'b0;
        EO = 1'b1;

        // Add a delay to allow for signal propagation
        #10;

        // Change inputs for additional test cases
        in1 = $random();
        in2 = $random();
        Cin = 1'b1;
        SU = 1'b1;
        EO = 1'b1;

        #10;

        in1 = $random();
        in2 = $random();
        Cin = 1'b0;
        SU = 1'b0;
        EO = 1'b0;

        // Add a delay to allow for signal propagation
        #10;

        // Change inputs for additional test cases
        in1 = $random();
        in2 = $random();
        Cin = 1'b1;
        SU = 1'b1;
        EO = 1'b0;

        #10;
    
        // Finish simulation
        $finish;
    end

    // Display outputs
    always @(posedge Cout) begin
        $display("Result = %b, Cout = %b", result, Cout);
    end
endmodule
