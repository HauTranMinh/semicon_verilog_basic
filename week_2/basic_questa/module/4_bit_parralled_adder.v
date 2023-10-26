module paralled_adder(
	input 	[3:0] A, B,
	input 	OP,
	output 	[3:0] Sum,
	output	Overflow, Carry_out);

	reg 	[3:0] Carry;
	wire 	[3:0] temp_wire;

	assign temp_wire[0] = B[0] ^ OP;
	assign temp_wire[1] = B[1] ^ OP;
	assign temp_wire[2] = B[2] ^ OP;
	assign temp_wire[3] = B[3] ^ OP;

	fulladder M0(Sum[0], Carry[0], OP, 		 A[0], temp_wire[0]);
	fulladder M1(Sum[1], Carry[1], Carry[0], A[1], temp_wire[1]);
	fulladder M2(Sum[2], Carry[2], Carry[1], A[2], temp_wire[2]);
	fulladder M3(Sum[3], Carry[3], Carry[2], A[3], temp_wire[3]);
	
	assign Carry_out = Carry[3];
	assign Overflow  = Carry[2] ^ Carry[3];

	 
endmodule