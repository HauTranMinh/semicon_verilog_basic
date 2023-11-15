module CPU_model();


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
			@(posedge cpu_pclk); // T1
			#1; // depend on user
			cpu_paddr = address;
			cpu_pwrite = 1;
			cpu_psel = 1;
			cpu_pwdata = data;
			cpu_penable = 0;
			$display("at %0t start write data = 'h%0h to address = 'h%0h", $time, data, address);

			// access phase 
			@(posedge cpu_pclk); //T2
			#1;
			cpu_penable = 1;
			$display("at %0t acces phase of writing data", $time);

			// end of access phase
			@(posedge cpu_pclk); //T3 =>
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

	task read_cpu();

	endtask

endmodule