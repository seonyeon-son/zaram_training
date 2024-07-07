module bin_to_gray #(
	parameter N = 8
)(
	input [N-1:0] bin,
	output [N-1:0] gray
);

	assign gray[N-1] = bin[N-1];

	genvar i;
	generate
		for (i=0; i<N-1; i=i+1) begin
			assign gray[i] = bin[i+1] ^ bin[i];
		end
	endgenerate

endmodule

