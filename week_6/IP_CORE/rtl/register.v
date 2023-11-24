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
	// reg [7:0] memory_reg [7:0];
	reg [7:0] reg_A, reg_B, reg_C, reg_D, reg_E, reg_F, reg_G, reg_H;
	reg svlerr_reg;
	reg [7:0] data_reg; 
	reg [5:0] count;
	reg ready_reg;

//=======================================================================================//	
	assign psvlerr = svlerr_reg;
	assign prdata = data_reg;
	assign pready = ready_reg;

	
//=======================================================================================//	
	always @(posedge pclk or negedge preset_n) begin
	 	if (~preset_n) begin
	 		// reset low => assign all the memory register to 8'b0000_0000
	 		reg_A <= 8'b0000_0000;
	 		reg_B <= 8'b0000_0000;
	 		reg_C <= 8'b0000_0000;
	 		reg_D <= 8'b0000_0000;
			reg_E <= 8'b0000_0000;
	 		reg_F <= 8'b0000_0000;
	 		reg_G <= 8'b0000_0000;
	 		reg_H <= 8'b0000_0000;
	 		// reset slave error bit
	 		svlerr_reg <= 1'b0;
	 	end
//=======================================================================================//
//==================== ABB protocol write transfer process===============================//
	 	else if (psel && pwrite && penable && pready) begin
	 		case (select_reg)
	 			8'b0000_0001: reg_A <= pwdata; //svlerr_reg <= 1'b0;
	 			8'b0000_0010: reg_B <= pwdata; //svlerr_reg <= 1'b0;
	 			8'b0000_0100: reg_C <= pwdata; //svlerr_reg <= 1'b0;
	 			8'b0000_1000: reg_D <= pwdata; //svlerr_reg <= 1'b0;
	 			8'b0001_0000: reg_E <= pwdata; //svlerr_reg <= 1'b0;
	 			8'b0010_0000: reg_F <= pwdata; //svlerr_reg <= 1'b0;
	 			8'b0100_0000: reg_G <= pwdata; //svlerr_reg <= 1'b0;
	 			8'b1000_0000: reg_H <= pwdata; //svlerr_reg <= 1'b0;
	 			// if access address is reserved
	 			default: svlerr_reg <= 1'b1; 
	 		endcase
	 	end
//=====================================================================================//
	 	else begin
	 		reg_A <= reg_A;
	 		reg_B <= reg_B;
	 		reg_C <= reg_C;
	 		reg_D <= reg_D;
			reg_E <= reg_E;
	 		reg_F <= reg_F;
	 		reg_G <= reg_G;
	 		reg_H <= reg_H;
	 		// normal state 
	 		svlerr_reg <= 1'b0;
	 	end
	 end 
//===============================================================================//
//===================encoder APB protocol==================================//
//=================================================================================//

	always @(psel or pclk or penable or pready or pwrite) begin
		if (psel && pready && ~pwrite && penable) begin
			case(select_reg)
				8'b0000_0001: data_reg = reg_A;
	 			8'b0000_0010: data_reg = reg_B;
	 			8'b0000_0100: data_reg = reg_C;
	 			8'b0000_1000: data_reg = reg_D;
	 			8'b0001_0000: data_reg = reg_E;
	 			8'b0010_0000: data_reg = reg_F;
	 			8'b0100_0000: data_reg = reg_G;
	 			8'b1000_0000: data_reg = reg_H;
	 			// if access address is reserved
	 			default: data_reg = 8'hXX; 
			endcase
		end
		else begin
			data_reg = 8'h00;
		end
	end
//===============================================================================//
//===================pready APB protocol=========================================//
//=================================================================================//
	`define WAIT_CYCLES 2
	always @(posedge pclk or negedge preset_n) begin
	    if (~preset_n) begin
	      ready_reg <= 1'b0;
	      count <= 6'h00;
	    end
	    else if (psel && penable && count == 6'b00_00_00) begin // end of access
	      ready_reg <= 1'b0;
	    end
	    else if (psel)begin
	      if (count == `WAIT_CYCLES) begin
	        count <= 6'b00_00_00;
	        #1;
	        ready_reg <= 1'b1;
	      end 
	      else begin
	        count <= count + 6'b0000_0001;
	      end
	    end 
	    else begin
	      ready_reg <= 1'b0;
	    end
  end
	
//=================================================================================//
	
endmodule