module decoder (
	input pclk, preset_n, psel, penable, pwrite;
	input [7:0] paddr, pwdata;
	output pready, psvlerr);
// INTERNAL CONNECTION //
	reg [7:0] select_reg;
	reg [7:0] reg_A;
	reg [7:0] reg_B;
	reg [7:0] reg_C;
	reg [7:0] reg_D;
	reg [7:0] reg_E;
	reg [7:0] reg_F;
	reg [7:0] reg_G;
	reg [7:0] reg_H;
//---------------------------------------------------------------//
// DECODER //
	always @() begin
		case (paddr)
			8'h00: select_reg = 8'h01; // thanh A
			8'h01: select_reg = 8'h02; // thanh B
			8'h02: select_reg = 8'h04; // thanh C
			8'h03: select_reg = 8'h08; // thanh D
			8'h04: select_reg = 8'h10; // thanh E
			8'h05: select_reg = 8'h20; // thanh F
			8'h06: select_reg = 8'h40; // thanh G
			8'h07: select_reg = 8'h80; // thanh H
			default: select_reg = 8'h00; //reserved 8 -> ff
		endcase
	end
//--------------------------------------------------------------//
// REGSITOR //

// for reg_A //
	always @(posedge pclk or negedge preset_n) begin
		if (~preset_n) begin
			// reset
			reg_A <= 8'h00;
			// tuong tu với bcd.....h
		end
		else if (psel && pwrite && penable && pready && select_reg[0]) begin
			reg_A <= pwdata;
		end
		else begin
			reg_A <= reg_A;
		end
	end
// tuong tu như A //
// for reg_B //
	always @(posedge pclk or negedge preset_n) begin
		if (~preset_n) begin
			// reset
			reg_B <= 8'h00;
			// tuong tu với bcd.....h
		end
		else if (psel && pwrite && penable && pready && select_reg[1]) begin
			reg_B <= pwdata;
		end
		else begin
			reg_B <= reg_B;
		end
	end
// tuong tu với cái reg khác //


// pslverr - notification error//
	always @(posedge pclk or negedge preset_n) begin
		if (~preset_n) begin
			// reset
			psvlerr <= 1'b0;
		end
		else if (select_reg == 8'h00) begin
			psvlerr <= 1'b1;
		end
		else begin
			psvlerr <= 1'b0;
		end
	end


//  done  //

endmodule