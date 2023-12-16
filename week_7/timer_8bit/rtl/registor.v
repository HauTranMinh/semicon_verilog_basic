module registor(
	input pclk, 
	input preset_n,
	input psel,
	input penable,
	input pwrite,
	input [2:0] select_reg, 	// memory reg address
	input [7:0] pwdata,		// data for transfer
	input pready,
	input overflow_flag,
	input underflow_flag,

	output [1:0] clear_flag,
	output [7:0] TDR,
	output [7:0] TCR,
	output [7:0] TSR,
	output pslverr);

//--------------------------------internal connector reg-----------------------------------//
	reg [7:0] TDR_reg;
	reg [7:0] TCR_reg;
	reg [1:0] TSR_reg;
	reg pslverr_reg;
	reg [1:0] clear_reg;
//-----------------------------------------------------------------------------------------//
	assign TDR = TDR_reg;
	assign TCR = TCR_reg;
	assign pslverr = pslverr_reg;
	assign clear_flag = clear_reg;
	assign TSR = {6'b000_000, TSR_reg[1], TSR_reg[0]};
//-----------------------------------------------------------------------------------------//
//-----------------TDR REG-----------------------------------------------------------------//
	always @(posedge pclk or posedge preset_n) begin
		if (~preset_n) begin
			// reset active low
			TDR_reg <= 8'h00;
		end
		else if (psel && pwrite && penable && pready && select_reg[0]) begin
			TDR_reg <= pwdata;
		end
		else begin
			TDR_reg <= TDR_reg;
		end
	end
//-----------------TCR REG-----------------------------------------------------------------//
	always @(posedge pclk or posedge preset_n) begin
		if (~preset_n) begin
			TCR_reg <= 8'h00;
		end
		else if (psel && pwrite && penable && pready && select_reg[1]) begin
			TCR_reg <= pwdata;
		end
		else begin
			TCR_reg <= TCR_reg;
		end
	end
//-----------------TSR REG-----------------------------------------------------------------//
	// S_TMR_OVF
	always @(posedge pclk or posedge preset_n) begin
		// TSR process
		if (~preset_n) begin
			TSR_reg [1:0] <= 2'b00; // set flag == 0;
			clear_reg[1:0] <= 2'b00; 
		end
		else if ((psel) && (penable) && (pready) && select_reg[2] && 
				 (pwdata[1:0] != 2'b11) && (~TSR_reg[1] || TSR_reg[1] && (~pwdata[0]))) begin
			//TSR_reg[0] 	<= pwdata[0]; // write 0 by software
			//TSR_reg[1] 	<= TSR_reg[1];
			TSR_reg[0] <= 1'b0;
			clear_reg[0] 	<= 1'b0;
			 		
		end
		else if(overflow_flag) begin  // write 1 by hardware
			TSR_reg[0] <= 1'b1;
			clear_reg[0] <= 1'b1;
		end
		else begin // both hardware and software take no action
			TSR_reg[0] <= TSR_reg[0];
			clear_reg[0] <= clear_reg[0];
		end
	end

	// S_TMR_UDF 
	always @(posedge pclk or posedge preset_n) begin
		// TSR process
		if (~preset_n) begin
			TSR_reg [1:0] <= 2'b00;
			clear_reg[1:0] <= 2'b00;
		end
		else if ((psel) && (penable) && (pready) && select_reg[2] &&
				 (pwdata[1:0] != 2'b11) && (~TSR_reg[0] || TSR_reg[0] && (~pwdata[1]))) begin
			//TSR_reg[1] <= 1'b0;
			TSR_reg[1] 	<= 1'b0;
			clear_reg[1] 	<= 1'b0;
		end
		else if(underflow_flag) begin
			TSR_reg[1] <= 1'b1;
			clear_reg[1] <= 1'b1;
		end
		else begin // both hardware and software take no action
			TSR_reg[1] <= TSR_reg[1];
			clear_reg[1] <= clear_reg[1];
		end
	end

//-----------------------------------------ERROR process------------------------------------------//
	always @(posedge pclk or negedge preset_n) begin
		if (~preset_n) begin
			// reset
			pslverr_reg <= 1'b0;	
		end
		else if (select_reg == 3'b000) begin
			pslverr_reg <= 1'b1;
		end
		else begin
			pslverr_reg <= 1'b0;
		end
	end

endmodule
