// Testbench for homework_1 module

module Helloworld_testbench();

    reg t_a, t_b;
    wire t_y1, t_y2, t_y3, t_y4, t_y5, t_y6, t_y7;

    basic_gate dut(.a(t_a), .b(t_b), .y1(t_y1), .y2(t_y2), .y3(t_y3), .y4(t_y4), .y5(t_y5), .y6(t_y6), .y7(t_y7));

    initial begin
        t_a = 0;
        t_b = 0;
        #10;

        t_a = 0;
        t_b = 1;
        #10;

        t_a = 1;
        t_b = 0;
        #10;

        t_a = 1;
        t_b = 1;
        #10;
    end

    initial begin
        $display("Input A = %b", t_a);
        $display("Input B = %b", t_b);
    // Add a delay to wait for simulation to complete
        #20;
        $display("Output Y1 = %b", t_y1);
        $display("Output Y2 = %b", t_y2);
        $display("Output Y3 = %b", t_y3);
        $display("Output Y4 = %b", t_y4);
        $display("Output Y5 = %b", t_y5);
        $display("Output Y6 = %b", t_y6);
        $display("Output Y7 = %b", t_y7);

  end

  

endmodule
