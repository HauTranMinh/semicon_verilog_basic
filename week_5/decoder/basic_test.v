module basic_test();
	reg [7:0] address, data;
	reg flag;
	reg [7:0] rdata_1;
	reg [7:0] rdata_2;
	reg [7:0] rdata_3;
	reg [7:0] rdata_4;
	reg [7:0] rdata_5;
	reg [7:0] rdata_6;
	reg [7:0] rdata_7;
	reg [7:0] rdata_8;
	reg [7:0] rdata, wdata;
	reg [7:0] addr;
	integer i;

	decoder_tb top();

	initial begin
		#10;

		for(i = 0; i<10; i = i + 1)
		begin
			addr = i;
			wdata = $random();
			top.cpu.write_CPU(addr, wdata);
			top.cpu.read_CPU(addr, rdata);
			if (rdata == wdata) begin
				flag = 0;
				$display("PASS");
			end
			else begin
				flag = 1;
				$display("FAIL");
			end
		end
		#10;
			top.get_results(flag);
		#10;


		$finish();
		
	end

endmodule