module register(
	input pclk, 
	input preset_n,
	input psel,
	input penable,
	input pwrite,
	input [7:0] select_reg, // memory reg address
	input [7:0] pwdata,		// data for writing

	output [7:0] prdata,
	output pready,	
	output psvlerr);

`define  WAIT_CYCLES  2;

//---------------internal connection-------------------//
	reg [7:0] memory_reg [7:0];
	reg svlerr_reg;
	reg [7:0] data_reg; 
	reg [1:0] count;
	reg ready_reg;
	//assign pready = 1'b1;
//=======================================================================================//	
	always @(posedge pclk or negedge preset_n) begin
	 	if (~preset_n) begin
	 		// reset low => assign all the memory register to 8'b0000_0000
	 		memory_reg [0][7:0] <= 8'b0000_0000;
	 		memory_reg [1][7:0] <= 8'b0000_0000;
	 		memory_reg [2][7:0] <= 8'b0000_0000;
	 		memory_reg [3][7:0] <= 8'b0000_0000;
			memory_reg [4][7:0] <= 8'b0000_0000;
	 		memory_reg [5][7:0] <= 8'b0000_0000;
	 		memory_reg [6][7:0] <= 8'b0000_0000;
	 		memory_reg [7][7:0] <= 8'b0000_0000;
	 		// reset slave error bit
	 		svlerr_reg <= 1'b0;
	 	end
//=======================================================================================//
//==================== ABB protocol write transfer process===============================//
	 	else if (psel && pwrite && penable && pready) begin
	 		case (select_reg)
	 			8'b0000_0001: memory_reg [0][7:0] <= pwdata;
	 			8'b0000_0010: memory_reg [1][7:0] <= pwdata;
	 			8'b0000_0100: memory_reg [2][7:0] <= pwdata;
	 			8'b0000_1000: memory_reg [3][7:0] <= pwdata;
	 			8'b0001_0000: memory_reg [4][7:0] <= pwdata;
	 			8'b0010_0000: memory_reg [5][7:0] <= pwdata;
	 			8'b0100_0000: memory_reg [6][7:0] <= pwdata;
	 			8'b1000_0000: memory_reg [7][7:0] <= pwdata;
	 			// if access address is reserved
	 			default: svlerr_reg <= 1'b1; 
	 		endcase
	 	end
//=====================================================================================//
	 	else begin
	 		memory_reg [0][7:0] <= memory_reg[0][7:0];
	 		memory_reg [1][7:0] <= memory_reg[1][7:0];
	 		memory_reg [2][7:0] <= memory_reg[2][7:0];
	 		memory_reg [3][7:0] <= memory_reg[3][7:0];
			memory_reg [4][7:0] <= memory_reg[4][7:0];
	 		memory_reg [5][7:0] <= memory_reg[5][7:0];
	 		memory_reg [6][7:0] <= memory_reg[6][7:0];
	 		memory_reg [7][7:0] <= memory_reg[7][7:0];
	 		// normal state 
	 		svlerr_reg <= 1'b0;
	 	end
	 end 
//===============================================================================//
//===================read_transfer APB protocol==================================//
//=================================================================================//

	always @(psel or pclk or penable or pready or pwrite) begin
		if (psel && pready && ~pwrite && penable) begin
			case(select_reg)
				8'b0000_0001: data_reg = memory_reg [0][7:0];
	 			8'b0000_0010: data_reg = memory_reg [1][7:0];
	 			8'b0000_0100: data_reg = memory_reg [2][7:0];
	 			8'b0000_1000: data_reg = memory_reg [3][7:0];
	 			8'b0001_0000: data_reg = memory_reg [4][7:0];
	 			8'b0010_0000: data_reg = memory_reg [5][7:0];
	 			8'b0100_0000: data_reg = memory_reg [6][7:0];
	 			8'b1000_0000: data_reg = memory_reg [7][7:0];
	 			// if access address is reserved
	 			default: data_reg = 8'hXX; 
			endcase
		end
		else begin
			data_reg = 8'h00;
		end
	end
//===============================================================================//
//===================pready APB protocol==================================//
//=================================================================================//
	always @(posedge pclk or posedge preset_n) begin
		if (~preset_n) begin
			// reset
			ready_reg <= 1'b0;
			count <= 2'b00;

		end
		else if (psel && penable && count == 2'b00) begin
			ready_reg <= 1'b0;
		end
		else if (psel == 1'b1) begin
			if(count == `WAIT_CYCLES)
			begin
				#2;
				ready_reg <= 1'b1;
				count <= 2'b00;
			end
			else begin
				count <= count + 2'b01; 
			end
		end
		else begin
			ready_reg <= 1'b0;
		end
	end

	
//=================================================================================//
	assign psvlerr = svlerr_reg;
	assign prdata = data_reg;
	assign pready = ready_reg;
	
endmodule