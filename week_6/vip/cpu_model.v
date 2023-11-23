module CPU_model(
	// I/O ports declare
	input cpu_pclk,
	input cpu_presetn,
	input cpu_pready,
	input cpu_pslverr,
	input [7:0] cpu_prdata,

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
// declare internal connection //
//==================================================================//

	reg [7:0] address_reg;
	reg [7:0] data_reg;
	reg pwrite_reg; 
	reg psel_reg; 
	reg penable_reg; 

//==================================================================//
// Task write CPU model //
//==================================================================//
	task write_CPU(input reg [7:0] address, data);
		begin
			// setup phase
			@(posedge cpu_pclk); // T1 <=> setup phase
				#5; // depend on user
				address_reg = address;
				pwrite_reg = 1'b1;
				psel_reg = 1'b1;
				data_reg = data;
				penable_reg = 1'b0;
			$display("at %0t start write data = 'h%0h to address = 'h%0h", $time, data, address);
 
			@(posedge cpu_pclk); //T2 <=> access phase 
				#5;
				penable_reg = 1'b1;
				
			$display("at %0t acces phase of writing data", $time);

			@(posedge cpu_pclk); //T3 <=> end of access phase
				#2;
					while(cpu_pready) begin
							if (cpu_pslverr) begin
								$display("at %0t write transfer has a error", $time);
								// address_reg = 8'h00;
								// pwrite_reg = 1'b0;
								// psel_reg = 1'b0;
								// data_reg = 8'h00;
								// penable_reg = 1'b0;
								end
							else begin
								// @(posedge cpu_pclk);
									address_reg = 8'h00;
									pwrite_reg = 1'b0;
									psel_reg = 1'b0;
									data_reg = 8'h00;
									penable_reg = 1'b0;
								$display("at %0t transfer done", $time);
								end
							end		
				@(posedge cpu_pclk);
				// while(!cpu_pready) begin
				// 	@(posedge cpu_pclk);
				// end
				// if(cpu_pslverr) begin
				// 	$display("at %0t write transfer has a error", $time);
				// end
				// else begin
				// 	address_reg = 8'h00;
				// 	pwrite_reg = 1'b0;
				// 	psel_reg = 1'b0;
				// 	data_reg = 8'h00;
				// 	penable_reg = 1'b0;
				// 	$display("at %0t transfer done", $time);
				// end
		end
				
	endtask
//==================================================================//
// Task read CPU model //
//==================================================================//
	task read_CPU(input [7:0] address, output [7:0] value_of_reg);
		begin

			@(posedge cpu_pclk); // T1 setup phase
				#5;
				address_reg = address;
				pwrite_reg = 1'b0;
				psel_reg = 1'b1;
				value_of_reg  = cpu_prdata;
				penable_reg = 1'b0;
			$display("at %0t start to read data at address 'h%0h", $time, address);

			@(posedge cpu_pclk); // T2 access phase
				#5;
				penable_reg = 1'b1;
				
			$display("at %0t data at address 'h%0h is 'h%0h", $time, address, value_of_reg);

			@(posedge cpu_pclk); // T3 end of access phase
				#2;
				while(cpu_pready) begin
						if (cpu_pslverr) begin
							$display("at %0t end of read transfer", $time);
						end
						else begin
							// @(posedge cpu_pclk);
							address_reg = address_reg;
							pwrite_reg = 1'b0;
							psel_reg = 1'b1;
							penable_reg = 1'b1;
							$display("at %0t end of read transfer", $time);
						end
				end
				@(posedge cpu_pclk);
				// while(!cpu_pready) begin
				// 	@(posedge cpu_pclk);
				// end
				// if(cpu_pslverr) begin
				// 	$display("at %0t read transfer has a error", $time);
				// end
				// else begin
				// 	address_reg = address_reg;
				// 	pwrite_reg = 1'b0;
				// 	psel_reg = 1'b0;
				// 	penable_reg = 1'b0;
				// 	$display("at %0t end of read transfer", $time);
				// end
				end
	endtask
//=================================================================================================//
//=================================RESET TASK======================================================//
	

	assign cpu_paddr 	= address_reg;
	assign cpu_pwdata 	= data_reg;
	assign cpu_pwrite 	= pwrite_reg;
	assign cpu_psel 	= psel_reg;
	assign cpu_penable 	= penable_reg;

// need to check slave error at T3 both read and write transfers//
endmodule	
