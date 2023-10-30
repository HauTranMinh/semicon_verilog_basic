module Serial_8bits_add_sub(result, Cin, Cout, in1, in2, EO, SU);
	
	// declare I/O ports for module
	input [7:0] in1, in2;
	input Cin;
	output [7:0] result;
	output Cout;

	// declare control signals
	input SU;
	input tri EO;

	//declare local signals 
	wire [7:0] in2_temp;
	wire [7:0] result_temp;
	wire  carry;

	// RTL code
	//assign Cin = SU;

	// with SU = HIGH => SUB 
	// with SU = LOW  => ADD
	assign in2_temp[0] = in2[0] ^ SU;
	assign in2_temp[1] = in2[1] ^ SU;
	assign in2_temp[2] = in2[2] ^ SU;
	assign in2_temp[3] = in2[3] ^ SU;
	assign in2_temp[4] = in2[4] ^ SU;
	assign in2_temp[5] = in2[5] ^ SU;
	assign in2_temp[6] = in2[6] ^ SU;
	assign in2_temp[7] = in2[7] ^ SU;

	Serial_4bits_adder M0 (.Sum(result_temp[3:0]), .Cout(carry), .in1(in1[3:0]), .in2(in2_temp[3:0]), .Cin(Cin));
	Serial_4bits_adder M1 (.Sum(result_temp[7:4]), .Cout(Cout),  .in1(in1[7:4]), .in2(in2_temp[7:4]), .Cin(carry));


	// with EO (enable output) = HIGH => result = result temp / else disconnect (z)
	assign result[0] = EO ? result_temp[0] : 1'bz;
	assign result[1] = EO ? result_temp[1] : 1'bz;
	assign result[2] = EO ? result_temp[2] : 1'bz;
	assign result[3] = EO ? result_temp[3] : 1'bz; 
	assign result[4] = EO ? result_temp[4] : 1'bz;
	assign result[5] = EO ? result_temp[5] : 1'bz;
	assign result[6] = EO ? result_temp[6] : 1'bz;
	assign result[7] = EO ? result_temp[7] : 1'bz;

endmodule