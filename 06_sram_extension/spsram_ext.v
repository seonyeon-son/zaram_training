`include "spsram.v"

module sram_extension
#(
	parameter	BW_DATA = 64,
	parameter	BW_ADDR	= 6
)
(
	input		[BW_DATA-1:0] 	i_data,
	input		[BW_DATA-1:0]	i_addr,
	input						i_wen,
	input						i_cen,
	input						i_oen,
	input						i_clk,
	ouput		[BW_DATA-1:0]	o_data
);

	wire	add_00, add_01, add_10, add_11;

	assign	add_00 = (i_addr[5:4] == 2'b00);
	assign	add_01 = (i_addr[5:4] == 2'b01);
	assign	add_10 = (i_addr[5:4] == 2'b10);
	assign	add_11 = (i_addr[5:4] == 2'b11);
spsram	
#(
	.BW_DATA		(32	),
	.BW_ADDR		(4	)
)
u_spsram_0(
	.o_data			(o_data[63:32]	),
	.i_data			(i_data[63:32]	),
	.i_addr			(i_addr[3:0]	),
	.i_wen			(i_wen			),
	.i_cen			(i_cen && add_00),
	.i_oen			(i_oen && add_00),
	.i_clk			(i_clk			)
);

spsram	
#(
	.BW_DATA		(32	),
	.BW_ADDR		(4	)
)
u_spsram_1(
	.o_data			(o_data[31:0]	),
	.i_data			(i_data[31:0]	),
	.i_addr			(i_addr[3:0]	),
	.i_wen			(i_wen			),
	.i_cen			(i_cen && add_00),
	.i_oen			(i_oen && add_00),
	.i_clk			(i_clk			)
);

spsram	
#(
	.BW_DATA		(32	),
	.BW_ADDR		(4	)
)
u_spsram_2(
	.o_data			(o_data[63:32]	),
	.i_data			(i_data[63:32]	),
	.i_addr			(i_addr[3:0]	),
	.i_wen			(i_wen			),
	.i_cen			(i_cen && add_01),
	.i_oen			(i_oen && add_01),
	.i_clk			(i_clk			)
);


spsram	
#(
	.BW_DATA		(32	),
	.BW_ADDR		(4	)
)
u_spsram_3(
	.o_data			(o_data[31:0]	),
	.i_data			(i_data[31:0]	),
	.i_addr			(i_addr[3:0]	),
	.i_wen			(i_wen			),
	.i_cen			(i_cen && add_01),
	.i_oen			(i_oen && add_01),
	.i_clk			(i_clk			)
);

spsram	
#(
	.BW_DATA		(32	),
	.BW_ADDR		(4	)
)
u_spsram_4(
	.o_data			(o_data[63:32]	),
	.i_data			(i_data[63:32]	),
	.i_addr			(i_addr[3:0]	),
	.i_wen			(i_wen			),
	.i_cen			(i_cen && add_10),
	.i_oen			(i_oen && add_10),
	.i_clk			(i_clk			)
);

spsram	
#(
	.BW_DATA		(32	),
	.BW_ADDR		(4	)
)
u_spsram_5(
	.o_data			(o_data[31:0]	),
	.i_data			(i_data[31:0]	),
	.i_addr			(i_addr[3:0]	),
	.i_wen			(i_wen			),
	.i_cen			(i_cen && add_10),
	.i_oen			(i_oen && add_10),
	.i_clk			(i_clk			)
);

spsram	
#(
	.BW_DATA		(32	),
	.BW_ADDR		(4	)
)
u_spsram_6(
	.o_data			(o_data[63:32]	),
	.i_data			(i_data[63:32]	),
	.i_addr			(i_addr[3:0]	),
	.i_wen			(i_wen			),
	.i_cen			(i_cen && add_11),
	.i_oen			(i_oen && add_11),
	.i_clk			(i_clk			)
);

spsram	
#(
	.BW_DATA		(32	),
	.BW_ADDR		(4	)
)
u_spsram_7(
	.o_data			(o_data[31:0]	),
	.i_data			(i_data[31:0]	),
	.i_addr			(i_addr[3:0]	),
	.i_wen			(i_wen			),
	.i_cen			(i_cen && add_11),
	.i_oen			(i_oen && add_11),
	.i_clk			(i_clk			)
);

endmodule
