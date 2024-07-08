module shift_register
#(
	parameter N = 8
)
(
	input			clk,
	input			load,
	input			Sin,
	input	[N-1:0]	D,
	output	[N-1:0]	Q,
	output			Sout
);

	mux_f 
	u_mux_f_0(
		.clk	(clk		),
		.in0	(Sin		),
		.in1	(D[0]		),
		.sel	(load		),
		.out	(Q[0]		)
	);

	mux_f
	u_mux_f_1(
		.clk	(clk		),
		.in0	(Q[0]		),
		.in1	(D[1]		),
		.sel	(load		),
		.out	(Q[1]		)
	);

	mux_f
	u_mux_f_2(
		.clk	(clk		),
		.in0	(Q[1]		),
		.in1	(D[2]		),
		.sel	(load		),
		.out	(Q[2]		)
	);

	mux_f
	u_mux_f_3(
		.clk	(clk		),
		.in0	(Q[2]		),
		.in1	(D[3]		),
		.sel	(load		),
		.out	(Q[3]		)
	);

	mux_f
	u_mux_f_4(
		.clk	(clk		),
		.in0	(Q[3]		),
		.in1	(D[4]		),
		.sel	(load		),
		.out	(Q[4]		)
	);

	mux_f
	u_mux_f_5(
		.clk	(clk		),
		.in0	(Q[4]		),
		.in1	(D[5]		),
		.sel	(load		),
		.out	(Q[5]		)
	);

	mux_f
	u_mux_f_6(
		.clk	(clk		),
		.in0	(Q[5]		),
		.in1	(D[6]		),
		.sel	(load		),
		.out	(Q[6]		)
	);

	mux_f
	u_mux_f_7(
		.clk	(clk		),
		.in0	(Q[6]		),
		.in1	(D[7]		),
		.sel	(load		),
		.out	(Q[7]		)
	);

	assign Sout = Q[7];

endmodule

//---------------------------------------------------
//mux_f
//---------------------------------------------------
module mux_f (
	input		in0,
	input		in1,
	input		sel,
	input		clk,
	output reg	out
);

	wire		out_mux;

	assign out_mux = (sel) ? in1 : in0;

	always@ (posedge clk) out = out_mux;

endmodule
			






