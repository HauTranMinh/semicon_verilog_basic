module Serial_8bits_adder(Sum, Cout, Cin, A, B);
	// define I/O parameters
	input  [7:0] A, B;
	input  Cin;
	output [7:0] Sum;
	output Cout;
	// declare local net signal
	wire c1, c2, c3, c4, c5, c6, c7;

	fulladder fa1(.Sum(Sum[0]),.Cout(c1),   .in1(A[0]),.in2(B[0]),.cin(Cin));
	fulladder fa2(.Sum(Sum[1]),.Cout(c2),   .in1(A[1]),.in2(B[1]),.cin(c1));
	fulladder fa3(.Sum(Sum[2]),.Cout(c3),   .in1(A[2]),.in2(B[2]),.cin(c2));
	fulladder fa4(.Sum(Sum[3]),.Cout(c4),   .in1(A[3]),.in2(B[3]),.cin(c3));
	fulladder fa5(.Sum(Sum[4]),.Cout(c5),   .in1(A[4]),.in2(B[4]),.cin(c4));
	fulladder fa6(.Sum(Sum[5]),.Cout(c6),   .in1(A[5]),.in2(B[5]),.cin(c5));
	fulladder fa7(.Sum(Sum[6]),.Cout(c7),   .in1(A[6]),.in2(B[6]),.cin(c6));
	fulladder fa8(.Sum(Sum[7]),.Cout(Cout), .in1(A[7]),.in2(B[7]),.cin(c7));

 
endmodule