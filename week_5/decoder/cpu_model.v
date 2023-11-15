module CPU_model(
	// I/O ports declare
	input cpu_pclk,
	input cpu_presetn,
	input cpu_pready,
	input cpu_pslverr,
	input  [7:0] cpu_prdata,

	output [7:0] cpu_paddr,
	output [7:0] cpu_pwdata,
	output cpu_psel,
	output cpu_penable,
	output cpu_pwrite);


// write <= address + data
// task write: following write tranfer APB protocal

// read <= addess
// task read: read transfer APB protocol

//==================================================================//
// Task write CPU model //
//==================================================================//

	task write_CPU(input [7:0] address, data);
		begin
			// setup phase
			@(posedge cpu_pclk); // T1 <=> setup phase
				#1; // depend on user
				cpu_paddr = address;
				cpu_pwrite = 1;
				cpu_psel = 1;
				cpu_pwdata = data;
				cpu_penable = 0;
			$display("at %0t start write data = 'h%0h to address = 'h%0h", $time, data, address);
 
			@(posedge cpu_pclk); //T2 <=> access phase 
				#1;
				cpu_penable = 1;
			$display("at %0t acces phase of writing data", $time);

			@(posedge cpu_pclk); //T3 <=> end of access phase
				while(!cpu_pready) 
					begin
						@(posedge cpu_pclk);
					end
				cpu_paddr = 8'h00;
				cpu_pwrite = 0;
				cpu_psel = 0;
				cpu_pwdata = 8'h00;
				cpu_penable = 0;
			$display("at %0t transfer done", $time);
	
		end
	endtask

	task read_cpu(input	[7:0] address, output [7:0] value_of_reg);
		@(posedge cpu_pclk); // T1 setup phase
			#1;
			cpu_paddr = address;
			cpu_pwrite = 1'b0;
			cpu_psel = 1'b1;
			cpu_penable = 1'b0;

		@(posedge cpu_pclk); // T2 access phase
			#1;
			cpu_penable = 1'b1;
			value_of_reg  = cpu_prdata;

		@(posedge cpu_pclk); // T3 end of access phase
			#1;
			while(!cpu_pready)
				begin
					@(posedge cpu_pclk)
				end
			cpu_paddr = cpu_paddr;
			cpu_pwrite = 1'b0;
			cpu_psel = 1'b0;
			cpu_penable = 1'b0;
	endtask

// still could process the slverr signal //
endmodule