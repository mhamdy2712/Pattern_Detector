module tb_pattern_detector;
	parameter pattern_bits = 30;
	parameter tb_pattern = 30'b101011110100001011011101011001;
	reg my_pattern;
	reg rst = 0;
	reg pattern_found;
	parameter clk_prd = 10ns;
	reg clk = 0;
	always #(clk_prd/2) clk = ~clk;
	pattern_detector my_detector(
		.clk(clk),
		.rst(rst),
		.pattern(my_pattern),
		.pattern_found(pattern_found)
	);
	task detect_pattern(
		input [pattern_bits-1:0] test_pattern
	);
		$display("Input pattern: %b",test_pattern);
		rst=1;
		#(clk_prd);
		rst=0;
		for(int i=pattern_bits-1;i>=0;i=i-1) begin
			my_pattern = test_pattern[i];
			#(clk_prd);
			if(pattern_found)
				$display("at bit number %d: Pattern Found",pattern_bits-i);
			else
				$display("at bit number %d: Pattern Not Found",pattern_bits-i);
		end
	endtask
	initial begin
		detect_pattern(tb_pattern);
		$finish();
	end
endmodule
