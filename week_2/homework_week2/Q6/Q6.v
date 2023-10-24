module example();

reg [3:0] a, b;
reg [7:0] c, d;

initial
begin
   a = 4'b1110;   
   b = 4'b0110;   
   $display( "%b", a < b ); // Ket qua %b = 0 (a>b is true)
   $display( "%b", a > 8 );
   $display( "%b", a <= b );
   $display( "%b", a >= 10 );
   $display( "%b", a < 4'b1zzz );
   $display( "%b", b < 4'b1x01 );

   a = 4'b1100;
   b = 4'b101x;
   $display( "%b", a == 4'b1100 );
   $display( "%b", a != 4'b1100 );
   $display( "%b", a == 4'b1z10 ); //?????
   $display( "%b", a != 4'b100x );
   $display( "%b", b == 4'b101x );
   $display( "%b", b != 4'b101x );
   $display( "%b", b === 4'b101x );
   $display( "%b", b !== 4'b101x );

   a = 4'b1100;
   b = 4'b0000;
   $display( "%b", !a );
   $display( "%b", !b );
   $display( "%b", a && b ); 
   $display( "%b", a || b );

   c = 8'b1010xzxz;
   d = 8'b10010011;
   $display( "%b", c & d );  
   $display( "%b", c | d );  
   $display( "%b", c ^ d );  
   $display( "%b", c ~^ d );  
   $display( "%b", ~ c );  

   a = 4'b1111;
   $display( "%b", a << 3 );  
   $display( "%b", a >> 3 );  
   $display( "%b", a << 1'bz );  
   $display( "%b", a >> 1'bx );  
end
endmodule
