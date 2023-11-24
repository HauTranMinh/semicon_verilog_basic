module timer_pready(
	input psel,
	input pclk,
	input preset_n,
	input penable,

	output pready);
//--------------------------------define parameter----------------------------------------------//
	`define WAIT_CYCLES 2
//--------------------------------internal registor----------------------------------------------//
	reg ready_reg;
	reg [5:0] count; //maximum delay 64 cycles

//--------------------------------internal registor----------------------------------------------//
	assign pready = ready_reg;

	always @(posedge pclk or negedge preset_n) begin
	    if (~preset_n) begin
	      ready_reg <= 1'b0;
	      count <= 6'b00_00_00;
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
endmodule