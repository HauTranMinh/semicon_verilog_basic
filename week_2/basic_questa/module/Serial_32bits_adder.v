module Serial_32bits_adder(Sum, Cout, A, B, Cin);

	input  Cin;
	input  [31:0] A;
	input  [31:0] B;
	output [31:0] Sum;
	output Cout;

	wire c1, c2, c3;

	Serial_8bits_adder M1 (.Sum(Sum[7:0]),   .Cout(c1),   .A(A[7:0]),   .B(B[7:0]),   .Cin(Cin));
	Serial_8bits_adder M2 (.Sum(Sum[15:8]),  .Cout(c2),   .A(A[15:8]),  .B(B[15:8]),  .Cin(c1));
	Serial_8bits_adder M3 (.Sum(Sum[23:16]), .Cout(c3),   .A(A[23:16]), .B(B[23:16]), .Cin(c2));
	Serial_8bits_adder M4 (.Sum(Sum[31:24]), .Cout(Cout), .A(A[31:24]), .B(B[31:24]), .Cin(c3));
	
endmodule