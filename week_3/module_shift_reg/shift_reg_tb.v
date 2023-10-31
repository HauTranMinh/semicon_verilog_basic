module shift_reg_tb();

    reg OP, reset, clk, data;
    wire [7:0] Q_n, Q;

    shift_reg uut (
        .OP(OP),
        .CLK(clk),
        .reset(reset),
        .data(data),
        .Q(Q),
        .Q_n(Q_n)
    );
    // initial first status
    initial begin
        data = 0;
        clk = 0;
        reset = 0;
        OP = 1;
        #10;

        reset = 1;
        #10;
        reset = 0;
        #10;

        data = 1;
        #50;
        data = 0;
        //#10;
        $finish;
    end

    always begin
        clk = ~clk;
        #5;
    end

    
endmodule
