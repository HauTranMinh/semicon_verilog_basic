module operators();
reg [3:0] a, b;
  initial begin
    a = 4'd3; 
    b = 4'd3;
    // DOB: 03/01/2001

    $display(a + b );  // addition operator
    $display(a ? b: 1); // condition operator => if a == 1 then return b otherwise return 1
    $display(a * b );  // multiplication operator 
    $display(a / b ); // division operator 
    $display(b / a ); // division operator 
    $display(a % b ); // division operator 
    $display((a>>2) % 4 ); // shift left and % =>   a = 4'd3 = 4'b0011 => a >> 2 = 0000 = 0 decimal => return 0
    $display((a<<3) % (b<<1)); // return 2


  end
endmodule
