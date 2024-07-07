module gray_to_bin
#(
	parameter	N = 8
)
(
	input	[N-1:0] gray,
	output	[N-1:0] bin
);

	assign bin[N-1] = gray[N-1];

	genvar i;
	generate
		for (i=0; i<N-1; i=i+1) begin
			assign bin[i] = bin[i+1]^gray[i];
		end
	endgenerate

endmodule

