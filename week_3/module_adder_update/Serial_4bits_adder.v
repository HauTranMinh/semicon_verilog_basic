module Serial_4bits_adder(Sum, Cout, Cin, in1, in2);
	//declare I/O ports
	input [3:0] in1, in2;
	input Cin;
	output [3:0] Sum;
	output Cout;
	//declare local signal
	wire [2:0] Carry;

	fulladder fa1(.Sum(Sum[0]), .Cout(Carry[0]), .in1(in1[0]), .in2(in2[0]), .cin(Cin));
	fulladder fa2(.Sum(Sum[1]), .Cout(Carry[1]), .in1(in1[1]), .in2(in2[1]), .cin(Carry[0]));
	fulladder fa3(.Sum(Sum[2]), .Cout(Carry[2]), .in1(in1[2]), .in2(in2[2]), .cin(Carry[1]));
	fulladder fa4(.Sum(Sum[3]), .Cout(Cout),     .in1(in1[3]), .in2(in2[3]), .cin(Carry[2]));

endmodule
