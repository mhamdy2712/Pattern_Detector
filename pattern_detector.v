module pattern_detector(
	input pattern,
	input clk,
	input rst,
	output reg pattern_found
);
	parameter state_reg_width = 3;
	parameter [state_reg_width : 0] start = 3'b000,
									found_1= 3'b001,
									found_11= 3'b010,
									found_110= 3'b011,
									found_1101= 3'b100,
									found_11010= 3'b101;
	reg [state_reg_width : 0] curr_state, next_state;
	
	//next state register
	always @(posedge clk) begin
		if(rst)
			curr_state <= start;
		else
			curr_state <= next_state;
	end
	
	//next state logic
	always @(*) begin
		pattern_found = 0;
		case(curr_state)
			start: next_state = (pattern) ? found_1 : start;
          	found_1: next_state = (pattern) ? found_11 : start;
			found_11: next_state = (pattern) ? found_11 : found_110;
			found_110: next_state = (pattern) ? found_1101 : start;
			found_1101: next_state = (pattern) ? found_11 : found_11010;
			found_11010: begin
							next_state = (pattern) ? found_1 : start;
							pattern_found = 1;
						end
		endcase
	end
endmodule