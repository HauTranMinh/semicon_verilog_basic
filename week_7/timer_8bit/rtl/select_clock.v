module select_clock(
	//I/O ports declare here
	input pclk,
	input preset_n,
	input [1:0] cks,
	output int_clk);
	
reg select_clock;
reg clk2, clk4, clk8, clk16;

assign int_clk = select_clock;


always @(cks) begin
	case(cks)
		2'b00: select_clock = clk2;
		2'b01: select_clock = clk4;
		2'b10: select_clock = clk8;
		2'b11: select_clock = clk16;
	endcase
end
// decisre here
always @(posedge pclk or negedge preset_n) begin
	if(~preset_n)begin
		clk2 <= 1'b0;
	end
	else begin
		clk2  <= ~clk2;
	end
end

always @(posedge clk2 or negedge preset_n) begin
	if(~preset_n) begin
		clk4 <= 1'b0;	
	end
	else begin 
		clk4 <= ~clk4;
	end
end

always @(posedge clk4 or negedge preset_n) begin
	if(~preset_n) begin
		clk8 <= 1'b0;
	end
	else begin
		clk8 <= ~clk8;
	end
end

always @(posedge clk8 or negedge preset_n) begin
	if(~preset_n) begin
		clk16 <= 1'b0;
	end
	else begin
		clk16 <= ~clk16;
	end
end	
endmodule	
