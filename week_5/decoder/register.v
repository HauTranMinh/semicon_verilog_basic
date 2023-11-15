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

//---------------internal connection-------------------//
	reg [7:0] memory_reg [7:0];
	reg [7:0] value_of_reg;
	reg svlerr_reg;
	reg ready_reg;
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
	 	end
//=======================================================================================//
//==================== ABB protocol write transfer process===============================//
	 	else if (psel && pwrite && penable && select_reg[0]) begin
	 		memory_reg [0][7:0] <= pwdata;
	 	end
	 	else if (psel && pwrite && penable && select_reg[1]) begin
	 		memory_reg [1][7:0] <= pwdata;
	 	end
	 	else if (psel && pwrite && penable && select_reg[2]) begin
	 		memory_reg [2][7:0] <= pwdata;
	 	end
	 	else if (psel && pwrite && penable && select_reg[3]) begin
	 		memory_reg [3][7:0] <= pwdata;
	 	end
	 	else if (psel && pwrite && penable && select_reg[4]) begin
	 		memory_reg [4][7:0] <= pwdata;
	 	end
	 	else if (psel && pwrite && penable && select_reg[5]) begin
	 		memory_reg [5][7:0] <= pwdata;
	 	end
	 	else if (psel && pwrite && penable && select_reg[6]) begin
	 		memory_reg [6][7:0] <= pwdata;
	 	end
	 	else if (psel && pwrite && penable && select_reg[7]) begin
	 		memory_reg [7][7:0] <= pwdata;
	 	end
//=====================================================================================//
//================== ABB protocol read transfer process================================//	
		else if (psel && !pwrite && penable && select_reg[0]) begin
			value_of_reg <= memory_reg [0][7:0];
		end
		else if (psel && !pwrite && penable && select_reg[1]) begin
			value_of_reg <= memory_reg [1][7:0];
		end
		else if (psel && !pwrite && penable && select_reg[2]) begin
			value_of_reg <= memory_reg [2][7:0];
		end
		else if (psel && !pwrite && penable && select_reg[3]) begin
			value_of_reg <= memory_reg [3][7:0];
		end
		else if (psel && !pwrite && penable && select_reg[4]) begin
			value_of_reg <= memory_reg [4][7:0];
		end
		else if (psel && !pwrite && penable && select_reg[5]) begin
			value_of_reg <= memory_reg [5][7:0];
		end
		else if (psel && !pwrite && penable && select_reg[6]) begin
			value_of_reg <= memory_reg [6][7:0];
		end
		else if (psel && !pwrite && penable && select_reg[7]) begin
			value_of_reg <= memory_reg [7][7:0];
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
	 	end
	 end 
//===============================================================================//
	assign prdata = value_of_reg; // get data from internal registor and output
//===============================================================================//

// pslverr - notification error//
	always @(posedge pclk or negedge preset_n) begin
		if (~preset_n) begin
			// reset
			svlerr_reg <= 1'b0;
		end
		else if (select_reg == 8'h00) begin
			svlerr_reg <= 1'b1;
		end
		else begin
			svlerr_reg <= 1'b0;
		end
	end
//=================================================================================//
	assign psvlerr = svlerr_reg;

//----------------------pready-------------------------------//
	always @(posedge pclk or posedge preset_n) begin
		if (~preset_n) begin
			// reset
			ready_reg <= 1'b0;
		end
		else if (select_reg != 8'h00) begin
			ready_reg <= 1'b1;
		end
		else begin
			ready_reg <= 1'b0;
		end
	end

	assign pready = ready_reg;

	
endmodule